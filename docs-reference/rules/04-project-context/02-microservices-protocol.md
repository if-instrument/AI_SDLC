# PROTOKOL ARSITEKTUR MULTI-APLIKASI & MICROSERVICES
# Version: 1.0.0 | Date: 2026-10-02 | Scope: Distributed Systems & Service Boundaries

## 1. Tata Kelola Monorepo vs Polyrepo
1. **Pola Monorepo (Single Repository, Multi-Service)**:
   - Seluruh microservices berada dalam satu repositori dengan struktur modular: `services/<service-name>/` atau pemisahan jelas `agent/` dan `server/`.
   - Modul kontrak bersama berada di `shared/contracts/` atau didokumentasikan di `docs/06-api.md`.
   - Setiap service memiliki isolasi build, test suite, dan dependency lockfile mandiri.
2. **Pola Polyrepo (Multi-Repository, Multi-Service)**:
   - Setiap service memiliki repositori Git terpisah. Dikoordinasikan melalui Git Submodules atau central contract repository.

---

## 2. Isolasi Batas Layanan (Service-Scoped AI Agents)
- Setiap worker AI ditugaskan secara eksklusif ke satu service tertentu (misal: Worker A di `agent/`, Worker B di `server/`).
- **Anti-Contamination Rule**: Dilarang keras Worker Service A mengedit kode di dalam direktori Service B. Perubahan lintas-service harus dikoordinasikan melalui pembaruan kontrak bersama.

---

## 3. Komunikasi Antar-Layanan & Cross-Service Testing
- Komunikasi antar-service (REST, WebSocket, gRPC) diikat oleh kontrak formal di [`docs/06-api.md`](docs/06-api.md).
- Selain unit test lokal di masing-masing service (Gate 1), penggabungan ke branch milestone `feature/*` wajib memvalidasi kontrak dan menjalankan *cross-service integration test* (Gate 2).
