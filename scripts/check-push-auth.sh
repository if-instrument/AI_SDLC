#!/bin/bash
# .governance/scripts/check-push-auth.sh
# Dynamic Pre-Push Identity & Role-Based Authorization Validator
# 100% Portable - Zero Hardcoding
# Version: 2.0.0

set -e

TARGET_BRANCH="${1:-$(git branch --show-current 2>/dev/null || echo "unknown")}"

echo "🔐 [PRE-PUSH AUTH CHECK] Memeriksa otorisasi push untuk branch: '$TARGET_BRANCH'..."

# 1. Periksa ketersediaan gh
if ! command -v gh &> /dev/null; then
    echo "❌ SECURITY DENIED: GitHub CLI ('gh') tidak terinstall di sistem ini. Push dibatalkan."
    exit 1
fi

# 2. Ambil akun GitHub aktif dari token resmi
ACTIVE_USER=$(gh api user --jq '.login' 2>/dev/null || true)

if [ -z "$ACTIVE_USER" ]; then
    echo "❌ SECURITY DENIED: Tidak ada sesi GitHub aktif yang terotentikasi. Jalankan 'gh auth login'."
    exit 1
fi

echo "   Identitas Peminta: @$ACTIVE_USER"

# 3. Deteksi Repositori Target Secara Dinamis (Tanpa Hardcode)
REPO_INFO=$(gh repo view --json owner,name 2>/dev/null || true)

if [ -z "$REPO_INFO" ]; then
    echo "⚠️ PERINGATAN: Repositori remote GitHub tidak dapat dideteksi via 'gh repo view'."
    echo "   Memeriksa konfigurasi remote git..."
    REMOTE_URL=$(git remote get-url origin 2>/dev/null || echo "")
    if [ -z "$REMOTE_URL" ]; then
        echo "❌ SECURITY DENIED: Tidak ada git remote 'origin' yang terdaftar. Push dibatalkan."
        exit 1
    fi
    # Ekstrak owner/repo dari remote URL (mendukung https dan git@github.com)
    REPO_PATH=$(echo "$REMOTE_URL" | sed -E 's#.*github\.com[:/]([^/]+/[^/.]+)(\.git)?#\1#')
    REPO_OWNER=$(echo "$REPO_PATH" | cut -d '/' -f 1)
    REPO_NAME=$(echo "$REPO_PATH" | cut -d '/' -f 2)
else
    REPO_OWNER=$(echo "$REPO_INFO" | jq -r '.owner.login')
    REPO_NAME=$(echo "$REPO_INFO" | jq -r '.name')
fi

echo "   Target Repositori: $REPO_OWNER/$REPO_NAME"

# 4. Deteksi Hak Akses Pengembang di Repositori (Role-Based Permissions)
USER_PERMISSION=$(gh api "repos/$REPO_OWNER/$REPO_NAME/collaborators/$ACTIVE_USER/permission" --jq '.permission' 2>/dev/null || echo "none")
echo "   Level Izin Pengguna: $USER_PERMISSION"

# 5. Validasi Otorisasi Berdasarkan Tipe Branch & Level Izin
case "$TARGET_BRANCH" in
    feature/*|development|master|main)
        # Branch milestone atau upstream HANYA boleh di-push oleh admin/owner repositori
        if [ "$USER_PERMISSION" != "admin" ]; then
            echo "❌ SECURITY DENIED: Branch '$TARGET_BRANCH' adalah Protected Milestone/Upstream Branch!"
            echo "   Hanya Repository Admin / Project Owner (level izin: 'admin') yang berhak melakukan push/merge."
            echo "   Level izin Anda pada repositori $REPO_OWNER/$REPO_NAME adalah: '$USER_PERMISSION'."
            exit 2
        fi
        echo "✅ OTORISASI DITERIMA: Akun @$ACTIVE_USER terverifikasi sebagai Repository Admin / Project Owner."
        ;;
    task/*)
        # Branch level task diperbolehkan untuk developer dengan hak write atau admin
        if [ "$USER_PERMISSION" != "admin" ] && [ "$USER_PERMISSION" != "write" ]; then
            echo "❌ SECURITY DENIED: Anda tidak memiliki hak 'write' pada repositori $REPO_OWNER/$REPO_NAME."
            exit 2
        fi
        echo "✅ OTORISASI DITERIMA: Push ke task branch '$TARGET_BRANCH' diizinkan untuk @$ACTIVE_USER (Izin: $USER_PERMISSION)."
        ;;
    *)
        # Branch lainnya wajib memiliki minimal izin write
        if [ "$USER_PERMISSION" != "admin" ] && [ "$USER_PERMISSION" != "write" ]; then
            echo "❌ SECURITY DENIED: Level izin '$USER_PERMISSION' tidak mencukupi untuk melakukan push."
            exit 2
        fi
        echo "✅ OTORISASI DITERIMA: Disahkan untuk @$ACTIVE_USER (Izin: $USER_PERMISSION)."
        ;;
esac

exit 0
