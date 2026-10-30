# UNIVERSAL AI-SDLC CORE OPERATIONAL RULES (SOP)
# Version: 7.2.0 | Scope: Universal Agile Scrum, Sprint 0 Blueprinting (`docs/00`–`11`), Early Infrastructure, Zero-Approval Sandbox & Auto-Update | Single Source of Truth

---

## 🚫 10 LARANGAN MUTLAK ASISTEN AI (ABSOLUTE DIRECTIVES)

> [!CAUTION]
> **ATURAN MUTLAK BERIKUT BERLAKU SETIAP SAAT TANPA PENGECUALIAN**:
> 1. **IDENTITAS GH-ONLY**: Identitas HANYA sah via `gh api user` + Permission API. `git config` DILARANG KERAS dipakai sebagai bukti identitas di rule, hook, maupun respons AI. Jika `gh` belum login / offline, seluruh aksi berstatus FAIL-CLOSED (ditolak).
> 2. **NO-EDIT TANPA PLAN, DoR, SPRINT 0 BLUEPRINT (`docs/00`–`11`) & PROCEED**:
>    - Dilarang memodifikasi file apa pun (termasuk folder `.ai/` dan perbaikan atas teguran) tanpa `implementation_plan.md` yang telah disetujui melalui tombol "Proceed".
>    - **DILARANG KERAS MENULIS KODE APLIKASI (`backend/`, `frontend/`, `app/`, `src/`) SEBELUM SELURUH DOKUMEN `docs/00` S.D. `docs/11` SELESAI DIGALI MELALUI WAWANCARA MENDALAM (5-STAGE INTERACTIVE DISCOVERY) DAN DISETUJUI (`APPROVED`) SECARA BERTAHAP OLEH PENGGUNA!**
>    - **DILARANG MENGIMAJINASIKAN / MENGARANG DESAIN & INFRASTRUKTUR SEPIHAK (*NO AI SOLO IMAGINATION & NO ONE-SHOT FULLSTACK*)**: Baik pada mode `WORK TEAM` maupun `INDIVIDU`, AI dilarang mengasumsikan sendiri proses bisnis, arsitektur, **infrastruktur/deployment (`docs/05-infrastructure.md`)**, ERD relasi database (`docs/06-database.md`), kontrak API (`docs/07-api.md`), maupun wireframe/mockup UI/UX (`docs/08-ui-ux.md`) tanpa wawancara dan persetujuan per tahap dokumen.
> 3. **DISIPLIN TRASH & ZERO-APPROVAL WORKSPACE SANDBOX**:
>    - Seluruh file yang akan dimodifikasi wajib dibackup ke `.trash/<file>.<timestamp>.bak` sebelum disentuh.
>    - Gunakan tool file bawaan (`write_file`, `edit_file`, `read_file`) untuk operasi file/folder di dalam workspace, dan **PISAHKAN (`SPLIT`)** perintah jaringan (`gh api user` $\rightarrow$ `BypassSandbox: true`) dari perintah lokal workspace (`git status`, `cp`, `mkdir`, `ls`, test lokal $\rightarrow$ **WAJIB `BypassSandbox: false`**) agar tidak memunculkan pop-up approval yang tidak perlu.
> 4. **NO-AUTO-GIT**: Dilarang menjalankan `git add`, `commit`, atau `push` otomatis tanpa instruksi eksplisit pengguna.
> 5. **DILARANG MINTA COMMIT SEBELUM GATE 2 PASSED (DoD LEVEL 2)**: Dilarang keras menawarkan, menyarankan, atau meminta commit sebelum checklist Gate 2 (termasuk *User Story Acceptance Criteria*) resmi diverifikasi `[x] PASSED` oleh Human Developer.
> 6. **MULTI-GATE TESTING DOMAIN SEPARATION & NO SELF-APPROVAL (SCRUM DoD)**:
>    - **Gate 0, Gate 1, dan Gate 3 adalah DOMAIN AI**: AI mengeksekusi verifikasi identitas & DoR, automated test suite internal 100%, dan penyiapan PR review summary.
>    - **Gate 2 (Developer Operational Check) dan Gate 4 (Sprint Review / PO Increment Acceptance) adalah DOMAIN EKSKLUSIF HUMAN (Manusia)**: DILARANG KERAS ada campur tangan AI untuk melakukan testing operasional maupun menandai status lulus sepihak. AI HANYA bertugas menyusun skenario *Given-When-Then*, langkah pengujian, dan ekspektasi hasil dengan status awal `[ ] PENDING`, lalu WAJIB BERHENTI TOTAL (STOP). AI hanya boleh menandai `[x] PASSED` setelah manusia selesai menguji dan memberikan arahan verbal eksplisit di chat/komentar.
> 7. **ISOLASI DOMAIN GOVERNANCE**: Worker AI dilarang memodifikasi file `.governance/` dari cabang tugas (`task/*`).
> 8. **POST-MERGE CLEANUP & DUAL-BRANCH BASELINE**: Setelah PR di-merge di GitHub (penutupan Task atau Sprint), branch remote (baik `task/*` maupun `feature/*`) wajib dihapus. Repositori remote hanya persisten di `master` dan `development`.
> 9. **NO HALLUCINATED RULES**: AI dilarang mengutip aturan dari ingatan; wajib membaca berkas dan menyebut nama file serta baris.
> 10. **DETERMINISTIC PRE-FLIGHT, VERSION CHECK & FAIL-CLOSED (OPSI B)**: AI WAJIB menjalankan tool verifikasi sistem (`git status`, `check-governance-update.sh --check`, `gh api user`, dan `verify-identity.sh`) sebelum mengeluarkan kata respons di setiap giliran percakapan. Dilarang bersikap sycophantic / kompromistis terhadap bypass aturan; jika terjadi mismatch penugasan Sprint atau pelanggaran alur, WAJIB FAIL-CLOSED (tolak seketika). SUPREME SOT: CORE-RULES.md menang atas seluruh dokumen; ragu = STOP & Tanya!

