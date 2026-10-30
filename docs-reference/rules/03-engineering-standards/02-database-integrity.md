# STANDAR INTEGRITAS BASIS DATA & ATURAN NON-DESTRUKTIF
# Version: 1.0.0 | Date: 2026-10-02 | Scope: Database Schema & Migration Governance

## 1. Kebijakan Anti-Drop Mutlak (No-Drop Policy)
1. **Larangan Destruktif**:
   Dilarang keras menjalankan `DROP TABLE`, `DROP DATABASE`, `TRUNCATE`, atau `ALTER TABLE ... DROP COLUMN` pada database produksi atau existing project.
2. **Forward Migration**:
   Setiap modifikasi skema wajib menggunakan migrasi bertahap maju (*forward migration*) yang dapat di-*rollback* (`up` dan `down` scripts). Kolom lama yang tidak digunakan ditandai *deprecated* sebelum dihapus bertahap.

---

## 2. Integritas Relasi & Indexing
1. **Foreign Key Constraints**: Seluruh relasi entitas wajib dilindungi constraint foreign key nyata di tingkat mesin database (`ON DELETE RESTRICT` atau `CASCADE` yang terukur).
2. **Kewajiban Index**:
   - Kolom yang sering dijadikan kueri `WHERE`, `JOIN`, atau `ORDER BY` wajib memiliki indeks.
   - Kolom penanda identitas unik (misal: `email`, `agent_code`, `slug`) wajib memiliki `UNIQUE INDEX`.
3. **Kolom Wajib Timestamp**:
   Setiap tabel utama wajib memiliki kolom `created_at` (TIMESTAMP DEFAULT CURRENT_TIMESTAMP) dan `updated_at` (TIMESTAMP ON UPDATE CURRENT_TIMESTAMP).

---

## 3. Data Seeding & Skema Penamaan
1. **Penamaan Konsisten**: Nama tabel menggunakan huruf kecil jamak (*plural snake_case*, e.g., `backup_jobs`, `agents`). Kolom kunci primer adalah `id` (UUID atau BIGINT AUTO_INCREMENT).
2. **Idempotent Seeder**: Seeder data awal wajib idempotent (menggunakan `UPSERT` / `firstOrCreate` / `ON CONFLICT DO NOTHING`) agar aman dijalankan berulang kali tanpa duplikasi.
