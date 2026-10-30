#!/bin/bash
# .governance/scripts/ensure-gh.sh
# Multi-OS GitHub CLI Auto-Installer & Verifier
# Supported OS: macOS (Darwin), Linux (Debian/Ubuntu/Fedora/CentOS/Arch), Windows (Git Bash/MSYS/MINGW)
# Version: 2.0.0

set -e

echo "🔍 Memeriksa ketersediaan GitHub CLI ('gh')..."

if command -v gh &> /dev/null; then
    GH_VER=$(gh --version | head -n 1)
    echo "✅ GitHub CLI sudah terpasang: $GH_VER"
else
    echo "⚠️ GitHub CLI ('gh') belum terpasang di mesin ini."
    echo "🚀 Memulai proses instalasi otomatis..."

    OS_TYPE="$(uname -s 2>/dev/null || echo "Windows_NT")"

    case "$OS_TYPE" in
        Darwin*)
            echo "🍎 Terdeteksi macOS (Darwin)..."
            if command -v brew &> /dev/null; then
                echo "   Menginstall via Homebrew..."
                brew install gh
            else
                echo "   Homebrew tidak ditemukan. Mendownload biner standalone resmi..."
                ARCH="$(uname -m)"
                if [ "$ARCH" = "arm64" ]; then
                    GH_ARCH="macOS_arm64"
                else
                    GH_ARCH="macOS_amd64"
                fi
                TMP_DIR=$(mktemp -d)
                LATEST_URL=$(curl -s https://api.github.com/repos/cli/cli/releases/latest | grep "browser_download_url.*_${GH_ARCH}.tar.gz\"" | cut -d : -f 2,3 | tr -d ' "')
                curl -sSL "$LATEST_URL" -o "$TMP_DIR/gh.tar.gz"
                tar -xzf "$TMP_DIR/gh.tar.gz" -C "$TMP_DIR"
                sudo cp "$TMP_DIR"/gh_*/bin/gh /usr/local/bin/ || cp "$TMP_DIR"/gh_*/bin/gh "$HOME/.local/bin/"
                rm -rf "$TMP_DIR"
            fi
            ;;
        Linux*)
            echo "🐧 Terdeteksi Linux..."
            if command -v apt-get &> /dev/null; then
                echo "   Menginstall via APT (Debian/Ubuntu)..."
                (type -p wget >/dev/null || (sudo apt-get update && sudo apt-get install -y wget))
                sudo mkdir -p -m 755 /etc/apt/keyrings
                wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null
                sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
                echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
                sudo apt-get update
                sudo apt-get install -y gh
            elif command -v dnf &> /dev/null; then
                echo "   Menginstall via DNF (Fedora/RHEL)..."
                sudo dnf install -y 'dnf-command(config-manager)' || true
                sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo || true
                sudo dnf install -y gh
            elif command -v pacman &> /dev/null; then
                echo "   Menginstall via Pacman (Arch Linux)..."
                sudo pacman -Sy --noconfirm github-cli
            else
                echo "   Mendownload biner Linux standalone..."
                ARCH="$(uname -m)"
                if [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
                    GH_ARCH="linux_arm64"
                else
                    GH_ARCH="linux_amd64"
                fi
                TMP_DIR=$(mktemp -d)
                LATEST_URL=$(curl -s https://api.github.com/repos/cli/cli/releases/latest | grep "browser_download_url.*_${GH_ARCH}.tar.gz\"" | cut -d : -f 2,3 | tr -d ' "')
                curl -sSL "$LATEST_URL" -o "$TMP_DIR/gh.tar.gz"
                tar -xzf "$TMP_DIR/gh.tar.gz" -C "$TMP_DIR"
                sudo cp "$TMP_DIR"/gh_*/bin/gh /usr/local/bin/ || cp "$TMP_DIR"/gh_*/bin/gh "$HOME/.local/bin/"
                rm -rf "$TMP_DIR"
            fi
            ;;
        MINGW*|MSYS*|CYGWIN*|Windows_NT)
            echo "🪟 Terdeteksi Windows..."
            if command -v winget.exe &> /dev/null; then
                echo "   Menginstall via Winget (Windows 10/11)..."
                winget.exe install --id GitHub.cli -e --source winget --accept-source-agreements --accept-package-agreements
            elif command -v choco.exe &> /dev/null; then
                echo "   Menginstall via Chocolatey..."
                choco.exe install gh -y
            elif command -v scoop.exe &> /dev/null; then
                echo "   Menginstall via Scoop..."
                scoop.exe install gh
            else
                echo "   Menginstall via PowerShell Standalone ZIP..."
                powershell.exe -NoProfile -Command "
                    \$latest = (Invoke-RestMethod https://api.github.com/repos/cli/cli/releases/latest).tag_name.TrimStart('v');
                    \$url = \"https://github.com/cli/cli/releases/download/v\$latest/gh_\${latest}_windows_amd64.zip\";
                    \$dest = \"\$env:TEMP\gh.zip\";
                    Invoke-WebRequest -Uri \$url -OutFile \$dest;
                    Expand-Archive -Path \$dest -DestinationPath \"\$env:LOCALAPPDATA\Microsoft\WindowsApps\" -Force;
                    Remove-Item \$dest;
                "
            fi
            ;;
        *)
            echo "❌ Sistem operasi tidak dikenali: $OS_TYPE"
            exit 1
            ;;
    esac
fi

# 2. Verifikasi Instalasi
if ! command -v gh &> /dev/null; then
    echo "❌ ERROR: Gagal menginstall GitHub CLI secara otomatis."
    exit 1
fi

echo "✅ GitHub CLI siap digunakan: $(gh --version | head -n 1)"

# 3. Verifikasi Status Otentikasi
echo "🔐 Memeriksa status login GitHub..."
if gh auth status &> /dev/null; then
    AUTH_USER=$(gh api user --jq '.login' 2>/dev/null || echo "Unknown")
    echo "✅ Sesi GitHub aktif terverifikasi: @$AUTH_USER"
else
    echo "⚠️ PERINGATAN: GitHub CLI belum terotentikasi."
    echo "👉 Silakan jalankan 'gh auth login' di terminal untuk mengaktifkan sesi GitHub Anda."
fi
