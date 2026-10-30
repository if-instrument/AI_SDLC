# STANDAR UI/UX ARCHITECTURE & VISUAL MOCKUP GENERATION (`docs/08-ui-ux.md`)
# Version: 1.0.0 | Date: 2026-10-30 | Scope: Mandatory Visual UI Mockups (`image-generator` `.png`, Carousel Preview & Interactive HTML/CSS) at Stage 4

## 1. Larangan Mutlak Wireframe Teks/ASCII Semata (*No Text/ASCII-Only Wireframes*)
> [!IMPORTANT]
> **WAJIB MENAMPILKAN DESAIN VISUAL NYATA DI STAGE 4 (`docs/08-ui-ux.md`)**:
> Pada saat proyek memasuki **Stage 4 (UI/UX & Security Blueprint)**, AI **DILARANG KERAS** hanya menyajikan wireframe teks ASCII atau hanya mendaftar komponen dalam bentuk teks biasa!
> Pengguna membutuhkan representasi visual nyata (gambar desain layar / prototipe visual) untuk memvalidasi tata letak, hierarki informasi, tema warna, dan pengalaman pengguna sebelum menyetujui tombol **Proceed**.

---

## 2. Protokol 3-Lapis Pembuatan Visual UI/UX Mockup di Stage 4

Setelah sesi wawancara **Stage 4** selesai (menggali daftar halaman/layar utama, struktur navigasi, preferensi tema Dark/Light mode, palet warna, dan komponen interaktif), sebelum mengajukan `implementation_plan.md` Stage 4, AI **WAJIB** menjalankan langkah berikut:

### Lapis 1 (WAJIB UTAMA): High-Fidelity Visual UI Mockup Images via `image-generator` Subagent
1. **Generate Gambar Desain Layar Utama (`.png`)**:
   - Panggil subagent bawaan **`image-generator`** (`invoke_subagent` dengan `TypeName: "image-generator"`) untuk men-generate gambar visual UI Mockup beresolusi tinggi untuk setiap layar/halaman utama aplikasi (minimal 1–3 layar kunci, misalnya: *Main Dashboard*, *Workspace/Editor Screen*, *Detail/Analytics Modal*).
   - Pastikan prompt ke `image-generator` mencantumkan secara spesifik hasil wawancara pengguna: tema warna (misal: Dark Slate `#0F172A` dengan aksen Emerald/Indigo), tata letak navigasi (Sidebar/Topbar), kartu metrik, tabel data, dan grafik yang relevan dengan domain proyek.
2. **Simpan di Workspace & Salin ke Artifact Directory**:
   - Simpan atau salin file gambar `.png` hasil `image-generator` ke dalam folder proyek: **`docs/assets/mockups/<nama-layar>.png`**.
   - Salin juga file `.png` tersebut ke dalam **Artifact Directory** percakapan aktif (`<appDataDir>/brain/<conversation-id>/<nama-layar>.png`) sesuai aturan penyematan file artefak IDE.
3. **Sematkan Langsung (*Embed*) di `implementation_plan.md` dan `docs/08-ui-ux.md`**:
   - Tampilkan gambar mockup secara langsung menggunakan sintaks Markdown `![Deskripsi Layar](/absolute/path/to/artifact/mockup.png)`.
   - Jika terdapat lebih dari 1 layar, gunakan blok **Carousel** (````carousel` dengan pemisah `<!-- slide -->`) di dalam `implementation_plan.md` agar pengguna dapat menggeser dan meninjau setiap layar dengan nyaman sebelum menekan tombol **Proceed**!

### Lapis 2 (OPSIONAL / PENDUKUNG INTERAKTIF): Interactive HTML/CSS Widget (`generative_ui`)
- Apabila pengguna menginginkan simulasi komponen interaktif (seperti klik tab, filter, atau animasi state), AI dapat mengaktifkan skill **`generative_ui`** atau membuat file prototipe mandiri `docs/assets/mockups/ui-preview.html` yang dapat dibuka langsung oleh pengguna.

### Lapis 3 (WAJIB PENDAMPING STRUKTURAL): Screen Flow Diagram & Spesifikasi State Komponen
1. **Diagram Alur Perpindahan Layar (`Screen Flow`)**:
   - Gunakan diagram `flowchart LR` atau `stateDiagram-v2` (Mermaid) untuk memetakan perpindahan pengguna dari satu layar ke layar lainnya (termasuk kondisi autentikasi/redirect).
2. **Anotasi Komponen & Penanganan 4 State Wajib**:
   - Setiap layar utama wajib memiliki tabel spesifikasi komponen (Tombol, Tabel, Form, Modal) beserta perilaku pada 4 kondisi (*states*):
     - **`Loading State`** (Skeleton loader / spinner).
     - **`Empty State`** (Ilustrasi / pesan saat belum ada data + tombol CTA pertama).
     - **`Error State`** (Toast / inline banner pesan error yang ramah pengguna + tombol Retry).
     - **`Success / Populated State`** (Tampilan normal saat data terisi penuh).

---

## 3. Struktur Wajib Dokumen `docs/08-ui-ux.md`
Setiap dokumen `docs/08-ui-ux.md` yang ditulis setelah `implementation_plan.md` Stage 4 disetujui wajib memuat:
1. **Header Metadata Status**: `Status: APPROVED | Stage: 4 (UI/UX & Visual Mockups)`.
2. **Design System & Theme Tokens**:
   - Mode warna (*Dark Mode* / *Light Mode* / *Adaptive*), kode warna Hex utama (`Primary`, `Secondary`, `Background`, `Surface`, `Success`, `Warning`, `Danger`), serta tipografi (`Font Family`, ukuran heading/body).
3. **Galeri Visual UI Mockups (`docs/assets/mockups/*.png`)**:
   - Gambar visual mockup yang telah disetujui pengguna untuk setiap layar utama.
4. **Diagram Alur Navigasi Layar (*User Screen Flow*)**:
   - Diagram Mermaid yang menghubungkan seluruh halaman/modal.
5. **Spesifikasi Komponen per Layar & Penanganan State (`Loading`, `Empty`, `Error`, `Success`)**.
6. **Standar Responsivitas & Aksesibilitas**:
   - Breakpoints layar (Desktop, Tablet, Mobile) dan navigasi keyboard/kontras.