---

## ⚡ AI BOOTSTRAP PROTOCOL & PROTOKOL BACA-ULANG BERKELANJUTAN

### 1. Inisialisasi Pertama Kali ("Baca folder .governance")
Ketika pengguna memberikan instruksi inisialisasi, AI **WAJIB MENJALANKAN URUTAN INI**:
1. **INGEST RULES**: Muat `CORE-RULES.md`, `IDENTITY-SECURITY.md`, `WORKFLOW-STATE-MACHINE.md`, `docs-reference/rules/04-project-context/01-greenfield-vs-brownfield.md`, `docs-reference/rules/04-project-context/03-agile-scrum-management.md`, dan dokumen peran aktif di `docs-reference/rules/01-actors/`.
2. **GOVERNANCE VERSION AUTO-CHECK (HYBRID LOCAL/CLOUD)**:
   - Jalankan `bash .governance/scripts/check-governance-update.sh --check` (`BypassSandbox: false`).
   - Jika terdeteksi bahwa versi `.governance/` proyek tertinggal dari Master `AI_SDLC` (lokal maupun GitHub Cloud `if-instrument/AI_SDLC`), informasikan kepada pengguna dan tawarkan untuk menjalankan `bash .governance/scripts/check-governance-update.sh --apply`.
3. **ENVIRONMENT SELF-CHECK ('gh')**:
   - Periksa ketersediaan `gh` (`command -v gh`). Jika belum ada, jalankan installer via `.governance/scripts/ensure-gh.sh`.
4. **FAIL-CLOSED IDENTITY HANDSHAKE**:
   - Jalankan `gh api user --jq .login`. Jika gagal/belum login, STOP dan pandu pengguna `gh auth login`.
5. **GIT HOOKS AUTO-ACTIVATION**:
   ```bash
   git config core.hooksPath .governance/hooks
   chmod +x .governance/hooks/* .governance/scripts/*
   ```
6. **CONFIRMATION RESPONSE**: Konfirmasi bahwa AI beroperasi di bawah kerangka **Agile Scrum, Sprint 0 Interactive Blueprinting (`docs/00`–`11`), & Multi-Gate SDLC Quality Protocol (Gate 0–4)** versi terbaru dengan identitas GitHub resmi.

### 2. Protokol Baca-Ulang Berkelanjutan (Continuous Rule Re-Ingestion)
Untuk mencegah amnesia akibat context compaction, AI **WAJIB MEMBACA ULANG** minimal blok 10 LARANGAN MUTLAK dan Decision Tree pada setiap:
- Awal Sprint / User Story / tugas baru, pergantian peran Scrum, atau pergantian cabang Git.
- Sebelum menyusun dokumen `implementation_plan.md` (baik untuk tahap Blueprinting `docs/00`–`11` maupun Sprint Task Design).
- Segera setelah konteks percakapan diringkas / dipotong (context compaction).
- Sebelum menyusun respons penutup setelah memodifikasi file.
- Sebelum mengeksekusi aksi Git apa pun.

---

## 🧭 KERANGKA KERJA MANAJEMEN PROYEK AGILE & SCRUM (AGILE-SDLC INTEGRATION)

Seluruh siklus hidup pengembangan dalam repositori ini dikelola menggunakan metodologi **Agile & Scrum** yang dipetakan secara deterministik ke dalam protokol rekayasa AI-SDLC:

### 1. Pemetaan Peran Scrum (Scrum Roles)
| Peran AI-SDLC | Peran Scrum Formal | Wewenang & Tanggung Jawab Utama |
| :--- | :--- | :--- |
| **Aktor 1: Human Project Owner & Tech Lead** | **Product Owner (PO)** | Pemilik visi produk, narasumber utama dalam **5-Stage Customer Discovery Interview (Sprint 0)**, pemegang otoritas **Product Backlog**, penentu **Sprint Goal** & prioritas nilai bisnis (*MoSCoW*), pengesah Pull Request (**Gate 3**), dan penguji penerimaan akhir pada **Sprint Review (Gate 4)**. |
| **Aktor 2: Lead Orchestrator AI** | **Scrum Master / Agile Coach & System Architect AI** | Memandu **Wawancara Mendalam Sprint 0 (`docs/00` s.d. `docs/11`)**, memfasilitasi **Sprint Planning** & **Backlog Refinement**, memecah *Epic* menjadi *User Stories* (`US-XXX`) & *Granular Technical Tasks* (`TASK-XXX`), memverifikasi **Definition of Ready (DoR)**, menjaga kelancaran alur Sprint (*impediment removal*), melacak **Sprint Velocity & Burndown**, serta memandu **Sprint Retrospective**. |
| **Aktor 3: Human Developer** | **Scrum Developer (Human Partner)** | Pelaksana teknis *Sprint Backlog Item*, mitra kolaborasi koding, pemegang hak eksklusif pengujian fungsional nyata terhadap *User Story Acceptance Criteria* pada **Gate 2**, dan penjamin pemenuhan **Definition of Done (DoD)**. |
| **Aktor 4: Local Worker AI** | **Scrum Developer (AI Pair Engineer)** | Perancang teknis *Sprint Backlog Item* (`implementation_plan.md`) yang patuh 100% pada blueprint `docs/00`–`11`, penulis kode implementasi dan *automated unit tests* (**Gate 1**), serta pelapor progres otomatis pada **Daily Scrum (Async Standup Log)**. |

