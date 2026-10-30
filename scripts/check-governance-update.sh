#!/usr/bin/env bash
# .governance/scripts/check-governance-update.sh
# Universal AI-SDLC Hybrid Version Detector & Non-Destructive Self-Updater
# Supports Local Master Directory & Cloud GitHub Repository (if-instrument/AI_SDLC)
# Version: 1.0.0

set -e

MODE="${1:---check}"
TARGET_PROJECT_DIR="${2:-$(pwd)}"

# Deteksi direktori .governance di proyek target
if [ -d "$TARGET_PROJECT_DIR/.governance" ]; then
    GOV_DIR="$TARGET_PROJECT_DIR/.governance"
elif [ -f "$TARGET_PROJECT_DIR/CORE-RULES.md" ] && [ -d "$TARGET_PROJECT_DIR/hooks" ]; then
    GOV_DIR="$TARGET_PROJECT_DIR"
else
    GOV_DIR="$TARGET_PROJECT_DIR/.governance"
fi

# Ekstrak versi lokal proyek saat ini
get_local_version() {
    if [ -f "$GOV_DIR/VERSION" ]; then
        grep -E '^VERSION=' "$GOV_DIR/VERSION" | head -n 1 | cut -d'"' -f2
    elif [ -f "$GOV_DIR/CORE-RULES.md" ]; then
        grep -E '^# Version:' "$GOV_DIR/CORE-RULES.md" | head -n 1 | sed -E 's/.*Version:[[:space:]]*([0-9]+\.[0-9]+\.[0-9]+).*/\1/'
    else
        echo "NOT_INSTALLED"
    fi
}

LOCAL_VER=$(get_local_version)

# Cari sumber Master AI_SDLC (Prioritas 1: Local Master Dir, Prioritas 2: GitHub Cloud)
DEFAULT_MASTER_DIR="/Users/imamfaisal/Documents/Other Project/AI_SDLC"
SIBLING_MASTER_DIR="$(cd "$TARGET_PROJECT_DIR/.." 2>/dev/null && pwd)/AI_SDLC"
UPSTREAM_REPO="if-instrument/AI_SDLC"

if [ -f "$GOV_DIR/VERSION" ]; then
    CFG_MASTER=$(grep -E '^LOCAL_MASTER_DIR=' "$GOV_DIR/VERSION" | head -n 1 | cut -d'"' -f2 || true)
    CFG_REPO=$(grep -E '^UPSTREAM_REPO=' "$GOV_DIR/VERSION" | head -n 1 | cut -d'"' -f2 || true)
    [ -n "$CFG_MASTER" ] && DEFAULT_MASTER_DIR="$CFG_MASTER"
    [ -n "$CFG_REPO" ] && UPSTREAM_REPO="$CFG_REPO"
fi

SOURCE_TYPE=""
SOURCE_PATH=""
LATEST_VER=""
LATEST_HIGHLIGHTS=""

if [ -n "$AI_SDLC_HOME" ] && [ -f "$AI_SDLC_HOME/CORE-RULES.md" ]; then
    SOURCE_TYPE="LOCAL"
    SOURCE_PATH="$AI_SDLC_HOME"
elif [ -f "$DEFAULT_MASTER_DIR/CORE-RULES.md" ]; then
    SOURCE_TYPE="LOCAL"
    SOURCE_PATH="$DEFAULT_MASTER_DIR"
elif [ -f "$SIBLING_MASTER_DIR/CORE-RULES.md" ]; then
    SOURCE_TYPE="LOCAL"
    SOURCE_PATH="$SIBLING_MASTER_DIR"
fi

if [ "$SOURCE_TYPE" = "LOCAL" ]; then
    if [ -f "$SOURCE_PATH/VERSION" ]; then
        LATEST_VER=$(grep -E '^VERSION=' "$SOURCE_PATH/VERSION" | head -n 1 | cut -d'"' -f2)
        LATEST_HIGHLIGHTS=$(grep -E '^RELEASE_HIGHLIGHTS=' "$SOURCE_PATH/VERSION" | head -n 1 | cut -d'"' -f2)
    else
        LATEST_VER=$(grep -E '^# Version:' "$SOURCE_PATH/CORE-RULES.md" | head -n 1 | sed -E 's/.*Version:[[:space:]]*([0-9]+\.[0-9]+\.[0-9]+).*/\1/')
    fi
