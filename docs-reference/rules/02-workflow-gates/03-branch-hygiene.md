# PROTOKOL PERCABANGAN DUA TINGKAT & KEBERSIHAN REPOSITORI (BRANCH HYGIENE)
# Version: 2.0.0 | Date: 2026-10-06 | Scope: Git Architecture, Branch Hygiene, gh-Only Identity, Mechanical Gate 2, Post-Merge Cleanup

```text
master / main (Protected Production Release)
  ↑ [Hanya di-merge dari development saat rilis resmi disetujui PO]
development (Protected Staging Integration)
  ↑ [Hanya di-merge dari feature branch setelah lulus Gate 3]
feature/TASK-XXX-... (Dedicated Milestone Integration Branch - EXCLUSIVE TO OWNER)
  ├── task/TASK-XXX-<ROLE-1> (Worker Unit 1 Branch)
  ├── task/TASK-XXX-<ROLE-2> (Worker Unit 2 Branch)
  └── task/TASK-XXX-qa       (Integration Testing & Audit Branch)
```

---

## 1. Aturan Branch Proteksi (Protected Branches)
1. **Branch `master` / `main` (Protected Release)**:
   - Representasi kode produksi yang stabil, bersih, dan teruji penuh. Direct push **DILARANG KERAS**.
2. **Branch `development` (Protected Staging Integration)**:
   - Integration branch utama seluruh tim. Direct push **DILARANG KERAS**.
3. **Branch `feature/TASK-XXX-...` (Milestone Integration Branch)**:
   - Wadah bagi seluruh Worker Unit pada milestone tersebut untuk menyatukan modul sebelum diajukan ke `development`.
   - **DIKELOLA EKSKLUSIF OLEH PROJECT OWNER**. Worker dilarang keras melakukan direct commit/push ke branch ini.

---

## 2. Prinsip Ephemeral Branch, Post-Merge Cleanup & Siklus Hidup Default Branch
1. **Sifat Sementara (*Ephemeral Branches*) & Dual-Branch Baseline**:
   - Seluruh branch dengan prefiks `task/` dan `feature/` adalah branch kerja sementara.
   - Repositori remote GitHub **HANYA MEMPERTAHANKAN 2 CABANG PERSISTEN**: `master` (Production) dan `development` (Staging).
2. **Pembersihan Cabang Tugas (Gate 3 Cleanup)**:
   - Segera setelah Pull Request di-merge ke branch milestone (`feature/*`), task branch tersebut kehilangan fungsi operasionalnya dan **WAJIB DIHAPUS** di remote GitHub (`git push origin --delete task/...`) dan di lokal (`git branch -d task/...`).
3. **Pembersihan Cabang Milestone & Otomatisasi Default Branch (Gate 4 Cleanup)**:
   - **Saat Inisiasi Milestone**: Default branch repositori di GitHub disetel ke `feature/TASK-XXX-...` agar PR worker secara otomatis menargetkan branch integrasi ini.
   - **Saat Penutupan Milestone**: Segera setelah PR `feature/*` $\rightarrow$ `development` selesai di-merge:
     - **Langkah 1**: Default branch GitHub **WAJIB DIKEMBALIKAN** ke **`development`**:
       ```bash
       gh repo edit --default-branch development
       ```
     - **Langkah 2**: Remote feature branch **WAJIB DIHAPUS** di GitHub:
       ```bash
       git push origin --delete feature/TASK-XXX-...
       ```
     - **Langkah 3**: Local branch dihapus menggunakan flag aman:
       ```bash
       git branch -d feature/TASK-XXX-...
       ```
4. **Safety Net Penghapusan Lokal (`git branch -d`)**:
   - Pembersihan branch lokal **WAJIB** menggunakan flag `-d` (menjamin telah ter-merge 100%). Dilarang keras menggunakan `-D` tanpa izin Owner.

---

## 3. Penegakan Git Hooks Lokal (Local Enforcer via `.governance/hooks/`)
1. **Pencegahan Akses, Commit & Push Liar di Terminal**:
   - Repositori menggunakan direktori `.governance/hooks/` yang terversi di Git dan diaktifkan via `git config core.hooksPath .governance/hooks`.
   - Skrip instalasi otomatis tersedia di `.governance/scripts/setup-hooks.sh`.
   - Seluruh hook berjalan **Fail-Closed**: Jika `gh` tidak terpasang atau belum login (`gh auth status` gagal), operasi Git seketika ditolak.
2. **`post-checkout` Hook**:
   - Berjalan seketika saat pengguna melakukan `git checkout <cabang>`.
   - Memvalidasi identitas aktif pengguna via `gh api user`.
   - Membaca penugasan pada `.ai/TEAM-BOARD.md`.
   - Jika pengguna tidak berhak mengakses cabang `task/*` tersebut, hook seketika melakukan **Auto-Rollback** mengembalikan pengguna ke cabang sebelumnya (`@{-1}`).
3. **`pre-commit` Hook**:
   - Memvalidasi identitas aktif via `gh api user`.
   - Melindungi branch `master` dan `development` dari direct commit.
   - Melindungi branch `.governance/` dari perubahan liar oleh Worker di cabang `task/*` (Domain Isolation).
   - Memvalidasi bahwa committer adalah assignee sah di `.ai/TEAM-BOARD.md`.
