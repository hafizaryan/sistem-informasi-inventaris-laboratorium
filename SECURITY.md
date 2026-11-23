# Kebijakan Keamanan

## Melaporkan kerentanan

Jangan membuka issue publik untuk kerentanan. Gunakan fitur "Report a vulnerability" (Security Advisories) di GitHub pada repositori ini. Sertakan langkah reproduksi, versi/commit, dan dampaknya. Jangan sertakan data pribadi atau kredensial nyata.

<!-- PEMILIK: pastikan Private Vulnerability Reporting diaktifkan, atau tambahkan alamat email kontak di sini sebelum publikasi. -->

## Praktik yang berlaku

- Simpan kredensial database di `.env` lokal. Gunakan `.env.example` sebagai acuan.
- Mode demo (`sitaris.demoMode=true`) hanya berlaku saat `CI_ENVIRONMENT=development` dan diperlukan untuk membuat akun demo dengan seeder.
- Kata sandi akun demo ditentukan pengembang lewat `sitaris.demoPassword` dan disimpan dengan `password_hash()`. Repositori tidak memuat kata sandi bawaan.
- Jangan commit dump database, log, session, atau unggahan pengguna.

## Jika Anda menemukan rahasia di repositori

Laporkan secara privat seperti di atas, jangan diposting di issue. Pemilik layanan terkait harus merotasi kredensial tersebut.
