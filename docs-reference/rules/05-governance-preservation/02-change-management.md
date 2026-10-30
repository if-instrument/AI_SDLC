# MANAJEMEN PERUBAHAN & KENDALI MUTU (CHANGE MANAGEMENT, CR & ADR)
# Version: 1.0.0 | Date: 2026-10-02 | Scope: Change Request & Architecture Decisions

## 1. Urutan Mutlak Perubahan (*Changes Pipeline*)
Setiap perubahan fungsional atau arsitektur wajib mematuhi alur sekuensial:

```text
PROPOSE -> ASK -> ANALYZE -> APPROVE -> UPDATE DOCUMENTATION -> IMPLEMENT -> REGRESSION TEST -> REVIEW -> RELEASE
```

---

## 2. Change Request (CR) Formal
1. Perubahan pada kebutuhan yang telah berstatus `APPROVED` wajib diajukan melalui dokumen formal di `docs/changes/CR-XXX.md`.
2. Format dokumen CR mencakup:
   - ID & Judul Perubahan
   - Latar belakang & alasan bisnis
   - Komponen & dokumen yang terdampak
   - Analisis risiko & strategi rollback
   - Estimasi effort
3. Dokumen CR wajib berstatus `APPROVED` oleh Human Project Owner sebelum kode boleh disentuh.

---

## 3. Architectural Decision Record (ADR)
1. Setiap keputusan arsitektural yang signifikan (pemilihan database, library kriptografi, pola dumper subprocess, arsitektur WebSocket heartbeat) wajib diabadikan di `docs/decisions/ADR-XXX.md`.
2. Format ADR mematuhi standar:
   - **Title**: Keputusan yang diambil
   - **Status**: PROPOSED / ACCEPTED / SUPERSEDED
   - **Context**: Masalah dan kendala yang dihadapi
   - **Decision**: Pilihan solusi yang diadopsi
   - **Consequences**: Dampak positif dan negatif yang diterima
