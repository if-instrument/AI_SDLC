# PROTOKOL KEAMANAN IDENTITAS & ANTI-SPOOFING GITHUB
# Version: 2.0.0 | Scope: gh-Only Cryptographic Token Verification | Zero Hardcode

## 1. Latar Belakang & Ancaman Manipulasi Lokal

Konfigurasi standar Git lokal (`git config user.name` dan `git config user.email`) adalah string teks tanpa perlindungan kriptografis. Siapa pun dapat mengubah nilai tersebut secara bebas di terminal lokal untuk menyamar sebagai developer lain.

> [!CAUTION]
> **ATURAN MUTLAK IDENTITAS**:
> `git config user.name` dan `user.email` **DILARANG KERAS** digunakan sebagai bukti sah identitas pengembang oleh Asisten AI, Git hook, maupun dokumen tata kelola.
> Seluruh verifikasi identitas **HANYA SAH** jika dieksekusi melalui token resmi GitHub CLI (`gh`).
> Jika GitHub CLI offline atau belum terotentikasi, seluruh aksi berstatus **FAIL-CLOSED (DITOLAK KERAS)** sampai pengguna menjalankan `gh auth login`.

---

## 2. Arsitektur Verifikasi Identitas gh-Only

```mermaid
flowchart TD
    Req["Aksi Pengembang / AI (Checkout, Plan, Commit, Push, PR)"] --> V1{"Vektor 1: Sesi Token Aktif<br/>(gh api user --jq .login)"}
    
    V1 -->|Belum Login / Offline| RejectAuth["🛑 FAIL-CLOSED REJECT:<br/>Tolak seketika -> Arahkan 'gh auth login'"]
    V1 -->|Sesi Sah (@username)| V2{"Vektor 2: Hak Akses Repositori Dinamis<br/>(gh api repos/{owner}/{repo}/collaborators/{user}/permission)"}
    
    V2 --> Match{"Kesesuaian dengan Penugasan<br/>.ai/TEAM-BOARD.md & Cabang"}
    Match -->|Mismatch / Bukan Penugasannya| RejectBranch["❌ AKSES DITOLAK:<br/>Bukan cabang tugas Anda! Rollback / Blokir."]
    Match -->|Valid & Cocok| Approve["✅ Akses Sah Diberikan"]
```

---

## 3. Implementasi Teknis Pengecekan

### Vektor 1: Verifikasi Sesi Token Aktif GitHub
Pengecekan akun dilakukan langsung ke endpoint resmi GitHub API melalui `lib-identity.sh`:
```bash
gh api user --jq '{login: .login, id: .id}'
```
- **Karakteristik**: Membaca kredensial OAuth / PAT yang tersimpan di keychain aman sistem. Nilai diverifikasi langsung oleh server GitHub dan mustahil dimanipulasi melalui modifikasi teks repositori lokal.

### Vektor 2: Verifikasi Hak Akses Repositori Dinamis
Memeriksa izin kolaborator akun aktif pada repositori (nama repositori dideteksi dinamis tanpa hardcode):
```bash
REPO=$(gh repo view --json nameWithOwner --jq .nameWithOwner)
gh api "repos/${REPO}/collaborators/${username}/permission" --jq '.permission'
```
- **Matriks Wewenang**:
  - `admin`: Memiliki wewenang Project Owner. Berhak mengesahkan milestone, mengelola tata kelola di `feature/*`, melakukan push ke `feature/*`, dan merge PR.
  - `write`: Memiliki wewenang Developer / Collaborator. Berhak melakukan commit/push di cabang tugas (`task/*`) yang didelegasikan kepadanya.
  - `read` / `none`: Akses diblokir total untuk modifikasi kode atau branch.

---

## 4. Pustaka Otomasi & Git Hooks Terpadu

1. **`lib-identity.sh`** (`.governance/scripts/lib-identity.sh`):
   Pustaka fungsi terpusat yang digunakan oleh seluruh Git hook (`pre-commit`, `pre-push`, `post-checkout`) dan skrip verifikasi.
2. **`verify-identity.sh`** (`.governance/scripts/verify-identity.sh`):
   Validator CLI untuk memeriksa keselarasan sesi aktif dengan penugasan sebelum checkout.
3. **`check-push-auth.sh`** (`.governance/scripts/check-push-auth.sh`):
   Validator izin dorong remote sebelum `git push` atau `gh pr create`.