else
    # Fallback ke GitHub Cloud jika Local Master tidak ditemukan dan gh tersedia
    if command -v gh &>/dev/null; then
        CLOUD_MANIFEST=$(gh api "repos/${UPSTREAM_REPO}/contents/VERSION" --jq .content 2>/dev/null | base64 -d 2>/dev/null || true)
        if [ -n "$CLOUD_MANIFEST" ]; then
            SOURCE_TYPE="CLOUD"
            SOURCE_PATH="$UPSTREAM_REPO"
            LATEST_VER=$(echo "$CLOUD_MANIFEST" | grep -E '^VERSION=' | head -n 1 | cut -d'"' -f2)
            LATEST_HIGHLIGHTS=$(echo "$CLOUD_MANIFEST" | grep -E '^RELEASE_HIGHLIGHTS=' | head -n 1 | cut -d'"' -f2)
        fi
    fi
fi

if [ -z "$LATEST_VER" ]; then
    echo "ℹ️  [GOVERNANCE UPDATE CHECK] Sumber Master AI_SDLC tidak ditemukan di lokal maupun GitHub Cloud ($UPSTREAM_REPO). Versi aktif: $LOCAL_VER."
    exit 0
fi

# Bandingkan versi
if [ "$MODE" = "--check" ]; then
    if [ "$LOCAL_VER" = "NOT_INSTALLED" ]; then
        echo "======================================================================"
        echo "⚠️  [AI-SDLC NOT INSTALLED] Proyek ini belum memiliki folder .governance/!"
        echo "   Versi Master Terbaru : v$LATEST_VER (Sumber: $SOURCE_TYPE - $SOURCE_PATH)"
        echo "   Fitur Terbaru        : $LATEST_HIGHLIGHTS"
        echo "   Jalankan perintah berikut untuk meng-install AI-SDLC ke proyek ini:"
        echo "   bash \"$SOURCE_PATH/scripts/check-governance-update.sh\" --apply \"$TARGET_PROJECT_DIR\""
        echo "======================================================================"
        exit 0
    elif [ "$LOCAL_VER" != "$LATEST_VER" ]; then
        echo "======================================================================"
        echo "🔔 [PEMBARUAN AI-SDLC TERSEDIA] Versi proyek ini tertinggal!"
        echo "   Versi Proyek Saat Ini : v$LOCAL_VER"
        echo "   Versi Master Terbaru  : v$LATEST_VER (Sumber: $SOURCE_TYPE - $SOURCE_PATH)"
        echo "   Pembaruan Utama       : $LATEST_HIGHLIGHTS"
        echo ""
        echo "   Untuk memperbarui .governance/ proyek ini secara aman (tanpa menghapus"
        echo "   data .ai/TEAM-BOARD.md atau docs/), jalankan:"
        echo "   bash .governance/scripts/check-governance-update.sh --apply"
        echo "======================================================================"
        exit 0
    else
        echo "✅ [AI-SDLC UP-TO-DATE] Proyek ini sudah menggunakan versi terbaru (v$LOCAL_VER)."
        exit 0
    fi
fi

