# PROTOKOL GREENFIELD (SPRINT 0 INTERACTIVE DISCOVERY) VS BROWNFIELD & GOVERNANCE AUTO-UPDATE
# Version: 2.2.0 | Date: 2026-10-30 | Scope: 5-Stage Customer Interview (`docs/00`–`11` with Early Infrastructure at `05` & Visual UI Mockups at `08`), Brownfield Reverse-Documentation & Governance Version Upgrade

> [!CAUTION]
> **LARANGAN MUTLAK AI SOLO IMAGINATION & ONE-SHOT GENERATION**:
> Baik pada proyek baru (*Greenfield*) maupun proyek berjalan (*Brownfield*), dan baik dalam mode **`WORK TEAM`** maupun **`INDIVIDU`**, AI **DILARANG KERAS**:
> 1. Mengasumsikan/mengimajinasikan sendiri kebutuhan pengguna, arsitektur, atau infrastruktur hanya dari 1 kalimat prompt awal.
> 2. Langsung menulis kode aplikasi (`backend/`, `frontend/`, `app/`, `src/`) sebelum seluruh dokumen **`docs/00-project-overview.md` s.d. `docs/11-test-plan.md`** selesai digali dan disetujui (`Status: APPROVED`).
> 3. Menghasilkan seluruh dokumen `docs/00` s.d. `docs/11` sekaligus tanpa wawancara bertahap, atau menggabungkan seluruh pembangunan aplikasi ke dalam satu `TASK-001` tunggal.

---

## 1. Protokol Fresh Project (Greenfield): 5-Stage Interactive Discovery & Blueprinting (Sprint 0)

Saat menginisiasi proyek baru dari nol (*clean slate*), AI **WAJIB** memandu pengguna melewati **5 Tahap Wawancara & Perancangan Blueprint (`Sprint 0`)** secara sekuensial dari Hulu ke Hilir. Setiap tahap wajib melalui siklus:
`Wawancara Mendalam -> Ajukan Rancangan Detail di implementation_plan.md -> Tunggu Tombol Proceed -> Tulis Dokumen docs/ Tahap Tersebut`.

### Stage 1: Product Vision, Requirements, Business Process & PRD (`docs/00`, `01`, `02`, `03`)
1. **Sesi Wawancara Wajib (Tanyakan ke Pengguna)**:
   - Apa masalah utama yang ingin diselesaikan dan siapa target pengguna (*aktor/persona*) aplikasi ini?
   - Apa saja fitur utama (*Functional Requirements*) dan batasan kualitas (*Non-Functional Requirements*: performa, kapasitas, platform)?
   - Bagaimana alur proses bisnis dari awal pengguna masuk hingga tujuan tercapai, termasuk skenario gagal/pengecualian (*Exception Flow*)?
2. **Isi `implementation_plan.md` Stage 1**:
   - Menyajikan draf **Flowchart Proses Bisnis (`flowchart TD` / `sequenceDiagram`)**, matriks kebutuhan fungsional, serta daftar **Epics (`EPIC-XXX`) & User Stories (`US-XXX`)** lengkap dengan **Acceptance Criteria (Given-When-Then)**.
3. **Output Pasca-Proceed**:
   - Menulis `docs/00-project-overview.md`, `docs/01-requirements.md`, `docs/02-business-process.md`, dan `docs/03-prd.md` (`Status: APPROVED`).

