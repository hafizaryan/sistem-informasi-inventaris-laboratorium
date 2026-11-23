-- SITARIS - data contoh (SEPENUHNYA FIKTIF, hanya untuk demo lokal).
--
-- Impor SETELAH db/schema.sql, ke database kosong:
--   mysql -u <user> -p <nama_database> < db/demo.sql
--
-- Semua nama, email (example.com), nomor identitas, dan nomor telepon di sini rekaan.
-- Kolom password_hash berisi penanda yang tidak dapat dipakai login. Kata sandi akun demo
-- diatur lewat seeder (lihat README):  php spark db:seed DemoUserSeeder
-- Berkas gambar/dokumen yang dirujuk tersedia di public/uploads/ (awalan "demo-").

SET NAMES utf8mb4;
SET time_zone = '+00:00';
SET FOREIGN_KEY_CHECKS = 0;

INSERT INTO `fakultas` (`id_fakultas`, `nama_fakultas`) VALUES
(1, 'Fakultas Sains Contoh (DEMO)'),
(2, 'Fakultas Teknik Contoh (DEMO)');

INSERT INTO `prodi` (`id_prodi`, `id_fakultas`, `nama_prodi`) VALUES
(1, 1, 'Program Studi Sistem Informasi Contoh (DEMO)'),
(2, 1, 'Program Studi Matematika Contoh (DEMO)'),
(3, 2, 'Program Studi Teknik Jaringan Contoh (DEMO)');

INSERT INTO `pendanaan` (`id_pendanaan`, `jenis_pendanaan`, `keterangan`) VALUES
(1, 'Anggaran Fakultas DEMO', 'Sumber dana contoh dari anggaran fakultas (data fiktif)'),
(2, 'Anggaran Program Studi DEMO', 'Sumber dana contoh dari anggaran program studi (data fiktif)'),
(3, 'Hibah DEMO', 'Sumber dana contoh dari hibah (data fiktif)');

INSERT INTO `referensi` (`id_referensi`, `biaya`) VALUES
(1, '0'),
(2, '50000'),
(3, '100000');

INSERT INTO `gedung` (`id_gedung`, `id_fakultas`, `nama_gedung`, `deskripsi_gedung`, `gambar_gedung`) VALUES
(1, 1, 'Gedung A DEMO', 'Gedung contoh untuk laboratorium komputer (data fiktif).', 'demo-gedung.svg'),
(2, 2, 'Gedung B DEMO', 'Gedung contoh untuk laboratorium jaringan (data fiktif).', 'demo-gedung.svg');

INSERT INTO `ruangan` (`id_ruangan`, `id_gedung`, `nama_ruangan`, `deskripsi_ruangan`, `gambar_ruangan`) VALUES
(1, 1, 'Lab Komputer DEMO 1', 'Ruang praktikum komputer contoh.', 'demo-ruangan.svg'),
(2, 1, 'Lab Jaringan DEMO', 'Ruang praktikum jaringan contoh.', 'demo-ruangan.svg'),
(3, 2, 'Ruang Server DEMO', 'Ruang server contoh.', 'demo-ruangan.svg');

-- Akun demo. password_hash diisi oleh seeder DemoUserSeeder.
INSERT INTO `user` (`id_user`, `nama`, `foto`, `no_identitas`, `username`, `password_hash`, `email`, `role_user`) VALUES
(1, 'Kepala Lab DEMO',   'demo-user.svg', 'DEMO-0001', 'demokalab',     '!DEMO-BELUM-DISEED', 'kalab.demo@example.com',     'Kalab'),
(2, 'Admin DEMO',        'demo-user.svg', 'DEMO-0002', 'demoadmin',     '!DEMO-BELUM-DISEED', 'admin.demo@example.com',     'Admin'),
(3, 'Kaprodi DEMO',      'demo-user.svg', 'DEMO-0003', 'demokaprodi',   '!DEMO-BELUM-DISEED', 'kaprodi.demo@example.com',   'Kaprodi'),
(4, 'Sekprodi DEMO',     'demo-user.svg', 'DEMO-0004', 'demosekprodi',  '!DEMO-BELUM-DISEED', 'sekprodi.demo@example.com',  'Sekprodi'),
(5, 'Peminjam DEMO',     'demo-user.svg', 'DEMO-0005', 'demopeminjam',  '!DEMO-BELUM-DISEED', 'peminjam.demo@example.com',  'Peminjam'),
(6, 'Asisten Lab DEMO',  'demo-user.svg', 'DEMO-0006', 'demoaslab',     '!DEMO-BELUM-DISEED', 'aslab.demo@example.com',     'Aslab');