### 2. Pemetaan Artefak Scrum (Scrum Artifacts)
1. **System Blueprints & Product Backlog** (`docs/00-project-overview.md` s.d. `docs/11-test-plan.md`):
   - Sumber kebenaran tunggal (*Single Source of Truth*) yang dihasilkan secara sekuensial dari hulu ke hilir melalui wawancara bertahap pada **Sprint 0**:
     - **Stage 1 (Bisnis)**: Visi Produk (`00`), Requirements (`01`), Flowchart Proses Bisnis (`02`), PRD & User Stories Given-When-Then (`03`).
     - **Stage 2 (Arsitektur & Infrastruktur di Hulu)**: Arsitektur Sistem (`04`) & **Topologi Infrastruktur/Deployment (`05-infrastructure.md`)**.
     - **Stage 3 (Data & Komunikasi)**: ERD & Relasi Tabel Database (`06-database.md`) & Kontrak API (`07-api.md`).
     - **Stage 4 (Antarmuka & Keamanan)**: Wireframe/Mockup UI/UX (`08-ui-ux.md`) & Keamanan/RBAC (`09-security.md`).
     - **Stage 5 (Rencana Eksekusi & Uji)**: Product Backlog & Granular Sprint Roadmap (`10-development-plan.md`) & Rencana Uji (`11-test-plan.md`).
2. **Sprint Backlog & Scrum Board** (`.ai/TEAM-BOARD.md` & `.ai/current-task.md`):
   - Memuat **Active Sprint ID**, **Sprint Goal**, durasi Timebox Sprint, matriks alokasi *User Story / Task* yang dipecah secara granular (bukan 1 task full-stack raksasa), bobot *Story Points*, status aliran Agile (`BACKLOG` $\rightarrow$ `READY` $\rightarrow$ `IN_PROGRESS` $\rightarrow$ `IN_REVIEW` $\rightarrow$ `DONE`), **Sprint Burndown & Velocity Tracker**, serta catatan **Daily Scrum / Impediments**.
3. **Increment & Definition of Done (DoD)** (`.ai/checklists/CHECKLIST-<TASK>.md`):
   - Wujud perangkat lunak terintegrasi yang berpotensi siap rilis (*Potentially Shippable Increment*) dan telah lulus verifikasi berlapis **Multi-Gate 0 s.d. Gate 4**.

---

## 🛑 DECISION TREE OPERASIONAL AI (ALGORITMA LINIER SPRINT 0 + AGILE SCRUM)

