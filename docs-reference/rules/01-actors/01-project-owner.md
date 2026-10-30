# PIAGAM & ATURAN AKTOR 1: HUMAN PROJECT OWNER, PRODUCT OWNER & TECH LEAD
# Version: 2.0.0 | Date: 2026-10-30 | Authority: Supreme Arbiter & Agile Product Owner

## 1. Definisi Peran & Kedudukan
Human Project Owner, **Agile Product Owner (PO)** & Tech Lead adalah pemilik akun organisasi/repositori terpusat (GitHub/GitLab) dan pengambil keputusan tertinggi (*Supreme Arbiter*) baik dari segi visi produk, memaksimalkan nilai bisnis (*Value Maximization*), manajemen **Product Backlog**, maupun arsitektur teknis global.
Seluruh visi sistem, penetapan **Sprint Goal**, prioritas backlog (*MoSCoW*), dan alokasi sumber daya berada di bawah kendali mutlak Aktor 1.

---

## 2. Hak Prerogatif Eksklusif (Exclusive Authorities)
Aktor 1 memegang wewenang mutlak yang **TIDAK BOLEH DIAMBIL ALIH ATAU DIASUMSIKAN** oleh AI mana pun:

1. **Otoritas Tunggal Product Backlog & Sprint Goal (Product Ownership Authority)**:
   - Satu-satunya peran yang berhak menetapkan **Sprint Goal**, menyetujui prioritas **Epics & User Stories** pada *Product Backlog*, serta mengesahkan masuknya item ke dalam **Sprint Backlog** pada sesi *Sprint Planning*.
   - Menentukan pilihan **Dual Execution Mode** di awal Sprint/Milestone (`WORK TEAM` untuk tim Scrum paralel atau `INDIVIDU` untuk solo Agile developer).
2. **Hak Eksklusif Gate 3 (Pre-Merge Authorization - Anti Self-Approval)**:
   - Satu-satunya peran yang berhak memeriksa diff Pull Request di web GitHub/GitLab, memvalidasi bukti Gate 1 & Gate 2 (*Definition of Done Level 1 & 2*), dan menekan tombol merge (**"proses"**).
   - Penggabungan ke branch `feature/*`, `development`, atau `master` mutlak memerlukan approval dari Aktor 1.
3. **Hak Prerogatif Delegasi Penugasan Sprint & Re-Assignment (Sprint Planning Assignment Authority)**:
   - Satu-satunya peran yang berhak menentukan, mendelegasikan, atau mengalihkan *Sprint Backlog Item* kepada *Scrum Developer* / kolaborator.
   - **Wewenang Re-Assignment**: Jika kolaborator yang diajukan tidak dapat ditemukan atau gagal divalidasi di GitHub, Aktor 1 memegang wewenang eksklusif untuk menetapkan akun kolaborator pengganti (*re-assignment*). AI dilarang keras berasumsi atau melanjutkan dengan akun yang tidak terverifikasi.
4. **Wewenang Pembersihan Branch Pasca-Merge (Branch Pruning Authority)**:
   - Satu-satunya peran yang berhak mengesahkan dan mengeksekusi penghapusan task branch yang telah berstatus `MERGED`, baik di lokal (`git branch -d`) maupun di remote GitHub (`git push origin --delete`).
5. **Keputusan Arsitektur & Bisnis Fundamental**:
   - Pemilihan stack teknologi, skema database inti, kontrak API publik, aturan finansial/keamanan, dan keputusan rilis produksi (*Production Release Deployment*).
6. **Imunitas dari Diktat Operasional & Persona AI**:
   - Aktor 1 memiliki imunitas mutlak terhadap arahan dari AI untuk berganti konfigurasi identitas Git (`user.name`/`user.email`) ke akun pengembang modul atau beralih cabang ke unit tugas pengembang (`task/*`).
   - AI wajib menghormati keberadaan Aktor 1 di cabang integrasi Sprint (`feature/*`) dan mendampingi dalam status **STANDBY**, tanpa mencampuradukkan peran kepemilikan produk dengan pekerjaan teknis modul sekalipun dioperasikan oleh individu fisik yang sama.
7. **Hak Prerogatif Pengesahan Akhir Sprint Review / Gate 4 (Increment Acceptance Authority)**:
   - Satu-satunya peran yang berhak menginspeksi *Increment* dan menguji checklist penerimaan pasca-merge pada **Sprint Review (Gate 4)** (`.ai/checklists/CHECKLIST-<TASK>-GATE-4-ACCEPTANCE.md`).
   - Menetapkan vonis resmi apakah *Sprint Increment* dinyatakan `COMPLETED` (diterima penuh sesuai *Definition of Done* dan siap di-PR ke `development`) atau `REVISE` (dikembalikan ke *Sprint Execution*). AI dilarang menutup Sprint atau membuka Sprint berikutnya sebelum Gate 4 disahkan oleh Aktor 1.

---

## 3. Batasan & Prinsip Efisiensi
- Human Product Owner & Tech Lead **TIDAK PERLU** menulis dokumentasi *User Story*, spesifikasi teknis, atau kode secara manual; AI bertugas merumuskannya secara profesional (lengkap dengan *Acceptance Criteria Given-When-Then* dan estimasi *Story Points*) untuk ditinjau dan disetujui.
- Setiap usulan perubahan fundamental wajib diajukan dalam bentuk proposal/implementation plan atau *Change Request (CR)* yang jelas sebelum dieksekusi.
