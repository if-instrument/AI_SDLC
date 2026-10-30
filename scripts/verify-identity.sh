#!/usr/bin/env bash
# .governance/scripts/verify-identity.sh
# Universal gh-Only Anti-Spoofing & Identity Validator
# Version: 2.0.0 | Scope: GitHub CLI Token Verification

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$SCRIPT_DIR/lib-identity.sh" ]; then
    # shellcheck source=/dev/null
    source "$SCRIPT_DIR/lib-identity.sh"
else
    echo "❌ [AUTH ERROR] File $SCRIPT_DIR/lib-identity.sh tidak ditemukan." >&2
    exit 1
fi

EXPECTED_USER="$1"

if [ -z "$EXPECTED_USER" ]; then
    echo "Usage: $0 <expected_github_username>"
    exit 1
fi

echo "🔍 Memeriksa sesi otentikasi GitHub CLI..."
CURRENT_GH_USER=$(gov_get_auth_user)
if [ $? -ne 0 ] || [ -z "$CURRENT_GH_USER" ]; then
    exit 1
fi

echo "   Sesi GitHub Aktif: @$CURRENT_GH_USER"

# Bandingkan username (case-insensitive)
CURRENT_LOWER=$(echo "$CURRENT_GH_USER" | tr '[:upper:]' '[:lower:]')
EXPECTED_LOWER=$(echo "$EXPECTED_USER" | tr '[:upper:]' '[:lower:]' | tr -d '@')

if [ "$CURRENT_LOWER" != "$EXPECTED_LOWER" ]; then
    echo "❌ SECURITY ALERT: Akun GitHub aktif (@$CURRENT_GH_USER) TIDAK COCOK dengan yang ditugaskan (@$EXPECTED_USER)!"
    echo "   Pencegahan manipulasi identitas aktif. Akses ditolak."
    exit 2
fi

echo "✅ VALIDASI BERHASIL: Identitas @$CURRENT_GH_USER terverifikasi sah melalui token GitHub."
exit 0
