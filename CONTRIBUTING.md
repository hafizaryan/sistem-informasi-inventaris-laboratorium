# Berkontribusi ke SITARIS

Terima kasih sudah tertarik berkontribusi.

## Menyiapkan lingkungan lokal

Ikuti bagian "Menjalankan Secara Lokal (mode demo)" di [README.md](README.md). Gunakan `.env.example` sebagai dasar `.env`, impor `db/schema.sql` dan `db/demo.sql`, lalu jalankan seeder dengan kata sandi pilihan Anda sendiri.

## Aturan data dan rahasia

- Jangan commit `.env`, kunci API, dump database, log, session, atau unggahan nyata.
- Data contoh harus fiktif: email `example.com`, identitas bertanda `DEMO`.
- Kredensial dibaca dari environment, tidak ditulis di kode atau komentar.
- Jangan menambahkan logo, foto, atau aset lain yang hak publikasinya belum jelas.
- Perubahan skema harus diikuti pembaruan `db/schema.sql` dan, bila perlu, `db/demo.sql` (semua tabel tetap terisi dan relasi valid).

## Alur kontribusi

1. Fork repositori dan buat cabang dari `main`.
2. Buat perubahan kecil dan fokus, ikuti gaya kode yang sudah ada.
3. Jalankan pengujian yang relevan di lingkungan Anda dan uji manual alur yang berubah.
4. Buka pull request dengan penjelasan masalah, solusi, dan cara menguji.

## Melaporkan masalah

Bug dan usulan fitur lewat issue. Kerentanan keamanan jangan dilaporkan lewat issue publik; lihat [SECURITY.md](SECURITY.md).
