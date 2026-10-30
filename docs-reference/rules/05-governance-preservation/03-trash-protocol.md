# PROTOKOL PENGARSIPAN DOKUMEN & TATA KELOLA BERVERSI KE `.trash/`
# Version: 1.0.0 | Date: 2026-10-02 | Scope: System-Wide Document History & Rollback

## 1. Latar Belakang & Tujuan
Untuk menjaga integritas riwayat dokumen, mencegah kehilangan konteks saat revisi besar, dan memfasilitasi audit perubahan (*audit trail*) selama sesi kerja, repositori menerapkan protokol pencadangan otomatis ke direktori `.trash/`.

---

## 2. Prinsip Kerja Direktori `.trash/`
1. **Pengecualian Git (`.gitignore`)**:
   - Direktori `.trash/` wajib didaftarkan pada `.gitignore` agar file cadangan versi lama tidak mengotori *git tree*, commit log, atau *diff* repositori.
2. **Kewajiban Pencadangan Sebelum Modifikasi (*Backup-Before-Edit Rule*)**:
   - Setiap kali AI akan memodifikasi atau menimpa dokumen tata kelola (`agent.md`), piagam aktor (`rules/*`), dokumen arsitektur (`docs/*`), atau rencana kerja (`.ai/plans/*`), AI **WAJIB TERLEBIH DAHULU** menyalin versi eksisting ke folder `.trash/`.
3. **Konvensi Penamaan Berversi & Bertimestamp**:
   Format nama file cadangan di dalam `.trash/` wajib menyertakan versi dan timestamp:
   ```text
   .trash/<filename>-v<VERSION>.<YYYYMMDD_HHMMSS>.bak
   ```
   *Contoh*:
   - `.trash/agent.md-v2.3.0.20261002_083249.bak`
   - `.trash/01-project-owner.md-v1.0.0.20261002_083249.bak`
4. **Preservasi Tanpa Hapus Otomatis**:
   - Berkas di dalam `.trash/` tidak boleh dihapus secara otomatis oleh AI selama percakapan berlangsung. Pembersihan folder `.trash/` hanya boleh dilakukan atas instruksi eksplisit dari Human Project Owner.
