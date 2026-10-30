# CLI Entrypoint Adapter
# Target: CLI Coding Assistants | Agile Scrum AI-SDLC v7.2.0

> ### ⚠️ 10 LARANGAN MUTLAK TATA KELOLA AGILE SCRUM AI-SDLC (WAJIB DITAATI SETIAP SAAT)
> 1. **DILARANG `git push`, `commit`, atau `add` OTOMATIS** tanpa perintah eksplisit pengguna.
> 2. **DILARANG MERUBAH FILE TANPA DoR, SPRINT 0 BLUEPRINT (`docs/00`–`11`) & IMPLEMENTATION PLAN** yang telah disetujui pengguna (kata kunci "proses").
> 3. **DILARANG MENULIS KODE APLIKASI SEBELUM 5-STAGE INTERACTIVE DISCOVERY (`docs/00`–`11`) SELESAI & APPROVED** — Baik mode `WORK TEAM` maupun `INDIVIDU`, AI **dilarang mengimajinasikan sendiri** spesifikasi konsumen/infrastruktur atau membuat 1 task full-stack sekaligus! Wajib wawancara mendalam & minta persetujuan bertahap (`implementation_plan.md` + `Proceed`) dari Hulu ke Hilir: Stage 1 (`docs/00-03` Vision/Flowchart/PRD), Stage 2 (`docs/04-05` Architecture & **Early Infrastructure Topology**), Stage 3 (`docs/06-07` ERD Relasi Tabel Database & API), Stage 4 (`docs/08-09` Wireframe/Mockup UI/UX & Security), dan Stage 5 (`docs/10-11` Granular Sprint Backlog & Test Plan).
> 4. **DILARANG MEMINTA / MENYARANKAN COMMIT ATAU PUSH SEBELUM GATE 2 (DoD L2) LULUS** — serahkan checklist *Acceptance Criteria (Given-When-Then)* ke pengguna dan BERHENTI.
> 5. **DILARANG MENGGUNAKAN `git config` SEBAGAI BUKTI IDENTITAS** — bukti sah identitas HANYA GitHub CLI (`gh api user`).
> 6. **DILARANG MEMBIARKAN REMOTE BRANCH `task/*` / `feature/*` SETELAH MERGE** — wajib dihapus di GitHub (`git push origin --delete ...`).
> 7. **ZERO-APPROVAL WORKSPACE SANDBOX SPLITTING (`RULE 3.5`)** — gunakan tool file bawaan untuk buat folder/file di workspace dan pisahkan perintah jaringan (`gh api user`) dari perintah lokal (`git status`, `cp`, `check-governance-update.sh`).
> 8. **WAJIB MENJALANKAN SIKLUS AGILE SCRUM & DEKOMPOSISI GRANULAR** — tanyakan mode `WORK TEAM` atau `INDIVIDU`, pecah pekerjaan menjadi beberapa Task modular (`TASK-001`, `TASK-002`, dst.), validasi *DoR*, *Story Points*, *Daily Standup*, *Burndown/Velocity*, serta *Sprint Review & Retrospective (Gate 4)*.
> 9. **FAIL-CLOSED PADA KEGAGALAN OTENTIKASI** — tolak seluruh aksi jika GitHub CLI unauthenticated / offline.
> 10. **DETERMINISTIC PRE-FLIGHT, VERSION CHECK & FAIL-CLOSED (OPSI B)** — Wajib jalankan tool terminal (`git status`, `check-governance-update.sh --check`, `gh api user`, `verify-identity.sh`) sebelum merespons di setiap turn. Anti-sycophancy: mismatch penugasan Sprint = tolak seketika (FAIL-CLOSED).

Primary Governance Authority: [.governance/CORE-RULES.md](.governance/CORE-RULES.md)
Sprint 0 & Discovery Protocol: [.governance/docs-reference/rules/04-project-context/01-greenfield-vs-brownfield.md](.governance/docs-reference/rules/04-project-context/01-greenfield-vs-brownfield.md)
Infrastructure Standard: [.governance/docs-reference/rules/03-engineering-standards/05-infrastructure-and-deployment.md](.governance/docs-reference/rules/03-engineering-standards/05-infrastructure-and-deployment.md)
Agile & Scrum Reference: [.governance/docs-reference/rules/04-project-context/03-agile-scrum-management.md](.governance/docs-reference/rules/04-project-context/03-agile-scrum-management.md)