if [ "$MODE" = "--apply" ]; then
    TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
    TRASH_DIR="$TARGET_PROJECT_DIR/.trash/governance-backup-$LOCAL_VER.$TIMESTAMP"
    mkdir -p "$TRASH_DIR"

    echo "🔄 Memulai pembaruan AI-SDLC dari v$LOCAL_VER ke v$LATEST_VER (Sumber: $SOURCE_TYPE)..."

    # Backup .governance lama jika ada
    if [ -d "$TARGET_PROJECT_DIR/.governance" ]; then
        cp -R "$TARGET_PROJECT_DIR/.governance" "$TRASH_DIR/.governance.bak"
        echo "📦 Backup .governance lama disimpan di: $TRASH_DIR/.governance.bak"
    fi

    # Backup GEMINI.md di root jika ada
    if [ -f "$TARGET_PROJECT_DIR/GEMINI.md" ]; then
        cp "$TARGET_PROJECT_DIR/GEMINI.md" "$TRASH_DIR/GEMINI.md.bak"
    fi

    mkdir -p "$TARGET_PROJECT_DIR/.governance"

    if [ "$SOURCE_TYPE" = "LOCAL" ]; then
        for item in CORE-RULES.md IDENTITY-SECURITY.md README.md WORKFLOW-STATE-MACHINE.md VERSION adapters docs-reference hooks scripts templates; do
            if [ -e "$SOURCE_PATH/$item" ]; then
                rm -rf "$TARGET_PROJECT_DIR/.governance/$item"
                cp -R "$SOURCE_PATH/$item" "$TARGET_PROJECT_DIR/.governance/$item"
            fi
        done
    elif [ "$SOURCE_TYPE" = "CLOUD" ]; then
        TMP_CLONE=$(mktemp -d)
        gh repo clone "$UPSTREAM_REPO" "$TMP_CLONE" -- --depth 1
        for item in CORE-RULES.md IDENTITY-SECURITY.md README.md WORKFLOW-STATE-MACHINE.md VERSION adapters docs-reference hooks scripts templates; do
            if [ -e "$TMP_CLONE/$item" ]; then
                rm -rf "$TARGET_PROJECT_DIR/.governance/$item"
                cp -R "$TMP_CLONE/$item" "$TARGET_PROJECT_DIR/.governance/$item"
            fi
        done
        rm -rf "$TMP_CLONE"
    fi

    # Sinkronisasi entrypoint GEMINI.md di root proyek jika ada
    if [ -f "$TARGET_PROJECT_DIR/.governance/adapters/GEMINI.md" ]; then
        cp "$TARGET_PROJECT_DIR/.governance/adapters/GEMINI.md" "$TARGET_PROJECT_DIR/GEMINI.md"
    fi

    # Inisialisasi .ai/ jika proyek belum memilikinya (TANPA menimpa jika sudah ada!)
    mkdir -p "$TARGET_PROJECT_DIR/.ai/plans" "$TARGET_PROJECT_DIR/.ai/checklists"
    if [ ! -f "$TARGET_PROJECT_DIR/.ai/TEAM-BOARD.md" ] && [ -f "$TARGET_PROJECT_DIR/.governance/templates/TEAM-BOARD.template.md" ]; then
        cp "$TARGET_PROJECT_DIR/.governance/templates/TEAM-BOARD.template.md" "$TARGET_PROJECT_DIR/.ai/TEAM-BOARD.md"
    fi
    if [ ! -f "$TARGET_PROJECT_DIR/.ai/current-task.md" ] && [ -f "$TARGET_PROJECT_DIR/.governance/templates/current-task.template.md" ]; then
        cp "$TARGET_PROJECT_DIR/.governance/templates/current-task.template.md" "$TARGET_PROJECT_DIR/.ai/current-task.md"
    fi

    # Aktifkan permissions & git hooks jika di dalam git repo
    chmod +x "$TARGET_PROJECT_DIR/.governance/hooks/"* "$TARGET_PROJECT_DIR/.governance/scripts/"* 2>/dev/null || true
    if [ -d "$TARGET_PROJECT_DIR/.git" ]; then
        git -C "$TARGET_PROJECT_DIR" config core.hooksPath .governance/hooks || true
    fi

    echo "✅ BERHASIL: AI-SDLC pada '$TARGET_PROJECT_DIR' telah diperbarui ke v$LATEST_VER!"
    echo "   (Data progres .ai/TEAM-BOARD.md, .ai/current-task.md, dan docs/ tetap utuh)."
    exit 0
fi

echo "Usage: $0 [--check | --apply] [target_project_dir]"
exit 1