-- Inventaris. Status barang: '' (tersedia) atau 'diajukan' (sedang diajukan untuk dipinjam).
INSERT INTO `barang` (`id_barang`, `id_pendanaan`, `id_ruangan`, `nama_barang`, `spek_barang`, `gambar_barang`, `tahun_barang`, `kategori_barang`, `sub_kategori`, `kondisi`, `tgl_masuk_barang`, `waktu_input`, `deskripsi`, `user_input`, `user_edit`, `tgl_edit`, `status`) VALUES
(1, 1, 1, 'Komputer Desktop DEMO 01', 'CPU 4 core, RAM 8 GB, SSD 256 GB (spesifikasi fiktif)', 'demo-barang.svg', 2022, 'Perangkat', 'Komputer',  'Baik',  '2022-03-10', '09:00:00', 'Komputer contoh untuk praktikum.', 'Admin DEMO', '', NULL, ''),
(2, 1, 1, 'Monitor DEMO 01',            'Layar 22 inci Full HD (spesifikasi fiktif)',            'demo-barang.svg', 2022, 'Perangkat', 'Monitor',    'Baik',  '2022-03-10', '09:05:00', 'Monitor contoh.',                 'Admin DEMO', '', NULL, 'diajukan'),
(3, 2, 2, 'Router DEMO 01',             'Router 4 port Gigabit (spesifikasi fiktif)',            'demo-barang.svg', 2023, 'Perangkat', 'Router',     'Baik',  '2023-05-02', '10:00:00', 'Router contoh untuk praktikum jaringan.', 'Admin DEMO', '', NULL, 'diajukan'),
(4, 2, 2, 'Switch DEMO 01',             'Switch 24 port (spesifikasi fiktif)',                   'demo-barang.svg', 2023, 'Perangkat', 'Switch',     'Rusak', '2023-05-02', '10:10:00', 'Switch contoh, sedang diperbaiki.', 'Admin DEMO', 'Admin DEMO', '2025-02-01', ''),
(5, 3, 3, 'Proyektor DEMO 01',          'Proyektor 3000 lumen (spesifikasi fiktif)',             'demo-barang.svg', 2021, 'Media',     'Proyektor',  'Baik',  '2021-08-15', '11:00:00', 'Proyektor contoh.',               'Admin DEMO', '', NULL, ''),
(6, 3, 1, 'Kursi DEMO 01',              'Kursi lab, rangka besi (spesifikasi fiktif)',           'demo-barang.svg', 2021, 'Furnitur',  'Kursi',      'Baik',  '2021-08-15', '11:10:00', 'Kursi contoh.',                   'Admin DEMO', '', NULL, ''),
(7, 1, 3, 'Server DEMO 01',             'Server rak 1U (spesifikasi fiktif)',                    'demo-barang.svg', 2019, 'Perangkat', 'Server',     'Musnah','2019-01-20', '08:30:00', 'Server contoh yang telah dimusnahkan.', 'Admin DEMO', 'Admin DEMO', '2025-01-10', ''),
(8, 2, 2, 'Toolbox DEMO 01',            'Kotak perkakas jaringan (spesifikasi fiktif)',          'demo-barang.svg', 2023, 'Alat',      'Toolbox',    'Baik',  '2023-05-02', '10:20:00', 'Toolbox contoh.',                 'Admin DEMO', '', NULL, '');

INSERT INTO `dokumentasi` (`id_file`, `kategori_dokumentasi`, `nama_dokumentasi`, `deskripsi`, `upload_dokumentasi`, `tgl_upload`, `waktu_upload`, `user_upload`) VALUES
(1, 'Foto',    'Foto Lab Komputer DEMO', 'Foto contoh ruang praktikum (fiktif).',          'demo-foto.svg',    '2025-01-05', '09:30:00', 'Admin DEMO'),
(2, 'Dokumen', 'Panduan Lab DEMO',       'Dokumen contoh berisi tata tertib (fiktif).',   'demo-dokumen.pdf', '2025-01-06', '10:00:00', 'Admin DEMO');

-- Pemeliharaan.
INSERT INTO `maintenance` (`id_maintenance`, `id_barang`, `tgl_maintenance`, `kategori_maintenance`, `biaya`, `deskripsi_maintenance`, `bukti`, `status`) VALUES
(1, 4, '2025-02-01 09:00:00', 'Perbaikan', '150000', 'Perbaikan port switch contoh (fiktif).',     'demo-bukti.svg', 'Sedang_Proses'),
(2, 1, '2025-01-20 13:00:00', 'Perawatan', '0',      'Pembersihan dan pembaruan komputer contoh.', 'demo-bukti.svg', 'Selesai');

