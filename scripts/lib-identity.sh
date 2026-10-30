#!/usr/bin/env bash
# .governance/scripts/lib-identity.sh
# Universal gh-Only Anti-Spoofing & Identity Library
# Version: 1.0.0 | Scope: Portable Identity Validation

# Memastikan GitHub CLI terpasang dan dapat diakses
gov_require_gh() {
    if ! command -v gh &>/dev/null; then
        echo "❌ [AUTH ERROR] GitHub CLI ('gh') tidak terpasang di sistem." >&2
        echo "   Silakan pasang 'gh' terlebih dahulu untuk melanjutkan." >&2
        return 1
    fi
    return 0
}

# Mendapatkan login pengguna GitHub yang aktif (fail-closed jika belum login / offline)
gov_get_auth_user() {
    gov_require_gh || return 1
    local user
    user=$(gh api user --jq .login 2>/dev/null || echo "")
    if [ -z "$user" ]; then
        echo "❌ [AUTH ERROR] Sesi GitHub CLI belum terotentikasi atau jaringan tidak dapat diakses." >&2
        echo "   Sistem tata kelola menolak aksi tanpa otentikasi resmi." >&2
        echo "   Silakan login terlebih dahulu melalui terminal:" >&2
        echo "      gh auth login" >&2
        return 1
    fi
    echo "$user"
    return 0
}

# Mendapatkan repositori aktif (owner/name) secara dinamis dari GitHub API atau remote git
gov_get_repo() {
    gov_require_gh || return 1
    local repo
    repo=$(gh repo view --json nameWithOwner --jq .nameWithOwner 2>/dev/null || echo "")
    if [ -z "$repo" ]; then
        # Fallback ekstraksi dari git remote origin
        local remote_url
        remote_url=$(git config --get remote.origin.url 2>/dev/null || echo "")
        repo=$(echo "$remote_url" | sed -E 's/.*github\.com[:\/]([^\/]+\/[^\/\.]+)(\.git)?$/\1/' | sed 's/\.git$//')
    fi
    if [ -z "$repo" ]; then
        echo "❌ [AUTH ERROR] Gagal mendeteksi repositori GitHub aktif." >&2
        return 1
    fi
    echo "$repo"
    return 0
}

# Mendapatkan level permission pengguna pada repositori (admin, maintain, write, triage, read, none)
gov_get_user_permission() {
    local target_user="$1"
    if [ -z "$target_user" ]; then
        echo "❌ [AUTH ERROR] Pengguna target tidak ditentukan." >&2
        return 1
    fi
    local repo
    repo=$(gov_get_repo) || return 1
    local perm
    perm=$(gh api "repos/${repo}/collaborators/${target_user}/permission" --jq .permission 2>/dev/null || echo "none")
    echo "$perm"
    return 0
}