4. **`pre-push` Hook (Mechanical Gate 2 Enforcer)**:
   - Memvalidasi identitas GitHub CLI.
   - Melarang direct push ke `master`, `development`, dan `feature/*` bagi non-Owner/Worker.
   - Pada branch `task/*`: **MEMBLOKIR PUSH / PR** secara mekanis jika checklist verifikasi manusia (`.ai/checklists/CHECKLIST-<TASK>.md`) belum memiliki status validasi `[x] PASSED`.

---

## 4. Proteksi Eksklusif Cabang Integrasi Feature dari Worker
1. **Larangan Direct Commit / Push bagi Worker**:
   - Cabang `feature/*` adalah cabang integrasi arsitektural yang dikontrol penuh oleh Human Project Owner & Lead Orchestrator.
   - Developer dengan peran Worker (seluruh pengembang yang didelegasikan pada cabang `task/*` di `.ai/TEAM-BOARD.md`) **DILARANG KERAS** melakukan direct commit atau direct push ke cabang `feature/*`.
2. **Penolakan Keras oleh Git Hook**:
   - Skrip `.governance/hooks/pre-commit` dan `.governance/hooks/pre-push` secara otomatis mendeteksi jika committer beridentitas Worker di cabang `feature/*`, dan **WAJIB MENGGAGALKAN OPERASI (Exit 1)** seketika.
   - Worker hanya diizinkan bekerja di cabang `task/*` dan menyerahkan hasil kerja melalui Pull Request resmi (Gate 3).

---

## 5. Kedaulatan Identitas GitHub CLI & Larangan Manipulasi Identitas
1. **GitHub CLI Sebagai Satu-Satunya Sumber Kebenaran Identitas**:
   - Identitas Git lokal (`git config user.name` dan `git config user.email`) sangat mudah dimanipulasi dan **TIDAK DIAKUI** sebagai bukti identitas dalam tata kelola ini.
   - Seluruh otorisasi mengacu strictly pada akun GitHub aktif yang terotentikasi melalui GitHub CLI (`gh api user`).
2. **Larangan Mutlak AI Mengubah Identitas & Anti-Spoofing**:
   - Asisten AI **DILARANG KERAS** menjalankan perintah `git config user.name ...` atau `git config user.email ...` secara otomatis atau menyarankan perubahan tersebut untuk menyamar (*anti-spoofing*).
   - AI dan Git Hook **DILARANG KERAS** membocorkan nama akun penerima tugas resmi (*zero information leakage*).
   - Jika terdeteksi ketidakcocokan identitas (*mismatch*), sistem **HANYA MENYATAKAN AKSES DITOLAK** dan menginstruksikan pengguna untuk kembali ke cabang tugasnya sendiri atau login dengan akun GitHub yang benar (`gh auth login`).
3. **Panduan Cerdas Pengembalian Developer (Smart Branch Routing)**:
   - Saat penolakan terjadi, Git Hook dan AI secara otomatis memindai [`.ai/TEAM-BOARD.md`](.ai/TEAM-BOARD.md) untuk mendeteksi apakah akun GitHub aktif memiliki cabang tugas yang didelegasikan kepadanya.
   - Jika terdaftar, sistem menyebutkan nama cabang tugas sah milik pengguna tersebut dan menyajikan perintah navigasi langsung (`git checkout <cabang_milik_user>`).
   - Jika akun tidak terdaftar di board, sistem mengarahkan pengguna untuk menghubungi Project Owner.
4. **Protokol Pembalikan Otomatis Pasca-Checkout (Auto-Rollback on Unauthorized Checkout)**:
   - Jika pengguna berpindah ke cabang tugas pengembang (`task/*`) sementara akun GitHub aktif terdeteksi tidak sesuai dengan penugasan sah di [`.ai/TEAM-BOARD.md`](.ai/TEAM-BOARD.md):
     - Hook [`.governance/hooks/post-checkout`](.governance/hooks/post-checkout) secara otomatis **MEMBATALKAN CHECKOUT** dan seketika mengembalikan posisi kerja pengguna ke cabang asalnya (`@{-1}`).
     - Menjamin pengguna tidak tertahan di cabang yang tidak berhak diaksesnya (*zero unauthorized branch stay*).

---

## 6. Larangan Berpindah Cabang Otomatis Pasca-Merge (Post-Merge Branch Retention)
1. **Prinsip Tetap di Cabang Integrasi**:
   - Setelah branch atau Pull Request berhasil di-merge (misal: penggabungan task branch ke `feature/*`, atau `feature/*` ke `development`/`master`), AI **DILARANG KERAS** berpindah (`git checkout`) ke cabang lain secara otomatis.
2. **Kepatuhan Sesi Project Owner**:
   - Posisi kerja aktif Project Owner dan Lead AI **WAJIB TETAP BERADA** di cabang target integrasi (`feature/*`), mempertahankan kondisi *clean workspace* dalam status **STANDBY**, dan menunggu instruksi eksplisit berikutnya dari pengguna manusia.