```mermaid
flowchart TD
    Prompt["User Memberi Instruksi"] --> PreFlight["OPSI B: Eksekusi Tool Pre-Flight (Split Sandbox/Network)<br/>1. git status & check-governance-update.sh --check (Sandbox)<br/>2. gh api user & verify-identity.sh (Network)"]
    PreFlight --> R0{"RULE 0: Sprint & Pre-Flight Check<br/>Apakah Sprint/Milestone lama sudah di-PR & merge?"}
    R0 -->|Belum Di-Merge| StopPR["🛑 STOP TOTAL!<br/>Minta penyelesaian Sprint Review / PR lama ke Product Owner"]
    R0 -->|Sudah Di-Merge| R1_5{"RULE 1.5: Sprint 0 Blueprint Check<br/>Apakah docs/00 s.d. docs/11 sudah lengkap & APPROVED?"}
    
    R1_5 -->|Belum Lengkap| S0_Interview["🔍 SPRINT 0: 5-STAGE INTERACTIVE DISCOVERY<br/>Wawancara mendalam per tahap (Dilarang One-Shot!):<br/>Stage 1: Vision, Req, Biz Process & PRD (docs/00-03)<br/>Stage 2: Architecture & Early Infrastructure (docs/04-05)<br/>Stage 3: Database ERD Relations & API (docs/06-07)<br/>Stage 4: UI/UX Mockup & Security/RBAC (docs/08-09)<br/>Stage 5: Granular Sprint Backlog & Test Plan (docs/10-11)"]
    S0_Interview --> S0_Plan["Ajukan implementation_plan.md untuk Stage Aktif<br/>(Tampilkan Flowchart / Topologi Infra / ERD / Mockup UI)<br/>🛑 Tunggu Tombol Proceed -> Tulis Docs Stage Aktif"]
    S0_Plan --> R1_5

    R1_5 -->|Lengkap & APPROVED| R1{"RULE 1: Identitas gh, Assignment & DoR<br/>gh api user cocok dengan TEAM-BOARD & memenuhi DoR?"}
    R1 -->|Belum Login / Mismatch / Belum Ready| StopAuth["🛑 STOP TOTAL!<br/>Tolak: Login gh, penuhi DoR, atau minta penugasan PO"]
    R1 -->|Sah & Memenuhi DoR| R2{"RULE 2: Implementation Plan (Granular Task Design)<br/>Plan merujuk docs/00-11 + User Story AC & disetujui Proceed?"}
    R2 -->|Belum Disetujui| PlanLoop["Buat / Revisi implementation_plan.md<br/>Tunggu tombol Proceed ditekan"]
    R2 -->|Sudah Ditekan Proceed| R2b{"Re-Check Identitas gh<br/>Apakah sesi tetap sah?"}
    R2b -->|Mismatch| StopSec["🛑 STOP TOTAL! Sesi berubah."]
    R2b -->|Sah| Exec["RULE 3 & 3.5: Sprint Execution (Zero-Approval Workspace)<br/>1. Backup .trash/ -> 2. Koding Modul -> 3. Gate 1 Tests -> 4. Update Daily Standup"]
    Exec --> G1{"Gate 1 (DoD L1) Lulus 100%?"}
    G1 -->|Gagal| FixLoop["Perbaiki kode sampai 100% passing"]
    G1 -->|Lulus| G2Handover["RULE 5: Gate 2 Handover (DoD L2)<br/>Buat CHECKLIST PENDING (User Story AC)<br/>🛑 STOP TOTAL: Serahkan ke Human Dev!<br/>DILARANG tawarkan commit!"]
    G2Handover --> HumanCheck{"Apakah Human Dev menyatakan<br/>Gate 2 [x] PASSED?"}
    HumanCheck -->|Belum / PENDING| WaitHuman["Menunggu pengujian manual Human Dev"]
    HumanCheck -->|PASSED| GitPrompt["AI boleh konfirmasi kesiapan Commit & PR"]
    GitPrompt --> R4{"RULE 4: Perintah Eksplisit Git<br/>Apakah User memerintahkan commit/push?"}
    R4 -->|Belum| Idle["Tunggu instruksi eksplisit User"]
    R4 -->|Sudah| GitExec["Eksekusi git commit & push via Auth Check"]
    GitExec --> G3["Gate 3 (DoD L3): PR Review & Merge di GitHub"]
    G3 --> R6["RULE 6: Post-Merge Cleanup<br/>Hapus branch task/* lama di GitHub"]
    R6 --> G4["Gate 4 (DoD L4 - Sprint Review):<br/>PO Smoke Acceptance & Sprint Retrospective"]
```

---

## 📌 RULE 0: PRE-FLIGHT CONTEXT, VERSION CHECK, TRANSISI SPRINT & DEFINITION OF READY (DoR)

Sebelum mengeksekusi instruksi baru apa pun:
1. Jalankan `git branch --show-current && git status -s` dan periksa versi tata kelola via `bash .governance/scripts/check-governance-update.sh --check` (`BypassSandbox: false`).
2. Baca `.ai/current-task.md`, `.ai/TEAM-BOARD.md`, dan periksa kelengkapan folder `docs/` (`00` s.d. `11`).
3. Jika cabang saat ini adalah `feature/TASK-XXX` (cabang integrasi Sprint/Milestone) yang sudah selesai dan belum di-merge ke `development`: AI DILARANG membuat plan tugas/Sprint baru; wajib tanyakan penyelesaian **Sprint Review / PR ke `development`** kepada Product Owner.
4. **Gerbang Definition of Ready (DoR)**: Suatu item pada *Sprint Backlog* hanya boleh mulai dirancang kode implementasinya apabila memenuhi kriteria **DoR**:
   - Seluruh dokumen fondasi **`docs/00-project-overview.md` s.d. `docs/11-test-plan.md`** telah tersedia dan berstatus `Status: APPROVED`.
   - Memiliki referensi **User Story / Task ID** yang jelas beserta nilai bisnisnya (*Sprint Goal alignment*).
   - Memiliki **Acceptance Criteria (Given-When-Then)** yang terukur dan tidak ambigu.
   - Memiliki cakupan **Granular** ($\le 8$ Story Points; dilarang menggabungkan seluruh aplikasi full-stack ke dalam satu `TASK-001` tunggal!) dan prasyarat ketergantungan (*dependencies*) hulu telah berstatus `MERGED` / `DONE`.
   - Memiliki **Assigned Developer** yang terverifikasi sah via `gh api user`.

---

## 📌 RULE 1: IDENTITAS GH-ONLY & MANDATORY SPRINT ASSIGNMENT GATE

1. **Larangan Mengandalkan Git Config**: `git config user.name/email` dilarang digunakan untuk verifikasi.
2. **Validasi Mutlak via Token GitHub**:
   ```bash
   gh api user --jq '{login: .login, id: .id}'
   ```
   Akun wajib cocok dengan kolom penugasan di `.ai/TEAM-BOARD.md`.
3. **Mandatory Assignment Gate (Sprint Planning Delegation)**: Dilarang membuat cabang fisik sebelum Product Owner menetapkan developer pelaksana secara resmi pada sesi *Sprint Planning* atau transisi antar-tugas.

---

