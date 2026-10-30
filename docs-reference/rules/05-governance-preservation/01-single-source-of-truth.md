# STRUKTUR DOKUMENTASI SEBAGAI SUMBER KEBENARAN TUNGGAL (SINGLE SOURCE OF TRUTH)
# Version: 2.3.0 | Date: 2026-10-30 | Scope: Agile Scrum Documentation Hierarchy (`docs/00`–`11` with Early Infrastructure at `05` & Visual UI Mockups at `08`), Sequential Blueprint Approval Gates & Status Lifecycle

## 1. Hierarki Sumber Kebenaran (Sprint 0 System Blueprints)
Seluruh implementasi perangkat lunak dan manajemen proyek Agile/Scrum tunduk mutlak pada dokumentasi sistem di folder `docs/` yang disusun secara sekuensial dari Hulu ke Hilir melalui **5 Tahap Wawancara & Blueprinting (Sprint 0)**:

```text
docs/
├── 00-project-overview.md     # [Stage 1] Product Vision, North Star Metric & ringkasan masalah
├── 01-requirements.md         # [Stage 1] Kebutuhan fungsional, non-fungsional & Epics (EPIC-XXX)
├── 02-business-process.md     # [Stage 1] Flowchart alur kerja bisnis end-to-end & exception flow
├── 03-prd.md                  # [Stage 1] User Stories (US-XXX) & Acceptance Criteria (Given-When-Then)
├── 04-architecture.md         # [Stage 2] Komponen arsitektur, tech stack & pola Clean Architecture
├── 05-infrastructure.md       # [Stage 2] DI HULU! Target Hosting, Docker/Native, Engine DB/Cache, Port Mapping, .env & CI/CD
├── 06-database.md             # [Stage 3] Diagram ERD (erDiagram), relasi tabel (1:N, N:M), skema, indexing, seeder
├── 07-api.md                  # [Stage 3] Kontrak REST/WebSocket/gRPC, JSON payload, error model
├── 08-ui-ux.md                # [Stage 4] Visual UI Mockup Images (image-generator .png), Screen Flow & Design Tokens
├── 09-security.md             # [Stage 4] Autentikasi, matriks RBAC, CORS, SSL, enkripsi & model ancaman
├── 10-development-plan.md     # [Stage 5] Granular Product Backlog, Estimasi Story Points & Sprint Roadmap
├── 11-test-plan.md            # [Stage 5] Skenario pengujian Multi-Gate & Definition of Done (DoD)
├── assets/mockups/            # [Stage 4] Folder penyimpanan gambar Visual UI Mockup (.png) & preview HTML
├── changelog.md               # Riwayat versi rilis Increment (Semantic Versioning)
├── changes/                   # Arsip Change Request Backlog (CR-XXX.md)
├── decisions/                 # Arsip Architectural Decision Records (ADR-XXX.md)
└── retrospectives/            # Arsip Evaluasi Sprint Retrospective (RETRO-SPRINT-XX.md)
```

---

## 2. Aturan Ketat & Gerbang Persetujuan Bertahap (*Sequential Blueprint Approval Gates*)
1. **Larangan Koding Tanpa Dokumen Lengkap (`docs/00`–`11`)**:
   - Baik pada mode **`WORK TEAM`** maupun **`INDIVIDU`**, AI **DILARANG KERAS** menulis atau memodifikasi kode aplikasi (`backend/`, `frontend/`, `app/`, `src/`) sebelum kedua belas dokumen (`docs/00-project-overview.md` s.d. `docs/11-test-plan.md`) selesai dibuat dan disetujui (`Status: APPROVED`).
   - Penentuan **Infrastruktur (`05-infrastructure.md`)** wajib dikunci di **Stage 2** sebelum masuk ke perancangan Database (`06`), API (`07`), UI/UX (`08`), Security (`09`), dan Development Plan (`10`) agar AI tidak mengasumsikan infrastruktur secara sepihak.
   - Git Hook `.governance/hooks/pre-commit` secara mekanis memblokir commit file kode aplikasi apabila dokumen fondasi belum lengkap.
2. **Larangan One-Shot Document Generation Tanpa Wawancara**:
   - AI dilarang mengarang kedua belas dokumen tersebut sekaligus secara sepihak. Setiap tahap (**Stage 1 s.d. Stage 5**) wajib melalui wawancara interaktif dengan pengguna, dirangkum dalam `implementation_plan.md` (termasuk menampilkan Flowchart di Stage 1, Diagram Arsitektur & Topologi Infrastruktur di Stage 2, ERD Relasi Tabel di Stage 3, serta Mockup UI & RBAC di Stage 4), dan menunggu tombol **Proceed** ditekan.
3. **Kode Wajib Mengikuti Dokumen & User Story**: Kode program dilarang menyimpang dari spesifikasi dokumen dan *User Story Acceptance Criteria* yang telah disetujui.
4. **Larangan Silent Edits**: Dokumentasi dilarang diubah secara diam-diam hanya untuk membenarkan kode yang salah dibuat.

---

## 3. Siklus Status Dokumen & Backlog (Document & Backlog Status Lifecycle)
Setiap dokumen teknis utama (`docs/00` s.d. `docs/11`) dan *User Story* wajib mencantumkan header metadata status formal:
* `DRAFT / INTERVIEWING`: Dokumen sedang dalam tahap penggalian kebutuhan melalui wawancara pengguna; belum diajukan pada `implementation_plan.md`.
* `HUMAN_REVIEW`: Rancangan isi dokumen (Flowchart, Topologi Infra, ERD, Mockup UI, API) telah diajukan di `implementation_plan.md` dan menunggu persetujuan tombol **Proceed**.
* `APPROVED / READY (DoR)`: Dokumen dan *Acceptance Criteria* telah disetujui resmi oleh Product Owner dan memenuhi *Definition of Ready* sebagai acuan sah implementasi.
* `IMPLEMENTING / IN_PROGRESS`: Kode sedang aktif ditulis oleh Scrum Developer berdasarkan dokumen ini.
* `TESTING / IN_REVIEW`: Kode sedang dalam tahap verifikasi Multi-Gate (**Gate 1 s.d. Gate 4**).
* `RELEASED / DONE (DoD)`: Dokumen dan *Increment* fitur terkait telah lulus **Sprint Review (Gate 4)** dan dirilis ke produksi/staging.
* `SUPERSEDED`: Dokumen telah digantikan oleh versi yang lebih baru (arsip).
