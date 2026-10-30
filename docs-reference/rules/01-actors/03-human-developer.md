# PIAGAM & ATURAN AKTOR 3: HUMAN DEVELOPER (SCRUM DEVELOPER & MANUAL ACCEPTANCE TESTER)
# Version: 3.0.0 | Date: 2026-10-30 | Role: Scrum Developer, Implementation Specialist & Gate 2 Verifier

> [!NOTE]
> Dokumen ini adalah spesifikasi rujukan detail peran Human Developer. Jika terdapat pertentangan, `.governance/CORE-RULES.md` adalah Single Source of Truth tertinggi yang berlaku.

## 1. Definisi Peran & Kedudukan
Human Developer adalah anggota **Scrum Development Team** (engineer pelaksana) yang ditugaskan secara resmi pada sesi *Sprint Planning* oleh Human Product Owner & Tech Lead untuk mengeksekusi item **Sprint Backlog** pada dedicated task branch (`task/TASK-XXX-<ROLE>`) atau feature branch (pada mode *Solo Agile*).
Human Developer bekerja secara berpasangan (*AI-Human Pair Programming*) dengan Local Worker AI Assistant di lingkungan kerja lokalnya untuk menghasilkan *Increment* yang memenuhi **Definition of Done (DoD)**.

---

## 2. Hak Prerogatif Eksklusif (Exclusive Authorities)
1. **Persetujuan Rencana Teknis Sprint Task (`implementation_plan.md`)**:
   - Meninjau desain teknis yang diajukan oleh Worker AI terhadap **User Story (`US-XXX`)** dan **Acceptance Criteria**, serta menekan tombol **"Proceed / Proses"** untuk mengizinkan penulisan kode.
2. **Hak Eksklusif Gate 2 (DoD Level 2: Human Verification & User Story Acceptance Test)**:
   - Satu-satunya peran yang berhak menguji checklist verifikasi fungsional nyata dan skenario **Given-When-Then** di terminal/runtime lokal aktual (`.ai/checklists/CHECKLIST-<TASK>.md`).
   - Satu-satunya peran yang berhak memberikan tanda verifikasi `[x] PASSED` pada Gate 2. AI DILARANG keras mencentang kotak checklist ini atas inisiatif sendiri.
3. **Otorisasi Eksekusi Git di Branch Tugas**:
   - Memberikan izin kepada Worker AI untuk menjalankan `git add`, `git commit`, `git push origin task/...`, dan membuka Pull Request formal ke branch integrasi Sprint (`feature/*`).
   - Git hook `pre-push` secara mekanis memverifikasi bahwa checklist Gate 2 telah ditandai `[x] PASSED` sebelum transmisi push diizinkan.
4. **Pemberian Umpan Balik Perbaikan (Sprint Loopback Authority)**:
   - Jika dalam pengujian manual ditemukan kecacatan, bug, atau ketidaksesuaian terhadap *User Story Acceptance Criteria*, berhak menolak hasil kerja dan menginstruksikan perbaikan loopback (RCA + Plan Version Bump) hingga kriteria **Definition of Done** terpenuhi.

---

## 3. Tanggung Jawab & Otentikasi GitHub Sesi Aktif
1. **Otentikasi Resmi GitHub CLI (`gh auth login`)**:
   - Human Developer wajib memastikan sesi GitHub CLI (`gh`) di komputer lokalnya aktif dan terotentikasi ke akun yang didelegasikan pada *Sprint Backlog*:
     ```bash
     gh auth status
     ```
   - Sistem tata kelola menolak keras penggunaan `git config user.name/email` sebagai bukti identitas.
   - Jika belum login atau sesi tidak cocok dengan penugasan pada `.ai/TEAM-BOARD.md`, seluruh aksi checkout, koding, commit, dan push akan ditolak secara otomatis (*Fail-Closed*).
2. **Kolaborasi Daily Scrum & Sinkronisasi Kode**:
   - Memastikan catatan *Daily Standup* (Done, Doing, Blockers) mencerminkan kondisi riil dan branch kerja selalu tersinkronisasi dengan branch Sprint (`feature/*`) sebelum membuka Pull Request.
3. **Etika Percabangan & Post-Merge Cleanup**:
   - Pada mode `WORK TEAM`, membuka Pull Request hanya ke branch integrasi Sprint (`feature/*`), bukan langsung ke `development` atau `master`.
   - Menghormati isolasi domain kerja dan tidak memodifikasi file tata kelola (`.governance/`) dari cabang tugas (`task/*`).
   - Menyetujui penghapusan remote branch `task/*` di GitHub segera setelah PR di-merge.
