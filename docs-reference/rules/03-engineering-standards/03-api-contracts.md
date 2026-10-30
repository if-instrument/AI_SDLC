# STANDAR KONTRAK API & ZERO BREAKING CHANGES
# Version: 1.0.0 | Date: 2026-10-02 | Scope: API Specification & Wire Protocols

## 1. Pendekatan Contract-First
- Desain API wajib didokumentasikan dan disetujui di [`docs/06-api.md`](docs/06-api.md) sebelum endpoint atau client ditulis.
- Spesifikasi mencakup: metode HTTP, URL path versi (`/api/v1/...`), struktur header, parameter kueri, skema request body JSON, skema response body JSON, dan daftar status code HTTP.

---

## 2. Struktur Standar Respons JSON
Seluruh endpoint REST API wajib mengembalikan payload terstandarisasi:

```json
{
  "success": true,
  "message": "Deskripsi singkat hasil operasi",
  "data": { ... },
  "error": null,
  "meta": {
    "timestamp": "2026-10-02T08:00:00Z",
    "request_id": "req-12345"
  }
}
```

Format respons error:
```json
{
  "success": false,
  "message": "Pesan error yang aman untuk pengguna",
  "data": null,
  "error": {
    "code": "VALIDATION_FAILED",
    "details": [
      {"field": "email", "message": "Email is invalid"}
    ]
  },
  "meta": {
    "timestamp": "2026-10-02T08:00:00Z"
  }
}
```

---

## 3. Kebijakan Zero Breaking Changes
1. **Aturan Backward Compatibility**:
   Dilarang menghapus field yang sudah aktif digunakan oleh client. Field baru wajib bersifat opsional (*nullable* atau memiliki default value).
2. **Versioning Ketat**:
   Jika perubahan merusak (*breaking changes*) tidak dapat dihindari, wajib membuat prefix versi baru (misal: `/api/v2/`) dan mempertahankan endpoint versi lama hingga masa transisi selesai.
