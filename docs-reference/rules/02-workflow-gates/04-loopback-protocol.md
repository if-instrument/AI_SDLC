# PROTOKOL LOOPING GATE 2, VERSION BUMP & ROOT CAUSE ANALYSIS
# Version: 1.0.0 | Date: 2026-10-02 | Scope: Defect Handling & Revisioning

## 1. Aturan Pengulangan (*Looping Rule*)
1. Jika dalam pengujian manual Gate 2 ditemukan kegagalan, bug, tool yang tidak terdeteksi di OS aktual, atau deviasi fungsional:
   - Task **TIDAK BOLEH DITUTUP** atau dilanjutkan ke worker berikutnya.
   - Alur kerja **WAJIB LOOPING** di task branch aktif tersebut untuk diperbaiki oleh pasangan Worker Unit (Developer + AI).

---

## 2. Kewajiban Proaktif Version Bump pada Implementation Plan
1. **Dilarang Hanya Mengubah Artefak Chat**:
   - AI dilarang hanya memperbaiki penjelasan di layar chat sementara repositori kehilangan jejak perbaikan.
2. **Kewajiban Pembuatan Rencana Revisi Persisten**:
   - AI **WAJIB SECARA OTOMATIS** menaikkan nomor versi plan (*version bump*) dan membuat berkas rencana revisi baru di:
     `.ai/plans/PLAN-<TASK_ID>-v<MAJOR>.<MINOR>.<PATCH>.md`
3. **Bagian Wajib Root Cause Analysis**:
   Rencana revisi wajib memuat analisis terstruktur:
   - **Loopback Justification**: Mengapa pengujian manual gagal.
   - **Root Cause Analysis (RCA)**: Akar masalah teknis kegagalan.
   - **Proposed Rectification**: Solusi teknis definitif untuk mengatasi akar masalah tersebut.
4. Perbaikan kode hanya boleh dimulai setelah Human Developer menyetujui rencana revisi baru tersebut.
