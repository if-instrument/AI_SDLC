# Agile Scrum DoD & Quality Assurance Multi-Gate Checklist: <TASK-ID>

> [!CAUTION]
> **MULTI-GATE STRICT TESTING DOMAIN SEPARATION (SCRUM DEFINITION OF DONE)**:
> - **Gate 0, Gate 1, Gate 3**: Domain AI & Platform (Otomatis & Deterministik).
> - **Gate 2 & Gate 4**: Domain Eksklusif Human (Scrum Developer / Product Owner).
> - **AI DILARANG KERAS**: Melakukan testing operasional pengganti manusia atau mencentang `[x] PASSED` secara sepihak!
> - **TUGAS AI PADA GATE 2 & 4**: Menyusun skenario *Given-When-Then*, langkah pengujian, dan ekspektasi hasil dengan status awal `[ ] PENDING`, lalu STOP TOTAL. AI hanya boleh menandai `[x] PASSED` setelah manusia memberikan instruksi eksplisit.

---

## Konteks Agile & User Story (Definition of Ready - DoR)
- **Sprint ID & Goal**: `SPRINT-XX` — `<Sprint Goal>`
- **User Story ID**: `US-XXX` (`<Story Points> SP`)
- **Narasi User Story**:
  > **Sebagai** `<peran pengguna>`, **Saya ingin** `<fitur/tindakan>`, **Agar** `<nilai bisnis>`.
- [ ] **DoR Verified**: User Story, Acceptance Criteria, Story Points, dan Identitas Developer (`gh api user`) telah terverifikasi.

---

## Gate 1 (DoD Level 1): Automated Verification (AI Worker Domain)
- [ ] Unit tests & integration tests 100% PASS (`go test ./...` / test runner terkait).
- [ ] Linter & static analysis 0 errors.
- [ ] Zero compile/build errors & zero data race.

---

## Gate 2 (DoD Level 2): Manual Human & Acceptance Criteria Verification (Human Scrum Developer Exclusive Domain)
*Pengujian operasional manual dan validasi kriteria penerimaan (Given-When-Then) wajib dilakukan langsung di terminal atau runtime oleh developer manusia.*

### Skenario Pengujian Acceptance Criteria (BDD Given-When-Then):
1. **AC-1 (Happy Path - `<Judul Skenario>`)**:
   - **Given (Prasyarat)**: ...
   - **When (Langkah Eksekusi)**: ...
   - **Then (Hasil yang Diharapkan)**: ...
   - **Hasil Pengujian**: [ ] LULUS / [ ] GAGAL
2. **AC-2 (Edge Case / Negative Case - `<Judul Skenario>`)**:
   - **Given (Prasyarat)**: ...
   - **When (Langkah Eksekusi)**: ...
   - **Then (Hasil yang Diharapkan)**: ...
   - **Hasil Pengujian**: [ ] LULUS / [ ] GAGAL

### Bukti Log Terminal / Runtime:
```text
(Salin cuplikan log terminal output pengujian di sini)
```

### Keputusan Gate 2 (Centang salah satu oleh Human Developer):
- [ ] PENDING (Menunggu pengujian manual oleh developer)
- [ ] PASSED (Seluruh skenario pengujian manual & Acceptance Criteria terverifikasi berhasil)
- [ ] FAILED (Ditemukan kegagalan/cacat pada pengujian operasional)

---

## Gate 3 (DoD Level 3): Pre-Merge Review, Burndown Sync & Platform Sign-Off (AI & GitHub PO Domain)
- [ ] AI memvalidasi kelengkapan Gate 1 & Gate 2 serta menyiapkan diff summary.
- [ ] Pull Request ditinjau dan disetujui di GitHub oleh Product Owner.
- [ ] PR di-merge ke branch integrasi Sprint (`feature/*`).
- [ ] Story Points diperbarui pada **Sprint Burndown & Velocity Tracker** di `.ai/TEAM-BOARD.md`.
- [ ] Remote task branch dihapus di GitHub (`git push origin --delete task/...`).

---

## Gate 4 (DoD Level 4 - Sprint Review & Retrospective): Final Acceptance (Human Product Owner Exclusive Domain)
*Pengujian integrasi Increment end-to-end terhadap Sprint Goal wajib diverifikasi langsung oleh Human Product Owner.*

### Skenario Sprint Review Smoke Test Integrasi:
1. **Skenario Integrasi 1 (`<Kesesuaian dengan Sprint Goal>`)**:
   - **Langkah**: ...
   - **Hasil yang Diharapkan**: ...
   - **Hasil Pengujian**: [ ] LULUS / [ ] GAGAL

### Ringkasan Sprint Retrospective:
- **Velocity Pencapaian**: `<Completed SP> / <Committed SP> Story Points`
- **What Went Well**: ...
- **What Needs Improvement (Loopback / RCA Notes)**: ...
- **Action Items for Next Sprint**: ...

### Keputusan Gate 4 / Sprint Review (Centang salah satu oleh Human Product Owner):
- [ ] PENDING (Menunggu pengujian Sprint Review smoke test oleh Product Owner)
- [ ] COMPLETED (Increment resmi diterima sesuai DoD dan siap diajukan PR ke development)
- [ ] REVISE (Ditemukan cacat integrasi, kembali ke Sprint Execution untuk perbaikan)