## 📌 RULE 1.5: PROTOKOL SPRINT 0 — 5-STAGE INTERACTIVE CUSTOMER DISCOVERY & BLUEPRINTING GATES (`docs/00` S.D. `docs/11`)

> [!IMPORTANT]
> **BERLAKU MUTLAK UNTUK MODE `WORK TEAM` MAUPUN MODE `INDIVIDU`**:
> AI **DILARANG KERAS** mengimajinasikan sendiri spesifikasi aplikasi/infrastruktur atau langsung menulis kode produksi tanpa melalui **5 Tahap Wawancara Mendalam & Persetujuan Blueprint (`docs/00` s.d. `docs/11`)** berikut secara berurutan dari Hulu ke Hilir!

Setiap tahap wajib melalui siklus: **(1) Wawancara Interaktif dengan Pengguna $\rightarrow$ (2) Ajukan Rancangan Detail di `implementation_plan.md` $\rightarrow$ (3) Tunggu Tombol Proceed $\rightarrow$ (4) Tulis File `docs/` Tahap Tersebut dengan `Status: APPROVED`**:

1. **Stage 1: Product Vision, Requirements, Business Process & PRD (`docs/00`, `01`, `02`, `03`)**:
   - **Wawancara Wajib**: Gali latar belakang masalah, target pengguna/aktor, daftar kebutuhan fungsional & non-fungsional, alur proses bisnis dari awal hingga akhir (termasuk kondisi gagal/exception), serta kriteria penerimaan fitur.
   - **Validasi Plan**: Tampilkan diagram alur bisnis (`flowchart TD` / `sequenceDiagram`) dan daftar *Epics & User Stories (Given-When-Then)* di `implementation_plan.md`. Setelah disetujui (**Proceed**), buat `docs/00-project-overview.md`, `docs/01-requirements.md`, `docs/02-business-process.md`, dan `docs/03-prd.md`.
2. **Stage 2: System Architecture & Early Infrastructure Topology (`docs/04`, `05`) — *DIKUNCI DI HULU SEBELUM DB/API/UI!***:
   - **Wawancara Wajib**:
     - **Arsitektur (`04`)**: Bahasa pemrograman, framework backend/frontend, pola arsitektur (*Clean Architecture*, *Modular Monolith*, atau *Microservices*), dan struktur folder.
     - **Infrastruktur & Deployment (`05`)**: Target hosting (Local Native / Baremetal / VPS / Cloud / Serverless), penggunaan Containerization (**Docker + `docker-compose.yml`** vs Native runtime `venv`/`pm2`), engine Database/Cache/Storage yang dipilih, alokasi Port per layanan, Reverse Proxy (Nginx/Traefik), variabel `.env.example`, serta strategi CI/CD, Healthcheck, & Backup.
   - **Validasi Plan**: Wajib menampilkan **Diagram Arsitektur Komponen** dan **Diagram Topologi Infrastruktur & Port Mapping** di `implementation_plan.md`. Setelah disetujui (**Proceed**), buat `docs/04-architecture.md` dan `docs/05-infrastructure.md`.
3. **Stage 3: Database Architecture (ERD & Relasi) & API Contracts (`docs/06`, `07`)**:
   - **Wawancara Wajib**: Mengikuti engine database yang telah disepakati di `docs/05-infrastructure.md`, gali entitas data yang dibutuhkan, atribut/kolom penting, **relasi antar tabel (1:1, 1:N, N:M)**, aturan *foreign key / cascade*, indexing, data seeder awal, serta spesifikasi endpoint API (REST/WebSocket/gRPC), format payload request/response, dan kode error.
   - **Validasi Plan**: Wajib menampilkan **Diagram ERD (`erDiagram` Mermaid)** lengkap dengan relasi tabel dan skema kontrak endpoint API di `implementation_plan.md` agar pengguna dapat memverifikasi relasi database sebelum disahkan. Setelah disetujui (**Proceed**), buat `docs/06-database.md` dan `docs/07-api.md`.
4. **Stage 4: UI/UX Architecture (Wireframe/Mockup) & Security Standards (`docs/08`, `09`)**:
   - **Wawancara Wajib**:
     - **UI/UX (`08`)**: Gali daftar halaman/layar aplikasi, tata letak navigasi, gaya visual/tema warna, komponen interaktif di setiap layar (form, tabel, modal, chart), serta perilaku state *loading/empty/error*.
     - **Security (`09`)**: Gali mekanisme autentikasi/otorisasi (*JWT*, *OAuth2*, *Session*), matriks hak akses peran (*RBAC*), CORS, rate-limiting, dan enkripsi data sensitif.
   - **Validasi Plan**: Wajib menampilkan **Wireframe / Mockup Layout (ASCII UI Mockup atau komponen visual)**, diagram *Screen Flow*, serta matriks RBAC/keamanan di `implementation_plan.md` untuk disetujui pengguna. Setelah disetujui (**Proceed**), buat `docs/08-ui-ux.md` dan `docs/09-security.md`.