### Stage 2: System Architecture & Early Infrastructure Topology (`docs/04`, `05`) — *DIKUNCI DI HULU SEBELUM DB/API/UI!*
1. **Sesi Wawancara Wajib (Tanyakan ke Pengguna)**:
   - **Arsitektur (`04-architecture.md`)**: Bahasa pemrograman, framework backend, frontend, dan pola arsitektur (*Clean Architecture*, *Layered*, *Modular Monolith*, atau *Microservices*) apa yang diinginkan?
   - **Infrastruktur & Deployment (`05-infrastructure.md`)**:
     - Di mana aplikasi akan dijalankan/di-deploy (Local Native, On-Premise Server, VPS, atau Cloud seperti GCP/AWS/Vercel/Railway)?
     - Apakah menggunakan **Docker (`Dockerfile` + `docker-compose.yml`)**, Kubernetes, atau Native Runtime (`venv`, `systemd`, `pm2`)?
     - Engine Database utama apa yang dipilih (PostgreSQL, MySQL, SQLite, MongoDB), apakah butuh Redis/Queue, dan bagaimana penyimpanan file/storage-nya?
     - Berapa alokasi Port masing-masing layanan, apakah menggunakan Reverse Proxy (Nginx/Traefik), bagaimana variabel `.env.example`, serta strategi CI/CD, Healthcheck (`/healthz`), & Backup?
2. **Isi `implementation_plan.md` Stage 2**:
   - Menyajikan **Diagram Arsitektur Komponen**, struktur pohon direktori proyek, serta **Diagram Topologi Infrastruktur & Tabel Alokasi Port**.
3. **Output Pasca-Proceed**:
   - Menulis `docs/04-architecture.md` dan `docs/05-infrastructure.md` (`Status: APPROVED`).

### Stage 3: Database Architecture (ERD & Relasi) & API Contracts (`docs/06`, `07`)
1. **Sesi Wawancara Wajib (Tanyakan ke Pengguna)**:
   - Berdasarkan engine database yang telah disepakati di `docs/05-infrastructure.md`, entitas/tabel apa saja yang diperlukan, bagaimana **relasi antar tabelnya (1-to-1, 1-to-Many, Many-to-Many)**, aturan penghapusan (*Soft Delete vs Hard Delete / Cascade*), serta data awal (*Seeder*) apa yang dibutuhkan?
   - Protokol komunikasi apa yang dipakai (REST API, WebSocket, GraphQL, gRPC) dan bagaimana standar format response/error-nya?
2. **Isi `implementation_plan.md` Stage 3**:
   - **WAJIB** menampilkan **Diagram ERD (`erDiagram` Mermaid)** yang memperlihatkan seluruh tabel, kolom kunci (`PK`, `FK`), dan garis relasinya secara eksplisit, ditambah daftar spesifikasi endpoint API beserta contoh JSON Request/Response.
3. **Output Pasca-Proceed**:
   - Menulis `docs/06-database.md` dan `docs/07-api.md` (`Status: APPROVED`).

### Stage 4: UI/UX Architecture (Visual Mockup Images) & Security Standards (`docs/08`, `09`)
1. **Sesi Wawancara Wajib (Tanyakan ke Pengguna)**:
   - **UI/UX (`08-ui-ux.md`)**: Apa saja halaman/layar utama yang dibutuhkan, bagaimana struktur navigasinya (Sidebar, Topbar, Tab, Modal), preferensi gaya visual (Dark/Light mode, palet warna, komponen tabel/chart/form), dan alur perpindahan layar (*User Screen Flow*)?
   - **Security (`09-security.md`)**: Bagaimana mekanisme login/autentikasi (*JWT*, *Session*, *OAuth2/SSO*), pembagian hak akses peran (*RBAC*), CORS, dan enkripsi data sensitif?
