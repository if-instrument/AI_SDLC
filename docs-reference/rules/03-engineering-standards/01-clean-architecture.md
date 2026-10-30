# STANDAR ARSITEKTUR BERSIH (CLEAN ARCHITECTURE STANDARDS)
# Version: 1.0.0 | Date: 2026-10-02 | Scope: Code Architecture & Separation of Concerns

```text
+-------------------------------------------------------+
|  FRAMEWORKS & DRIVERS (Web, DB, CLI, UI)              |
|   +-----------------------------------------------+   |
|   |  INTERFACE ADAPTERS (Controllers, Presenters) |   |
|   |   +---------------------------------------+   |   |
|   |   |  APPLICATION BUSINESS RULES (UseCases)|   |   |
|   |   |   +-------------------------------+   |   |   |
|   |   |   |  ENTERPRISE BUSINESS RULES    |   |   |   |
|   |   |   |  (Entities / Models)          |   |   |   |
|   |   |   +-------------------------------+   |   |   |
|   |   +---------------------------------------+   |   |
|   +-----------------------------------------------+   |
+-------------------------------------------------------+
```

---

## 1. Aturan Ketergantungan (The Dependency Rule)
- Ketergantungan kode sumber **HANYA BOLEH MENGARAH KE DALAM** (menuju layer bisnis/entities).
- Layer dalam tidak boleh mengetahui apa pun tentang layer luar:
  - `Entity` tidak boleh mengimpor `UseCase` atau framework database/ORM.
  - `UseCase` tidak boleh mengimpor `Controller`, framework web, atau driver spesifik.
  - Detail teknis (DB SQL, HTTP transport, Cloud Storage SDK) berada di layer terluar (*Infrastructure/Adapters*).

---

## 2. Standar Struktur Folder
- `domain/` atau `core/entity/`: Pure business models & value objects tanpa dependensi framework.
- `usecase/` atau `service/`: Alur orkestrasi bisnis dan interface kontrak input/output.
- `adapter/` atau `repository/`: Implementasi interface terhadap database, client HTTP, atau filesystem.
- `delivery/` atau `controller/`: Handler REST API, WebSocket handler, atau CLI entrypoint.

---

## 3. Larangan Arsitektur Keras
- **Anti Circular Dependency**: Dilarang ketergantungan melingkar antar-package/modul.
- **Dependency Inversion**: Modul level tinggi tidak boleh bergantung pada modul level rendah; keduanya harus bergantung pada abstraksi (*interfaces*).