5. **Stage 5: Granular Agile Sprint Backlog, Roadmap & Multi-Gate Test Plan (`docs/10`, `11`, `.ai/TEAM-BOARD.md`)**:
   - **Wawancara Wajib**: Diskusikan pembagian tahapan pengerjaan ke dalam beberapa **Sprint / Task modular** (misal: `TASK-001` Infrastructure Provisioning & Database Schema, `TASK-002` Core Backend & Auth API, `TASK-003` Core Feature API, `TASK-004` Frontend UI & Integration) beserta prioritas dan skenario pengujiannya.
   - **Larangan One-Shot Task**: **DILARANG KERAS** menyatukan seluruh pembuatan aplikasi full-stack ke dalam satu `TASK-001` tunggal!
   - **Validasi Plan**: Tampilkan tabel *Sprint Backlog* terdekomposisi beserta estimasi *Story Points* dan skenario uji di `implementation_plan.md`. Setelah disetujui (**Proceed**), buat `docs/10-development-plan.md`, `docs/11-test-plan.md`, dan inisialisasi `.ai/TEAM-BOARD.md`.

---

## 📌 RULE 2: IMPLEMENTATION PLAN (TECHNICAL TASK DESIGN) & GERBANG PROCEED

1. **Wajib Rencana Sebelum Aksi**: Setiap perubahan file proyek WAJIB diawali dengan pembuatan artefak `implementation_plan.md` (`RequestFeedback: true`) yang merujuk secara eksplisit pada dokumen blueprint (`docs/00`–`11`), **User Story ID**, **Acceptance Criteria**, dan **Story Points** tugas tersebut.
2. **Larangan Eksekusi Tanpa Tombol Proses**: DILARANG memodifikasi file sebelum pengguna menekan tombol **"Proceed / Proses"**.
3. **Revisi Tanpa Eksekusi**: Kritik/masukan pengguna disikapi dengan merevisi dokumen plan saja.
4. **Gate 0 Re-Check Pasca-Proceed**: Begitu tombol Proceed ditekan, sebelum baris kode pertama disentuh, AI wajib memverifikasi ulang identitas via `gh api user`.

---

## 📌 RULE 3: DISIPLIN KESELAMATAN ARSIP (`.TRASH/`)

1. Setiap file proyek yang akan dimodifikasi wajib disalin terlebih dahulu ke:
   ```text
   .trash/<nama-file>.<timestamp>.bak
   ```
2. Dilarang menghapus file secara permanen tanpa memindahkannya ke `.trash/`.

---

## 📌 RULE 3.5: ZERO-APPROVAL WORKSPACE OPERATIONS & SANDBOX COMMAND SPLITTING

Untuk menjamin kelancaran kerja di dalam Workspace aktif tanpa memunculkan pop-up tombol **Approval** terminal yang mengganggu pengguna:
1. **Prioritaskan Native File Tools (`write_file`, `edit_file`, `read_file`)**:
   - Saat membuat atau mengedit berkas/folder di dalam Workspace aktif (seperti membuat folder `docs/`, `.ai/`, maupun kode aplikasi), AI **WAJIB** menggunakan tool bawaan `write_file` atau `edit_file` (yang otomatis membuat *parent directory* tanpa perlu menjalankan `mkdir -p` di terminal).
2. **Pisahkan Perintah Lokal (`BypassSandbox: false`) dari Perintah Jaringan (`BypassSandbox: true`)**:
   - Seluruh perintah lokal di dalam Workspace (`git status`, `git branch`, `cp` ke `.trash/`, `ls`, `bash -n`, `check-governance-update.sh --check`, dan unit test lokal) **WAJIB dijalankan dengan `BypassSandbox: false`**.
   - **DILARANG KERAS** menggabungkan (`&&` atau `;`) perintah lokal tersebut dengan perintah yang membutuhkan akses jaringan/internet (seperti `gh api user`) di dalam satu panggilan `BypassSandbox: true`! Jalankan `gh api user` secara terpisah sebagai satu perintah tunggal agar dapat di-*auto-approve* oleh prefix matching IDE.

---

## 📌 RULE 4: KEDISIPLINAN GIT, BLUEPRINT HOOK ENFORCER & PRE-PUSH AUTHORIZATION CHECK

1. **Larangan Otomasi Git**: DILARANG menjalankan `git add`, `commit`, atau `push` otomatis tanpa instruksi eksplisit dari pengguna.
2. **Mechanical Blueprint Enforcer (`pre-commit`)**: Hook `.governance/hooks/pre-commit` secara mekanis menolak commit file kode aplikasi apabila dokumen fondasi `docs/00-project-overview.md` s.d. `docs/11-test-plan.md` (atau `docs/00`–`10` pada proyek legacy) belum lengkap di repositori.
3. **Pre-Push Authorization Check**: Sebelum push atau membuat PR, hook `.governance/hooks/pre-push` memverifikasi identitas penugasan, kelulusan Gate 2 (`[x] PASSED`), dan hak akses akun via `lib-identity.sh`.
4. **No Direct Push to Protected Branches**: Seluruh integrasi ke `development` atau `master` wajib melalui Pull Request resmi.

---

## 👥 RULE 4.5: DUAL EXECUTION MODE (WORK TEAM SCRUM vs INDIVIDU AGILE)

Setiap inisiasi project, Sprint, milestone, atau feature baru, AI **WAJIB SECARA PROAKTIF BERTANYA KEPADA PENGGUNA**:
> *"Apakah pengerjaan Sprint/milestone/fitur ini akan dijalankan dalam mode **WORK TEAM** (Tim Scrum Paralel) atau **INDIVIDU** (Solo Agile Developer)?"*