2. **Isi `implementation_plan.md` Stage 4 (WAJIB VISUAL MOCKUP IMAGE, DILARANG HANYA TEKS/ASCII!)**:
   - **WAJIB** memanggil subagent **`image-generator`** untuk men-generate **Gambar Visual UI Mockup (`.png`)** beresolusi tinggi untuk setiap layar utama berdasarkan hasil wawancara pengguna.
   - Simpan file gambar di `docs/assets/mockups/<nama-layar>.png` dan salin ke folder artefak aktif (`<appDataDir>/brain/<conversation-id>/`), lalu **sematkan langsung (`![Nama Layar](/absolute/path/to/mockup.png)`) di dalam `implementation_plan.md`** (gunakan ````carousel` jika lebih dari 1 layar, serta opsional preview interaktif `generative_ui`).
   - Sertakan juga diagram *Screen Flow* (`flowchart LR`), spesifikasi state (`Loading`, `Empty`, `Error`, `Success`), dan matriks RBAC/keamanan agar pengguna dapat melihat dan mengoreksi desain visual UI secara nyata sebelum menekan tombol **Proceed**.
3. **Output Pasca-Proceed**:
   - Menulis `docs/08-ui-ux.md` (lengkap dengan embed gambar mockup di `docs/assets/mockups/`) dan `docs/09-security.md` (`Status: APPROVED`).

### Stage 5: Granular Agile Sprint Backlog, Roadmap & Multi-Gate Test Plan (`docs/10`, `11`, `.ai/TEAM-BOARD.md`)
1. **Sesi Wawancara Wajib (Tanyakan ke Pengguna)**:
   - Bagaimana urutan prioritas pembangunan modul pada Sprint 1, Sprint 2, dst.?
   - Skenario pengujian kritis apa yang wajib lulus pada Gate 1 (Unit/Integration Test) dan Gate 2 (Manual Operational Test)?
2. **Aturan Dekomposisi Granular (Larangan 1 Task Full-Stack)**:
   - Pekerjaan **WAJIB DIPECAH** menjadi beberapa Task modular yang logis (minimal 3–5 Task terpisah untuk aplikasi full-stack, misalnya: `TASK-001` Infrastructure Provisioning & Database Schema, `TASK-002` Core Backend & Auth Service, `TASK-003` Business Logic & API Endpoints, `TASK-004` Frontend UI Layout & State Integration, `TASK-005` End-to-End Integration & Polish).
3. **Isi `implementation_plan.md` Stage 5**:
   - Menyajikan tabel **Product Backlog & Sprint Roadmap** (`TASK-001` s.d. `TASK-00X` beserta estimasi *Story Points*) dan matriks pengujian Multi-Gate.
4. **Output Pasca-Proceed**:
   - Menulis `docs/10-development-plan.md`, `docs/11-test-plan.md` (`Status: APPROVED`), dan menginisialisasi `.ai/TEAM-BOARD.md` serta `.ai/current-task.md`.

---

## 2. Protokol Existing Project (Brownfield) & Auto-Update Tata Kelola
Pada proyek yang sudah berjalan (seperti proyek yang sudah di-live-kan di GitHub), AI wajib menerapkan **Prinsip Non-Destruktif & Sinkronisasi Versi**:
1. **Deteksi & Upgrade Versi `.governance/` Otomatis**:
   - Jalankan `bash .governance/scripts/check-governance-update.sh --check` (atau panggil dari folder master `AI_SDLC`).
   - Jika proyek masih menggunakan versi `.governance/` lama (misal v6.0.0) atau belum memiliki `.governance/`, tawarkan kepada pengguna untuk menjalankan `--apply` guna meng-upgrade aturan ke v7.2.0 tanpa menghapus `.ai/TEAM-BOARD.md` atau `docs/` yang sudah ada.
2. **Inspeksi Mendalam (*Read-First Policy*) & Larangan Rewrite Tanpa Izin**:
   - Wajib membaca arsitektur, infrastruktur, dan dependensi yang ada sebelum mengedit kode.
3. **Brownfield Missing-Docs Protocol (Reverse-Documentation & 5-Stage Alignment Interview)**:
   - Jika masuk ke proyek yang sudah berjalan namun dokumen utama di folder `docs/` (`00` s.d. `11`) belum ada atau belum lengkap, **AI DILARANG LANGSUNG MENGUBAH KODE FITUR**. AI wajib melakukan *Reverse-Documentation* dari kode/infrastruktur eksisting, melakukan wawancara penyelarasan dengan pengguna, dan mengesahkan blueprint di `docs/` melalui `implementation_plan.md` terlebih dahulu.
