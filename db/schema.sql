-- SITARIS - skema database (hanya struktur, tanpa data).
--
-- Cara pakai: buat database kosong (utf8mb4), lalu impor berkas ini ke database tersebut.
--   mysql -u <user> -p <nama_database> < db/schema.sql
-- Berkas ini tidak membuat database dan tidak menghapus tabel yang sudah ada.
--
-- Catatan perbedaan dari dump asli:
--   * Tabel `kunjungan` diberi PRIMARY KEY dan AUTO_INCREMENT pada `id_kunjungan`
--     serta foreign key ke `pengunjung` dan `ruangan` (pada dump asli tidak ada).
--   * Foreign key ganda `peminjaman_ruangan_ibfk_1` (duplikat `fk_peminjaman_ruangan`) tidak disertakan.
--   * Lebar tampilan tipe integer (mis. tinyint(4)) dihilangkan agar kompatibel dengan MySQL 8.

SET NAMES utf8mb4;
SET time_zone = '+00:00';
SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE `fakultas` (
  `id_fakultas` tinyint NOT NULL AUTO_INCREMENT,
  `nama_fakultas` varchar(255) NOT NULL,
  PRIMARY KEY (`id_fakultas`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `pendanaan` (
  `id_pendanaan` smallint NOT NULL AUTO_INCREMENT,
  `jenis_pendanaan` varchar(100) NOT NULL,
  `keterangan` text NOT NULL,
  PRIMARY KEY (`id_pendanaan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `referensi` (
  `id_referensi` smallint NOT NULL AUTO_INCREMENT,
  `biaya` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_referensi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `gedung` (
  `id_gedung` tinyint NOT NULL AUTO_INCREMENT,
  `id_fakultas` tinyint NOT NULL,
  `nama_gedung` varchar(100) NOT NULL,
  `deskripsi_gedung` text NOT NULL,
  `gambar_gedung` varchar(255) NOT NULL,
  PRIMARY KEY (`id_gedung`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `prodi` (
  `id_prodi` tinyint NOT NULL AUTO_INCREMENT,
  `id_fakultas` tinyint NOT NULL,
  `nama_prodi` varchar(100) NOT NULL,
  PRIMARY KEY (`id_prodi`),
  KEY `fk_prodi` (`id_fakultas`),
  CONSTRAINT `fk_prodi` FOREIGN KEY (`id_fakultas`) REFERENCES `fakultas` (`id_fakultas`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `ruangan` (
  `id_ruangan` tinyint NOT NULL AUTO_INCREMENT,
  `id_gedung` tinyint NOT NULL,
  `nama_ruangan` varchar(100) NOT NULL,
  `deskripsi_ruangan` text NOT NULL,
  `gambar_ruangan` varchar(255) NOT NULL,
  PRIMARY KEY (`id_ruangan`),
  KEY `fk_ruangan` (`id_gedung`),
  CONSTRAINT `fk_ruangan` FOREIGN KEY (`id_gedung`) REFERENCES `gedung` (`id_gedung`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `user` (
  `id_user` smallint NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) NOT NULL,
  `foto` varchar(50) NOT NULL,
  `no_identitas` varchar(50) DEFAULT NULL,
  `username` varchar(100) NOT NULL,
  `password_hash` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `role_user` enum('Kalab','Admin','Kaprodi','Sekprodi','Peminjam','Aslab') NOT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `barang` (
  `id_barang` smallint NOT NULL AUTO_INCREMENT,
  `id_pendanaan` smallint NOT NULL,
  `id_ruangan` tinyint NOT NULL,
  `nama_barang` varchar(100) NOT NULL,
  `spek_barang` text NOT NULL,
  `gambar_barang` varchar(255) NOT NULL,
  `tahun_barang` year NOT NULL,
  `kategori_barang` enum('Media','Alat','Perangkat','Furnitur') NOT NULL,
  `sub_kategori` enum('Cutter','Krimping','Set_Obeng','Toolbox','Air_Conditioner','Jam_Dinding','Kursi','Lemari','Loker','Meja','Rak','GPS_Mobile','Layar_Proyektor','Livecam','Papan_Tulis','Proyektor','Access_Point','Antena','Camera_CCTV','Camera_Eksternal','CPU','Hardisk','Kabel','Keyboard','Komputer','LAN_Card','LAN_Tester','Monitor','Modem','Mouse','Poe_Adapter','RAM','Router','Server','Speaker','Switch','UPS','USB_Adapter','USB_Wireless','Wireless_Card') NOT NULL,
  `kondisi` enum('Baik','Rusak','Hilang','Musnah','Tak_Layak_Pakai') NOT NULL,
  `tgl_masuk_barang` date NOT NULL,
  `waktu_input` time NOT NULL,
  `deskripsi` varchar(250) NOT NULL,
  `user_input` varchar(100) NOT NULL,
  `user_edit` varchar(100) NOT NULL,
  `tgl_edit` date DEFAULT NULL,
  `status` varchar(25) NOT NULL,
  PRIMARY KEY (`id_barang`),
  KEY `fk_barang` (`id_pendanaan`),
  KEY `fk_barang_ruangan` (`id_ruangan`),
  CONSTRAINT `fk_barang` FOREIGN KEY (`id_pendanaan`) REFERENCES `pendanaan` (`id_pendanaan`),
  CONSTRAINT `fk_barang_ruangan` FOREIGN KEY (`id_ruangan`) REFERENCES `ruangan` (`id_ruangan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `dokumentasi` (
  `id_file` smallint NOT NULL AUTO_INCREMENT,
  `kategori_dokumentasi` enum('Foto','Dokumen') NOT NULL,
  `nama_dokumentasi` varchar(100) NOT NULL,
  `deskripsi` text NOT NULL,
  `upload_dokumentasi` varchar(255) NOT NULL,
  `tgl_upload` date NOT NULL,
  `waktu_upload` time NOT NULL,
  `user_upload` varchar(50) NOT NULL,
  PRIMARY KEY (`id_file`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `pengunjung` (
  `id_pengunjung` int NOT NULL AUTO_INCREMENT,
  `nama_pengunjung` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `asal` varchar(25) NOT NULL,
  PRIMARY KEY (`id_pengunjung`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `kunjungan` (
  `id_kunjungan` int NOT NULL AUTO_INCREMENT,
  `tanggal` date DEFAULT NULL,
  `jam_masuk` time DEFAULT NULL,
  `jam_keluar` time DEFAULT NULL,
  `keperluan` varchar(50) DEFAULT NULL,
  `id_pengunjung` int DEFAULT NULL,
  `id_ruangan` tinyint NOT NULL,
  PRIMARY KEY (`id_kunjungan`),
  KEY `fk_kunjungan_pengunjung` (`id_pengunjung`),
  KEY `fk_kunjungan_ruangan` (`id_ruangan`),
  CONSTRAINT `fk_kunjungan_pengunjung` FOREIGN KEY (`id_pengunjung`) REFERENCES `pengunjung` (`id_pengunjung`),
  CONSTRAINT `fk_kunjungan_ruangan` FOREIGN KEY (`id_ruangan`) REFERENCES `ruangan` (`id_ruangan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `maintenance` (
  `id_maintenance` smallint NOT NULL AUTO_INCREMENT,
  `id_barang` smallint NOT NULL,
  `tgl_maintenance` datetime NOT NULL,
  `kategori_maintenance` enum('Perbaikan','Perawatan') NOT NULL,
  `biaya` varchar(50) NOT NULL,
  `deskripsi_maintenance` text NOT NULL,
  `bukti` varchar(255) NOT NULL,
  `status` enum('Selesai','Sedang_Proses') NOT NULL,
  PRIMARY KEY (`id_maintenance`),
  KEY `fk_maintenance` (`id_barang`),
  CONSTRAINT `fk_maintenance` FOREIGN KEY (`id_barang`) REFERENCES `barang` (`id_barang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `pemusnahan_barang` (
  `id_musnah` smallint NOT NULL AUTO_INCREMENT,
  `id_barang` smallint NOT NULL,
  `tgl_pemusnahan` date NOT NULL,
  `bukti_pemusnahan` varchar(255) NOT NULL,
  `waktu` time NOT NULL,
  `alasan` text NOT NULL,
  PRIMARY KEY (`id_musnah`),
  KEY `fk_pemusnahan_barang` (`id_barang`),
  CONSTRAINT `fk_pemusnahan_barang` FOREIGN KEY (`id_barang`) REFERENCES `barang` (`id_barang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- `id_barang` berisi daftar id barang dipisah koma (bukan foreign key).
CREATE TABLE `peminjaman_barang` (
  `id_peminjaman_barang` smallint NOT NULL AUTO_INCREMENT,
  `id_barang` varchar(255) NOT NULL,
  `id_fakultas` tinyint DEFAULT NULL,
  `id_prodi` tinyint DEFAULT NULL,
  `tgl_peminjaman` date NOT NULL,
  `tgl_pengembalian` date NOT NULL,
  `asal_peminjam` enum('Internal','Eksternal') NOT NULL,
  `organisasi` varchar(255) NOT NULL,
  `nama_peminjam` varchar(100) NOT NULL,
  `email_peminjam` varchar(255) NOT NULL,
  `no_hp` varchar(25) NOT NULL,
  `bukti_peminjaman` varchar(255) DEFAULT NULL,
  `biaya_peminjaman` varchar(50) DEFAULT NULL,
  `keterangan` text NOT NULL,
  `status` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id_peminjaman_barang`),
  KEY `fk_peminjaman_barang` (`id_fakultas`),
  KEY `fk_peminjaman_barang_prodi` (`id_prodi`),
  CONSTRAINT `fk_peminjaman_barang` FOREIGN KEY (`id_fakultas`) REFERENCES `fakultas` (`id_fakultas`),
  CONSTRAINT `fk_peminjaman_barang_prodi` FOREIGN KEY (`id_prodi`) REFERENCES `prodi` (`id_prodi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `peminjaman_ruangan` (
  `id_peminjaman_ruangan` smallint NOT NULL AUTO_INCREMENT,
  `id_fakultas` tinyint DEFAULT NULL,
  `id_prodi` tinyint DEFAULT NULL,
  `id_ruangan` tinyint NOT NULL,
  `asal_peminjam` enum('Internal','Eksternal') DEFAULT NULL,
  `organisasi` varchar(255) NOT NULL,
  `nama_peminjam` varchar(100) NOT NULL,
  `email_peminjam` varchar(50) NOT NULL,
  `no_hp` varchar(50) NOT NULL,
  `tgl_peminjaman` timestamp NULL DEFAULT current_timestamp(),
  `nik_ktp` varchar(100) NOT NULL,
  `lama_peminjaman` varchar(50) NOT NULL,
  `biaya_peminjaman` varchar(50) DEFAULT NULL,
  `bukti_peminjaman` varchar(255) DEFAULT NULL,
  `keterangan` text NOT NULL,
  PRIMARY KEY (`id_peminjaman_ruangan`),
  KEY `fk_peminjaman_ruangan_prodi` (`id_prodi`),
  KEY `fk_peminjaman_ruangan_ruangan` (`id_ruangan`),
  KEY `fk_peminjaman_ruangan` (`id_fakultas`),
  CONSTRAINT `fk_peminjaman_ruangan` FOREIGN KEY (`id_fakultas`) REFERENCES `fakultas` (`id_fakultas`),
  CONSTRAINT `fk_peminjaman_ruangan_prodi` FOREIGN KEY (`id_prodi`) REFERENCES `prodi` (`id_prodi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

SET FOREIGN_KEY_CHECKS = 1;