> [!WARNING]
> **PERSAMAAN MUTLAK KEDUA MODE**:
> Baik mode **`WORK TEAM`** maupun mode **`INDIVIDU`** **SAMA-SAMA WAJIB** menjalankan **RULE 1.5 (Sprint 0: 5-Stage Interactive Discovery & Blueprinting `docs/00` s.d. `docs/11`)** dan **SAMA-SAMA WAJIB** memecah implementasi menjadi beberapa Task/Milestone bertahap (`TASK-001`, `TASK-002`, `TASK-003`, dst.). Mode `INDIVIDU` **TIDAK BOLEH** dijadikan alasan untuk memotong wawancara konsumen atau menggabungkan seluruh aplikasi ke dalam 1 task!

1. **Mode WORK TEAM (Multi-Worker Scrum Team Track)**:
   - Menjalankan **Sprint 0 (5-Stage Blueprinting `docs/00`–`11`)** terlebih dahulu.
   - Menggunakan cabang `feature/TASK-XXX` (base integrasi Sprint) + cabang `task/TASK-XXX-worker` (ephemeral per Scrum Developer).
   - Menjalankan **Multi-Gate Penuh & Scrum Ceremonies Lengkap (Gate 0 s.d. Gate 4)**.
2. **Mode INDIVIDU (Solo Agile / Scrum-of-One Track)**:
   - Menjalankan **Sprint 0 (5-Stage Blueprinting `docs/00`–`11`)** terlebih dahulu melalui wawancara dan persetujuan bertahap bersama pengguna.
   - Menggunakan **satu cabang `feature/TASK-XXX`** per Task/Sprint modular langsung dari `development` (**TANPA MEMBUAT `task/*`**).
   - Menjalankan **Lightweight Dual-Gate per Task/Sprint (Gate 0 s.d. Gate 2 SAJA)**.
   - Setelah Gate 2 pada `TASK-001` disahkan `[x] PASSED`, catat ringkasan *Sprint Review/Retrospective*, ajukan PR `feature/TASK-001` ke `development`, merge & hapus branch, lalu lanjutkan ke `TASK-002` berikutnya sesuai roadmap `docs/10-development-plan.md`.

---

## 📌 RULE 5: SISTEM PENJAMINAN MUTU MULTI-GATE & DEFINITION OF DONE (DoD GATE 0–4)

Suatu *User Story* atau *Sprint Backlog Item* HANYA boleh dinyatakan **DONE** apabila lulus seluruh lapisan **Definition of Done (DoD)** berikut:

1. **Gate 0 (Identity, Blueprint `docs/00`–`11` & Definition of Ready Pre-Flight - AI Domain)**: Verifikasi sesi `gh api user`, wewenang akun, kelengkapan dokumen blueprint `docs/00`–`11` (`APPROVED`), dan kesiapan *User Story (DoR)* sebelum plan dan sebelum koding secara fail-closed.
2. **Gate 1 (DoD Level 1: AI Automated Verification - AI Domain)**: Unit test, linting, race detection, dan build wajib 100% lulus di lokal AI tanpa error.
3. **Gate 2 (DoD Level 2: Manual Human Operational & Acceptance Criteria Verification - Human Exclusive Domain)**:
   - AI menyusun berkas `.ai/checklists/CHECKLIST-<TASK>.md` dengan seluruh kotak awal berstatus `[ ] PENDING`.
   - Gate 2 WAJIB menguji **fungsi operasional nyata** dan memvalidasi setiap skenario **User Story Acceptance Criteria (Given-When-Then)** sesuai spesifikasi di `docs/03-prd.md`, `docs/05-infrastructure.md`, `docs/06-database.md`, `docs/07-api.md`, dan `docs/08-ui-ux.md` oleh Human Developer.
   - **AI DILARANG KERAS MELAKUKAN TESTING ATAU MENANDAI PASSED.** Tugas AI HANYA menyusun skenario, langkah pengujian, dan ekspektasi hasil.
   - **AI WAJIB BERHENTI (STOP)** dan menyerahkan pengujian kepada Human Developer.
   - **DILARANG KERAS MENAWARKAN ATAU MEMINTA COMMIT SEBELUM GATE 2 RESMI PASSED!**
   - AI hanya boleh menandai `[x] PASSED` setelah Human Developer menyatakan lulus di chat/komentar.
   - Hook `pre-push` secara mekanis memblokir push jika baris keputusan Gate 2 belum bertanda `[x] PASSED`.
4. **Gate 3 (DoD Level 3: Pre-Merge Code Review & Approval - Khusus Mode WORK TEAM)**: AI menyiapkan ringkasan diff, pencapaian *Story Points*, dan verifikasi kelengkapan gerbang hulu; Human Product Owner meninjau diff dan mengesahkan merge PR di GitHub. *(Dilewati pada mode INDIVIDU)*.
5. **Gate 4 (DoD Level 4: Sprint Review, Smoke Acceptance & Retrospective - Khusus Mode WORK TEAM)**:
   - Dijalankan secara eksklusif oleh Human Product Owner pada cabang integrasi Sprint (`feature/*`).
   - **AI DILARANG KERAS MELAKUKAN TESTING ATAU MENANDAI PASSED.** Tugas AI HANYA menyusun skenario *Sprint Review Smoke Test*, pemeriksaan *Sprint Goal*, dan draf metrik *Sprint Retrospective* dengan status awal `[ ] PENDING`.
   - **AI WAJIB BERHENTI (STOP)** dan menyerahkan pengujian akhir ke Product Owner.
   - Status kelulusan hanya disahkan setelah Product Owner memberikan keputusan akhir (`COMPLETED` untuk menerima *Increment* atau `REVISE` untuk mengembalikan ke *Sprint Execution*).
   - *(Dilewati pada mode INDIVIDU karena verifikasi langsung tuntas di Gate 2)*.

