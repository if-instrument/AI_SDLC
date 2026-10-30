# STANDAR KEAMANAN, ENKRIPSI & ZERO SECRET LEAK
# Version: 1.0.0 | Date: 2026-10-02 | Scope: Application Security & Hardening

## 1. Perlindungan Rahasia Mutlak (Zero Secret Leak)
1. **Dilarang Hardcode**: Dilarang keras menaruh API key, password database, private key RSA, secret JWT, atau token autentikasi di dalam kode sumber repositori.
2. **Kewajiban `.env`**: Kredensial wajib dikonsumsi melalui environment variables dengan template `.env.example` yang hanya memuat key dummy tanpa value sensitif.
3. **Pembersihan Log**: Parameter sensitif (password, authorization token) wajib di-mask/redact sebelum dicetak ke console atau log file (`[REDACTED]`).

---

## 2. Standar Enkripsi & Hashing
1. **Password User**: Wajib menggunakan algoritma hashing modern yang tahan serangan brute-force: `bcrypt` (cost minimum 12) atau `Argon2id`. Dilarang menggunakan MD5 atau SHA-1.
2. **Data At Rest & Injected Payload**: Menggunakan enkripsi simetris terstandarisasi industri: **AES-256-GCM** dengan nonce acak 12-byte per operasi enkripsi.
3. **Integritas File**: Setiap berkas backup atau transmisi chunk wajib divalidasi checksum **SHA-256** secara *on-the-fly*.

---

## 3. Sanitasi Input & Pertahanan Injeksi
1. **SQL Injection Defense**: Seluruh interaksi database wajib menggunakan *parameterized queries* atau *prepared statements*. Dilarang string concatenation untuk membangun SQL query.
2. **Command Injection Defense**: Seluruh pemanggilan binary eksternal (misal: `mysqldump`, `pg_dump`) wajib dilewatkan sebagai argumen terpisah (`exec.Command(bin, arg1, arg2)`), BUKAN melalui shell string interpolasi (`sh -c ...`).
3. **Path Traversal Defense**: Setiap manipulasi file wajib divalidasi dengan `filepath.Clean` dan diverifikasi berada di dalam direktori root yang diizinkan.
