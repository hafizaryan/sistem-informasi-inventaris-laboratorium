# SITARIS - Sistem Informasi Inventaris Laboratorium

SITARIS adalah sistem informasi berbasis web untuk pengelolaan inventaris laboratorium, dikembangkan dengan PHP dan CodeIgniter 4. Sistem ini membantu pencatatan barang dan peralatan laboratorium, peminjaman dan pengembalian, peminjaman ruangan, kunjungan, pemeliharaan, pemusnahan, sampai pembuatan laporan.

Pengembang: Hafiz Aryan Siregar, Indah Nirwana, dan Nasya Amirah Melyani.

> Semua data dalam `db/demo.sql`, berkas `public/uploads/demo-*`, dan aset `public/demo-assets/` adalah **fiktif**. Repositori ini tidak berisi data, kredensial, atau unggahan dari instalasi nyata.

## Fitur Utama

- **Inventaris**: barang dan peralatan beserta gedung, ruangan, fakultas, program studi, dan sumber pendanaan.
- **Peminjaman barang dan ruangan**: pengajuan, konfirmasi, pengembalian, pembatalan.
- **Kunjungan dan pengunjung**: struktur data kunjungan ke laboratorium.
- **Pemeliharaan** dan **pemusnahan** barang.
- **Dokumentasi** foto dan dokumen.
- **Laporan** inventaris yang dapat dicetak (TCPDF dan halaman cetak).
- **Peran pengguna**: Kalab, Admin, Kaprodi, Sekprodi, Peminjam, Aslab.

## Teknologi

- PHP 7.4 atau 8.x (ekstensi `intl`, `mbstring`, `json`, `curl`, `mysqli`), CodeIgniter 4
- MariaDB atau MySQL
- Bootstrap, template Gentelella (`public/gentelella-master/`)
- TCPDF

## Struktur Folder

- `app/` - kode aplikasi (Controllers, Models, Views, Config, Libraries, Database/Seeds)
- `public/` - document root dan aset publik
- `system/` - inti framework CodeIgniter 4
- `db/schema.sql` - struktur database (tanpa data)
- `db/demo.sql` - data contoh fiktif
- `writable/` - cache, log, session (tidak dilacak Git)
- `tests/` - kerangka pengujian PHPUnit

## Menjalankan Secara Lokal (mode demo)

### Prasyarat

- PHP 7.4 atau 8.x dengan ekstensi `intl`, `mbstring`, `json`, `curl`, `mysqli`
- [Composer](https://getcomposer.org/)
- MySQL atau MariaDB yang sudah berjalan
- Git

Di Windows, paket seperti [Laragon](https://laragon.org/) atau XAMPP sudah menyertakan PHP dan MySQL. Jika perintah `php` atau `composer` tidak dikenali, jalankan perintah di bawah dari terminal bawaan Laragon, atau tambahkan folder PHP dan Composer ke `PATH`.

### Langkah

1. Clone repositori, lalu masuk ke foldernya:
   ```bash
   git clone <url-repositori>
   cd sistem-informasi-inventaris-laboratorium
   ```
2. Instal dependensi:
   ```bash
   composer install
   ```
3. Buat database kosong dengan charset `utf8mb4`, misalnya `sitaris`:
   ```bash
   mysql -u <user> -p -e "CREATE DATABASE sitaris CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;"
   ```
4. Impor skema, lalu data contoh:
   ```bash
   mysql -u <user> -p sitaris < db/schema.sql
   mysql -u <user> -p sitaris < db/demo.sql
   ```
   Di PowerShell, operator `<` tidak didukung. Pakai Command Prompt (`cmd`), atau impor lewat HeidiSQL/phpMyAdmin.
5. Salin `.env.example` menjadi `.env` (`cp .env.example .env`, atau `copy .env.example .env` di Windows), lalu isi:
   - `CI_ENVIRONMENT = development`
   - `database.default.*` sesuai database lokal Anda (nama database, username, password)
   - `sitaris.demoMode = true`
   - `sitaris.demoPassword` dengan kata sandi pilihan Anda sendiri (tidak boleh kosong)
6. Buat kata sandi akun demo:
   ```bash
   php spark db:seed DemoUserSeeder
   ```
7. Jalankan server pengembangan:
   ```bash
   php spark serve
   ```
8. Buka `http://localhost:8080` dan masuk dengan salah satu akun demo. Kata sandinya adalah nilai `sitaris.demoPassword` dari langkah 5.

Akun demo (peran): `demokalab` (Kalab), `demoadmin` (Admin), `demokaprodi` (Kaprodi), `demosekprodi` (Sekprodi), `demopeminjam` (Peminjam), `demoaslab` (Aslab). Semua akun memakai kata sandi yang sama. Jika Anda mengubah `sitaris.demoPassword`, jalankan ulang seeder pada langkah 6.

### Masalah Umum

| Gejala | Penyebab dan solusi |
| --- | --- |
| `Class "CodeIgniter\Session\Handlers\FileHandler" not found` | Folder `system/Session/` tidak ada. Pastikan folder itu ikut ter-clone. Jika tidak ada, salin dari CodeIgniter 4.3.2 (`composer create-project codeigniter4/framework <folder> 4.3.2`, lalu ambil `system/Session`). |
| `Class ... not found` untuk kelas di `vendor/` | `composer install` belum dijalankan atau gagal. Jalankan ulang. |
| `Unable to connect to the database` | MySQL belum menyala, atau `database.default.*` di `.env` tidak sesuai. |
| `DemoUserSeeder` menolak berjalan | Pastikan `CI_ENVIRONMENT = development`, `sitaris.demoMode = true`, dan `sitaris.demoPassword` tidak kosong. |
| Login gagal untuk akun demo | Seeder belum dijalankan, atau `demoPassword` diubah setelah seeder. Jalankan ulang `php spark db:seed DemoUserSeeder`. |
| Halaman error karena folder tidak bisa ditulis | Pastikan `writable/` dapat ditulis oleh PHP. |
| Port 8080 sudah dipakai | `php spark serve --port 8081`, lalu sesuaikan `app.baseURL` di `.env`. |

### Perilaku mode demo

Mode demo aktif hanya jika `CI_ENVIRONMENT=development` **dan** `sitaris.demoMode=true`. Seeder `DemoUserSeeder` menolak berjalan di luar mode ini, menolak kata sandi kosong, dan menolak jika username demo sudah dipakai akun non-demo. Jangan mengaktifkan mode demo pada server yang dapat diakses publik.

## Konfigurasi di Luar Mode Demo

Semua konfigurasi lewat `.env` (lihat `.env.example`):

| Variabel | Fungsi |
| --- | --- |
| `CI_ENVIRONMENT` | `development` atau `production` |
| `app.baseURL`, `app.appTimezone` | URL dasar dan zona waktu |
| `database.default.*` | koneksi database |
| `sitaris.demoMode`, `sitaris.demoPassword` | mode demo dan kata sandi seeder |

## Berkas Unggahan

Unggahan pengguna disimpan di `public/uploads/` dan tidak dilacak Git (hanya berkas contoh berawalan `demo-`). Cache QR ada di `public/qr_cache/`.

## Kontribusi dan Keamanan

Lihat [CONTRIBUTING.md](CONTRIBUTING.md) dan [SECURITY.md](SECURITY.md).

## Lisensi

MIT, lihat berkas `LICENSE`. Aset pihak ketiga (misalnya template Gentelella) mengikuti lisensinya masing-masing.