-- Pemusnahan.
INSERT INTO `pemusnahan_barang` (`id_musnah`, `id_barang`, `tgl_pemusnahan`, `bukti_pemusnahan`, `waktu`, `alasan`) VALUES
(1, 7, '2025-01-10', 'demo-pemusnahan.pdf', '14:00:00', 'Perangkat contoh tidak layak pakai (fiktif).');

-- Peminjaman barang. Status: diajukan, konfirmasi, dikembalikan, dibatalkan.
INSERT INTO `peminjaman_barang` (`id_peminjaman_barang`, `id_barang`, `id_fakultas`, `id_prodi`, `tgl_peminjaman`, `tgl_pengembalian`, `asal_peminjam`, `organisasi`, `nama_peminjam`, `email_peminjam`, `no_hp`, `bukti_peminjaman`, `biaya_peminjaman`, `keterangan`, `status`) VALUES
(1, '2', 1, 1, '2025-03-03', '2025-03-05', 'Internal',  'Himpunan Mahasiswa DEMO', 'Peminjam Satu DEMO', 'peminjam1.demo@example.com', '081200000001', 'demo-bukti.svg', '0',     'Peminjaman monitor untuk kegiatan contoh.', 'diajukan'),
(2, '3', NULL, NULL, '2025-03-10', '2025-03-12', 'Eksternal', 'Komunitas Contoh DEMO',  'Peminjam Dua DEMO',  'peminjam2.demo@example.com', '081200000002', 'demo-bukti.svg', '50000', 'Peminjaman router untuk pelatihan contoh.', 'konfirmasi'),
(3, '5', 1, 2, '2025-02-10', '2025-02-11', 'Internal',  'Himpunan Mahasiswa DEMO', 'Peminjam Tiga DEMO', 'peminjam3.demo@example.com', '081200000003', 'demo-bukti.svg', '0',     'Peminjaman proyektor, sudah dikembalikan.',  'dikembalikan'),
(4, '8', 2, 3, '2025-02-20', '2025-02-21', 'Internal',  'Kelompok Belajar DEMO',   'Peminjam Empat DEMO', 'peminjam4.demo@example.com', '081200000004', 'demo-bukti.svg', '0',     'Peminjaman toolbox, dibatalkan.',            'dibatalkan');

-- Peminjaman ruangan.
INSERT INTO `peminjaman_ruangan` (`id_peminjaman_ruangan`, `id_fakultas`, `id_prodi`, `id_ruangan`, `asal_peminjam`, `organisasi`, `nama_peminjam`, `email_peminjam`, `no_hp`, `tgl_peminjaman`, `nik_ktp`, `lama_peminjaman`, `biaya_peminjaman`, `bukti_peminjaman`, `keterangan`) VALUES
(1, 1, 1,    1, 'Internal',  'Himpunan Mahasiswa DEMO', 'Peminjam Lima DEMO', 'peminjam5.demo@example.com', '081200000005', '2025-03-15 08:00:00', 'DEMO-NIK-0001', '3 jam', '0',     'demo-bukti.svg', 'Pelatihan contoh di lab komputer.'),
(2, NULL, NULL, 2, 'Eksternal', 'Komunitas Contoh DEMO',  'Peminjam Enam DEMO', 'peminjam6.demo@example.com', '081200000006', '2025-03-20 13:00:00', 'DEMO-NIK-0002', '1 hari', '100000', 'demo-bukti.svg', 'Workshop contoh di lab jaringan.');

-- Pengunjung dan kunjungan.
INSERT INTO `pengunjung` (`id_pengunjung`, `nama_pengunjung`, `email`, `asal`) VALUES
(1, 'Pengunjung Satu DEMO', 'pengunjung1.demo@example.com', 'Internal'),
(2, 'Pengunjung Dua DEMO',  'pengunjung2.demo@example.com', 'Eksternal'),
(3, 'Pengunjung Tiga DEMO', 'pengunjung3.demo@example.com', 'Internal');

INSERT INTO `kunjungan` (`id_kunjungan`, `tanggal`, `jam_masuk`, `jam_keluar`, `keperluan`, `id_pengunjung`, `id_ruangan`) VALUES
(1, '2025-03-01', '09:00:00', '11:00:00', 'Praktikum',        1, 1),
(2, '2025-03-02', '13:00:00', '14:30:00', 'Studi banding',    2, 2),
(3, '2025-03-03', '10:00:00', '10:45:00', 'Konsultasi',       3, 3);

SET FOREIGN_KEY_CHECKS = 1;
