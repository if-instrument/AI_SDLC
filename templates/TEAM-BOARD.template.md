# Agile Scrum & Sprint Governance Board

- **Active Execution Mode**: `[WORK_TEAM | INDIVIDUAL]`
- **Governance Framework**: `Universal Agile Scrum & Multi-Gate SDLC Protocol (DoR + DoD Gate 0-4)`
- **Active Sprint ID**: `SPRINT-01`
- **Sprint Goal**: `[Rumusan nilai bisnis utama yang ingin dicapai pada akhir Sprint ini]`
- **Sprint Timebox**: `[YYYY-MM-DD s/d YYYY-MM-DD]`
- **Sprint Integration Branch**: `[feature-branch-name]`

---

## 1. Sprint Backlog & Matrix Tugas

> [!IMPORTANT]
> Urutan 11 kolom pertama wajib dipertahankan untuk kompatibilitas mekanis dengan Git Hooks (`pre-commit`, `pre-push`, dan `post-checkout`).

| Milestone & Task ID | User Story & Modul | Mode Eksekusi | Prasyarat & DoR | Assigned Developer | Dedicated Branch | Status | Gate 1 | Gate 2 | Gate 3 | Gate 4 | Story Points (SP) |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :---: |
| **TASK-001** | [US-001] Foundation | SEKUENSIAL | DoR: READY (-) | UNASSIGNED | feature/TASK-001 | BACKLOG | PENDING | PENDING | WAITING | WAITING | 3 SP |
| **TASK-002** | [US-002] Core Module | PARALEL | DoR: WAITING (TASK-001) | UNASSIGNED | feature/TASK-002 | BACKLOG | PENDING | PENDING | WAITING | WAITING | 5 SP |

---

## 2. Sprint Velocity & Burndown Tracker

- **Committed Story Points**: `8 SP`
- **Completed Story Points (MERGED / DONE)**: `0 SP`
- **Remaining Story Points (Burndown)**: `8 SP`
- **Sprint Progress**: `[░░░░░░░░░░] 0%`

| Hari / Iterasi | Target Ideal Remaining (SP) | Actual Remaining (SP) | Completed Task / User Story | Status Burndown |
| :--- | :---: | :---: | :--- | :--- |
| **Sprint Start** | 8 SP | 8 SP | - | ON TRACK |

---

## 3. Daily Scrum (Async Standup) & Impediment Log

| Timestamp | Aktor / Scrum Dev | Done Since Last Sync | Active Focus (Doing) | Impediments / Blockers |
| :--- | :--- | :--- | :--- | :--- |
| `YYYY-MM-DD HH:MM` | `@username` | Inisiasi Sprint Planning | Menunggu penugasan TASK-001 | Tidak ada (None) |

---

## 4. Status Antrean, Definition of Ready (DoR) & JIT Branching

Cabang fisik Git (`feature/*` atau `task/*`) baru boleh dibuat saat item memenuhi **Definition of Ready (DoR)**, prasyarat hulu berstatus `MERGED`, dan Product Owner mengesahkan penugasan developer.