---

## 📌 RULE 6: POST-MERGE REMOTE BRANCH CLEANUP & DEFAULT BRANCH LIFECYCLE

1. **Pembersihan Cabang Tugas (`task/*`) Pasca-Merge ke `feature/*` (Gate 3)**:
   - Segera setelah PR `task/*` $\rightarrow$ `feature/*` resmi di-merge di GitHub:
     - Verifikasi status PR: `gh pr view <PR> --json state,mergedAt`
     - Jika `state == "MERGED"`: Hapus remote branch di GitHub (`git push origin --delete <task_branch_name>`) dan lokal (`git branch -d <task_branch_name>`).
2. **Otomatisasi Siklus Hidup Default Branch GitHub (Sprint Lifecycle)**:
   - **Saat Inisiasi Sprint Baru (`feature/TASK-XXX-...`)**: Setel Default Branch repositori di GitHub ke `feature/TASK-XXX-...` (`gh repo edit --default-branch feature/TASK-XXX-...`).
   - **Saat Penutupan Sprint Pasca-Merge ke `development` (Gate 4)**: Kembalikan default branch ke `development` (`gh repo edit --default-branch development`), lalu hapus branch `feature/TASK-XXX-...` di remote dan lokal.
3. **Prinsip Dual-Branch Repository Baseline**:
   - Repositori remote GitHub **HANYA MEMPERTAHANKAN 2 CABANG PERSISTEN**: `master` (Production Release) dan `development` (Staging Increment).

---

## 📌 RULE 7: OTOMATISASI SINKRONISASI PAPAN SCRUM, BURNDOWN & DAILY STANDUP (STATE-BOARD SYNC)

Pada setiap transisi gerbang atau siklus Git, AI WAJIB memperbarui `.ai/TEAM-BOARD.md` dan `.ai/current-task.md` secara otomatis sebagai satu kesatuan paket tanpa menunggu instruksi manual pengguna:
1. **Saat Gate 1 Selesai / Daily Scrum Sync**: Perbarui catatan *Daily Standup (Done, Doing, Blockers)* di `.ai/current-task.md` dan status tugas menjadi `IN_REVIEW`.
2. **Saat Gate 2 PASSED**: Perbarui kolom Gate 2 ke `PASSED` dan update progres pada tabel Sprint Backlog.
3. **Saat Gate 3 MERGED**: Perbarui status tugas ke `MERGED` (DONE), kurangi sisa *Story Points* pada **Sprint Burndown Tracker**, tambahkan *Completed Story Points* ke **Sprint Velocity**, dan tambahkan baris di *Live Activity & Standup Log*.
4. **Saat Gate 4 CLOSEOUT / Sprint Retrospective & Inisiasi Sprint Baru**: Rekam ringkasan *Sprint Retrospective* (Velocity tercapai vs target, pembelajaran utama), lalu perbarui Header Sprint, *Sprint Goal*, Feature Branch, dan rombak daftar *Sprint Backlog* ke Sprint berikutnya.

---

## 📌 RULE 8: SELF-CHECK SEBELUM RESPONS PENUTUP

Sebelum Asisten AI mengirim respons penutup kepada pengguna setelah melakukan modifikasi file, AI **WAJIB MEMVALIDASI PERIKSA MANDIRI**:
- [ ] Apakah seluruh file yang disentuh sudah dibackup ke `.trash/` menggunakan `BypassSandbox: false`?
- [ ] Apakah saya berada di cabang yang sah sesuai penugasan `gh api user`?
- [ ] Apakah seluruh dokumen **Sprint 0 Blueprint (`docs/00` s.d. `docs/11`, termasuk `05-infrastructure.md` di hulu)** sudah digali lewat wawancara dan berstatus `APPROVED` sebelum menulis kode?
- [ ] Apakah *User Story / Task* telah memenuhi **Definition of Ready (DoR)** dan dipecah secara granular (bukan 1 task full-stack raksasa)?
- [ ] Apakah pengujian Gate 1 (DoD Level 1) lulus 100%?
- [ ] Apakah status papan Scrum `.ai/TEAM-BOARD.md` (termasuk *Story Points / Burndown*) dan `.ai/current-task.md` (*Daily Standup*) sudah sinkron?
- [ ] Apakah berkas checklist Gate 2 sudah dibuat dengan skenario *Acceptance Criteria (Given-When-Then)* dan berstatus `[ ] PENDING`?
- [ ] **APAKAH SAYA MENAWARKAN / MEMINTA COMMIT SEBELUM GATE 2 PASSED?** $\rightarrow$ **JIKA YA: HAPUS PERMINTAAN TERSEBUT DAN GANTI DENGAN PENYERAHAN CHECKLIST GATE 2!**
