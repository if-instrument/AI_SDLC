# UNIVERSAL ENTERPRISE AGILE & SCRUM AI-SDLC FRAMEWORK PACKAGE
# Version: 7.3.0 | Zero-Terminal Setup | Sprint 0 Interactive Blueprinting (`docs/00`–`11`), Early Infrastructure, Visual UI Mockups & Hybrid Auto-Updater

Paket folder `.governance/` ini adalah standar tata kelola rekayasa perangkat lunak (*Software Development Life Cycle*) berbasis manajemen proyek **Agile & Scrum**, **Sprint 0 Interactive Customer Discovery & Blueprinting (`docs/00`–`11` dengan Penentuan Infrastruktur di Hulu `docs/05-infrastructure.md`)**, **Zero-Approval Workspace Sandbox**, dan **Hybrid Cloud/Local Auto-Updater**.

---

## 🚀 Cara Membawa atau Meng-Update Framework Ini ke Proyek Baru / Proyek Lama

### Opsi A: Install / Auto-Update Otomatis via Script (`check-governance-update.sh`)
Untuk meng-install ke proyek baru atau meng-upgrade proyek lama (tanpa menghapus data `.ai/TEAM-BOARD.md` atau `docs/` yang sudah ada):
```bash
# Cek apakah proyek saat ini tertinggal versinya dibanding Master AI_SDLC (Local atau GitHub Cloud if-instrument/AI_SDLC)
bash /path/to/AI_SDLC/scripts/check-governance-update.sh --check /path/to/proyek-target

# Terapkan instalasi atau update ke v7.2.0 secara aman (otomatis backup versi lama ke .trash/)
bash /path/to/AI_SDLC/scripts/check-governance-update.sh --apply /path/to/proyek-target
```

### Opsi B: Buka Chat AI Anda & Ketik 1 Kalimat
Buka ruang obrolan Asisten AI di repositori Anda, dan ketik:
> 💬 **"Baca folder .governance"** (atau **"Update .governance"**)

### ✨ Apa yang Terjadi Otomatis?
1. AI membaca seluruh aturan operasional, kerangka kerja **Agile & Scrum + Sprint 0 Blueprinting (`docs/00`–`11`)**, dan 10 LARANGAN MUTLAK di `.governance/CORE-RULES.md`.
2. AI menjalankan `check-governance-update.sh --check` untuk memeriksa apakah ada pembaruan versi `.governance/` di Master `AI_SDLC` (Local maupun GitHub Cloud `if-instrument/AI_SDLC`).
3. AI memeriksa sesi login GitHub aktif (`gh api user`) secara fail-closed dan memvalidasi hak akses akun pada repositori.
4. AI mengaktifkan Git Hooks pelindung (`.governance/hooks/`) secara otomatis.
5. AI mengunci diri pada aturan **Sprint 0 Interactive Blueprinting + Agile Scrum Multi-Gate SDLC Protocol (DoR + DoD Gate 0–4)**:
   - **Wajib Sprint 0 (`docs/00`–`11` dari Hulu ke Hilir)**:
     - **Stage 1 (`00`–`03`)**: Vision, Requirements, Business Process Flowchart & PRD.
     - **Stage 2 (`04`–`05`)**: System Architecture & **Early Infrastructure/Deployment Topology (`05-infrastructure.md`)** — *dikunci di awal sebelum Database/API/UI!*
     - **Stage 3 (`06`–`07`)**: Database ERD Relasi Tabel (`06-database.md`) & API Contracts (`07-api.md`).
     - **Stage 4 (`08`–`09`)**: UI/UX Visual Mockups (`08-ui-ux.md` — **wajib gambar visual `.png` via `image-generator` + `carousel` preview**, dilarang hanya teks/ASCII!) & Security/RBAC (`09-security.md`).
     - **Stage 5 (`10`–`11`)**: Granular Sprint Backlog (`10-development-plan.md`) & Multi-Gate Test Plan (`11-test-plan.md`).
   - **Zero-Approval Workspace Operations (`RULE 3.5`)**: Menggunakan tool file bawaan (`write_file`/`edit_file`) dan memisahkan perintah jaringan (`gh api user`) dari perintah lokal (`BypassSandbox: false`).

---

## 📂 Struktur Isi Paket

| File / Folder | Fungsi & Peran |
| :--- | :--- |
| **`VERSION`** | Manifest versi (`7.2.0`), lokasi sumber Local Master & GitHub Cloud (`if-instrument/AI_SDLC`). |
| **`CORE-RULES.md`** | **SOP Eksekutabel Utama (Single Source of Truth v7.2.0)**: 10 Larangan Mutlak, Protokol Sprint 0 (`docs/00`–`11`), RULE 3.5 Zero-Approval Sandbox, Kerangka Agile & Scrum, dan Decision Tree. |
| **`IDENTITY-SECURITY.md`** | Spesifikasi teknis anti-spoofing berbasis token GitHub (`gh api user` + Permission API). |
| **`WORKFLOW-STATE-MACHINE.md`** | Spesifikasi alur Sprint 0 Blueprinting (`docs/00`–`11`) + Agile Sprint Execution (Dual Execution Mode). |
| **`scripts/check-governance-update.sh`** | Pendeteksi versi & self-updater non-destruktif (mendukung Local Master & GitHub Cloud). |
| **`scripts/lib-identity.sh` & `verify-identity.sh`** | Pustaka dan validator identitas kriptografis sesi GitHub CLI. |
| **`hooks/`** | Git hooks pelindung (`pre-commit` v3.2.0 dengan **Sprint 0 Blueprint Enforcer `docs/00`–`11` & Version Notifier**, `pre-push` dengan **Gate 2 Enforcer**, dan `post-checkout`). |
| **`templates/`** | Template siap pakai untuk Agile Sprint & Scrum Board (`TEAM-BOARD`), Daily Scrum (`current-task`), dan Checklist DoD (`GATE-CHECKLIST`). |
| **`docs-reference/`** | Piagam aturan detail per peran Scrum, standar infrastruktur (`05-infrastructure-and-deployment.md`), protokol 5-Stage Discovery (`01-greenfield-vs-brownfield.md`), dan manajemen Agile/Scrum (`03-agile-scrum-management.md`). |
| **`adapters/`** | File panduan entrypoint ringkas untuk berbagai antarmuka AI (`GEMINI.md`, `CLAUDE.md`, `agent.md`, `.cursorrules`, `copilot-instructions.md`). |
