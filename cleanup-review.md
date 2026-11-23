# cleanup-review

Peninjauan pembersihan salinan open source SITARIS di `opensource-prep`.

**Status: semua pemeriksaan bersifat statis.** Tidak ada build, aplikasi, test, `composer install`, impor database, seeder, commit, atau push yang dijalankan. Salinan ini **belum siap publikasi** sampai rotasi credential, penanganan akun dan session yang terekspos, konfirmasi hak aset, dan verifikasi runtime selesai (lihat bagian "Syarat sebelum publikasi").

Tidak ada credential atau data pribadi yang dicantumkan di berkas ini.

## Cara membaca

Kolom **sumber**:

- `CHK` : keadaan atau rujukan diperiksa ulang langsung pada sesi ini (absen di salinan, ada di repo sumber, jumlah rujukan tersisa).
- `LOG` : penghapusan dijalankan oleh skrip bersih yang menulis log di luar repo (`C:\t\clean1.log`, `C:\t\s7.txt`). Jumlah berkas dan ukuran diambil dari log itu.
- `LAPORAN` : hanya tercatat di laporan sesi sebelumnya (skrip persiapan awal), tanpa log terpisah. Keadaan akhirnya tetap diperiksa lewat `CHK`.

Kolom **ada di sumber** memeriksa path yang sama di `C:\laragon\www\sitaris` (hanya `Test-Path`, isi tidak dibaca). Jika `ya`, penghapusan bisa ditelusuri dan dibalik dari repo sumber.

Kolom **rujukan tersisa** adalah jumlah berkas di salinan (app, db, tests, README, `composer.json`, aset kustom Gentelella, dan CSS/JS/HTML pustaka yang dipertahankan) yang masih memuat path `/<nama>/` pustaka tersebut. Angka 0 berarti tidak ada yang merujuk.

## Fakta framework yang dipakai sebagai dasar

- CodeIgniter 4.3.2. `system/Router/RouteCollection.php` mendeklarasikan `protected $autoRoute = false`, `app/Config/Routing.php` tidak ada, `Feature::$autoRoutesImproved = false`, dan tidak ada pemanggilan `setAutoRoute()` yang aktif. **Auto-route nonaktif**, jadi controller tanpa route eksplisit tidak dapat dijangkau lewat URL.
- `RouteCollection::create()` (baris 1287-1386): untuk route tanpa opsi `hostname`/`subdomain`, `$overwrite = false`, dan baris 1381 mengembalikan tanpa menulis bila kunci route sudah ada. **Deklarasi pertama untuk verb+path yang sama yang berlaku**, deklarasi berikutnya diabaikan.


## A. Pustaka JS/CSS template tidak terpakai (`public/gentelella-master/vendors/`)

**Alasan umum:** tidak ada `<script>`/`<link>` di view atau layout yang memuat pustaka ini, dan tidak ada path ke dalamnya di kode aplikasi, data demo, README, aset kustom, atau pustaka lain yang dipertahankan. Penghapusan dilakukan per direktori utuh. Pencarian hanya berdasarkan nama berkas tidak dipakai sebagai satu-satunya dasar: pemeriksaan memakai path `/<nama>/` di seluruh korpus teks, termasuk rujukan dinamis berupa string di `custom.min.js` dan `myscript.js`.
| path | ukuran | sumber | ada di sumber | absen sekarang | rujukan tersisa |
|---|---|---|---|---|---|
| `public/gentelella-master/vendors/autosize/` | 12 berkas, 26 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/bootstrap-daterangepicker/` | 19 berkas, 336 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/bootstrap-datetimepicker/` | 80 berkas, 2804 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/bootstrap-progressbar/` | 69 berkas, 718 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/bootstrap-wysiwyg/` | 17 berkas, 72 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/cropper/` | 32 berkas, 245 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/DateJS/` | 822 berkas, 34070 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/devbridge-autocomplete/` | 13 berkas, 100 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/dropzone/` | 11 berkas, 221 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/echarts/` | 590 berkas, 13743 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/eve/` | 7 berkas, 27 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/Flot/` | 184 berkas, 3582 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/flot-spline/` | 6 berkas, 10 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/flot.curvedlines/` | 3 berkas, 17 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/flot.orderbars/` | 7 berkas, 123 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/fontawesome/` | 40 berkas, 1044 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/fullcalendar/` | 64 berkas, 886 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/gauge.js/` | 28 berkas, 405 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/google-code-prettify/` | 48 berkas, 353 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/ion.rangeSlider/` | 23 berkas, 198 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/jquery-knob/` | 12 berkas, 117 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/jquery-mousewheel/` | 7 berkas, 20 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/jquery-sparkline/` | 28 berkas, 323 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/jquery.easy-pie-chart/` | 33 berkas, 81 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/jquery.hotkeys/` | 4 berkas, 11 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/jquery.inputmask/` | 28 berkas, 974 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/jquery.tagsinput/` | 9 berkas, 16 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/jqvmap/` | 133 berkas, 1846 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/malihu-custom-scrollbar-plugin/` | 7 berkas, 236 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/mjolnic-bootstrap-colorpicker/` | 41 berkas, 135 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/mocha/` | 8 berkas, 160 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/moment/` | 317 berkas, 5688 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/morris.js/` | 72 berkas, 300 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/normalize-css/` | 7 berkas, 10 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/parsleyjs/` | 311 berkas, 3093 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/pnotify/` | 24 berkas, 72 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/raphael/` | 15 berkas, 1106 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/select2/` | 324 berkas, 1103 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/skycons/` | 5 berkas, 26 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/starrr/` | 10 berkas, 11 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/switchery/` | 13 berkas, 91 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/transitionize/` | 8 berkas, 14 KB | LOG (clean1.log) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/Chart.js/` | 125 berkas, 1832 KB | LOG (s7.txt) + CHK | ya | ya | 0 |
| `public/gentelella-master/vendors/requirejs/` | 4 berkas, 87 KB | LOG (s7.txt) + CHK | ya | ya | 1 |

Catatan: `Chart.js` dan `requirejs` sempat tertahan oleh pemeriksaan awal karena nama keduanya muncul di berkas lain; keduanya dihapus setelah pemeriksaan ulang di bagian B. Satu rujukan tersisa untuk `requirejs` adalah URL wiki di dalam komentar `jquery/src/exports/amd.js` (bukan path berkas).
Total gelombang pertama (42 direktori): 3491 berkas, 72.7 MB. Ukuran gentelella-master sebelum pembersihan: 97,2 MB / 4685 berkas (inventaris awal pada sesi sebelumnya). Ukuran sekarang ada di bagian H.

## B. Empat folder yang masih ada dan berkas pengembangan Bootstrap (dihapus pada sesi ini)

Bukti: korpus teks dipindai (480 berkas: app, db, tests, README, composer, aset kustom, JS/CSS/HTML semua pustaka yang dipertahankan). Setiap kemunculan dibaca, bukan hanya dihitung. Path dikunci agar harus berada di bawah `public/gentelella-master` sebelum dihapus, dan tidak boleh berupa reparse point.
| path | alasan dan bukti | ukuran | sumber | ada di sumber | absen sekarang |
|---|---|---|---|---|---|
| `public/gentelella-master/vendors/Chart.js/` | Rujukan hanya `new Chart(...)` di `custom.min.js` dalam fungsi yang dijaga `typeof Chart`; tidak dimuat view manapun. | 125 berkas, 1832 KB | LOG (s7.txt) + CHK | ya | ya |
| `public/gentelella-master/vendors/requirejs/` | Hanya URL dalam komentar; tidak dimuat. | 4 berkas, 87 KB | LOG (s7.txt) + CHK | ya | ya |
| `public/gentelella-master/production/js/datepicker/` | `daterangepicker` muncul di `custom.min.css`/`custom.min.js` hanya sebagai gaya dan fungsi `init_daterangepicker*` yang dijaga `void 0 !== $.fn.daterangepicker`. Tidak ada `<script>` yang memuatnya (rujukan berbasis path: 0). | - | LOG (s7.txt) + CHK | ya | ya |
| `public/gentelella-master/production/js/moment/` | `moment(` hanya dipakai di dalam `init_daterangepicker*` dan `init_IonRangeSlider` yang sama-sama dijaga `$.fn.*`. Tidak dimuat view manapun. | - | LOG (s7.txt) + CHK | ya | ya |
| `public/gentelella-master/vendors/bootstrap/.github` | konfigurasi lint/CI/build upstream Bootstrap; hanya dist/ yang dimuat. Rujukan ke nama berkas: 0. | 7 berkas, 15 KB | LOG (s7.txt) + CHK | ya | ya |
| `public/gentelella-master/vendors/bootstrap/.babelrc.js` | konfigurasi lint/CI/build upstream Bootstrap; hanya dist/ yang dimuat. Rujukan ke nama berkas: 0. | 1 berkas, 0 KB | LOG (s7.txt) + CHK | ya | ya |
| `public/gentelella-master/vendors/bootstrap/.browserslistrc` | konfigurasi lint/CI/build upstream Bootstrap; hanya dist/ yang dimuat. Rujukan ke nama berkas: 0. | 1 berkas, 0 KB | LOG (s7.txt) + CHK | ya | ya |
| `public/gentelella-master/vendors/bootstrap/.editorconfig` | konfigurasi lint/CI/build upstream Bootstrap; hanya dist/ yang dimuat. Rujukan ke nama berkas: 0. | 1 berkas, 0 KB | LOG (s7.txt) + CHK | ya | ya |
| `public/gentelella-master/vendors/bootstrap/.eslintignore` | konfigurasi lint/CI/build upstream Bootstrap; hanya dist/ yang dimuat. Rujukan ke nama berkas: 0. | 1 berkas, 0 KB | LOG (s7.txt) + CHK | ya | ya |
| `public/gentelella-master/vendors/bootstrap/.eslintrc.json` | konfigurasi lint/CI/build upstream Bootstrap; hanya dist/ yang dimuat. Rujukan ke nama berkas: 0. | 1 berkas, 7 KB | LOG (s7.txt) + CHK | ya | ya |
| `public/gentelella-master/vendors/bootstrap/.gitattributes` | konfigurasi lint/CI/build upstream Bootstrap; hanya dist/ yang dimuat. Rujukan ke nama berkas: 0. | 1 berkas, 0 KB | LOG (s7.txt) + CHK | ya | ya |
| `public/gentelella-master/vendors/bootstrap/.gitignore` | konfigurasi lint/CI/build upstream Bootstrap; hanya dist/ yang dimuat. Rujukan ke nama berkas: 0. | 1 berkas, 0 KB | LOG (s7.txt) + CHK | ya | ya |
| `public/gentelella-master/vendors/bootstrap/.stylelintignore` | konfigurasi lint/CI/build upstream Bootstrap; hanya dist/ yang dimuat. Rujukan ke nama berkas: 0. | 1 berkas, 0 KB | LOG (s7.txt) + CHK | ya | ya |
| `public/gentelella-master/vendors/bootstrap/.stylelintrc` | konfigurasi lint/CI/build upstream Bootstrap; hanya dist/ yang dimuat. Rujukan ke nama berkas: 0. | 1 berkas, 0 KB | LOG (s7.txt) + CHK | ya | ya |
| `public/gentelella-master/vendors/bootstrap/.travis.yml` | konfigurasi lint/CI/build upstream Bootstrap; hanya dist/ yang dimuat. Rujukan ke nama berkas: 0. | 1 berkas, 1 KB | LOG (s7.txt) + CHK | ya | ya |
| `public/gentelella-master/vendors/bootstrap/CNAME` | konfigurasi lint/CI/build upstream Bootstrap; hanya dist/ yang dimuat. Rujukan ke nama berkas: 0. | 1 berkas, 0 KB | LOG (s7.txt) + CHK | ya | ya |
| `public/gentelella-master/vendors/bootstrap/CODE_OF_CONDUCT.md` | konfigurasi lint/CI/build upstream Bootstrap; hanya dist/ yang dimuat. Rujukan ke nama berkas: 0. | 1 berkas, 3 KB | LOG (s7.txt) + CHK | ya | ya |
| `public/gentelella-master/vendors/bootstrap/Gemfile` | konfigurasi lint/CI/build upstream Bootstrap; hanya dist/ yang dimuat. Rujukan ke nama berkas: 0. | 1 berkas, 0 KB | LOG (s7.txt) + CHK | ya | ya |
| `public/gentelella-master/vendors/bootstrap/Gemfile.lock` | konfigurasi lint/CI/build upstream Bootstrap; hanya dist/ yang dimuat. Rujukan ke nama berkas: 0. | 1 berkas, 2 KB | LOG (s7.txt) + CHK | ya | ya |
| `public/gentelella-master/vendors/bootstrap/package-lock.json` | konfigurasi lint/CI/build upstream Bootstrap; hanya dist/ yang dimuat. Rujukan ke nama berkas: 0. | 1 berkas, 387 KB | LOG (s7.txt) + CHK | ya | ya |
| `public/gentelella-master/vendors/bootstrap/package.js` | konfigurasi lint/CI/build upstream Bootstrap; hanya dist/ yang dimuat. Rujukan ke nama berkas: 0. | 1 berkas, 0 KB | LOG (s7.txt) + CHK | ya | ya |
| `public/gentelella-master/vendors/bootstrap/_config.yml` | konfigurasi lint/CI/build upstream Bootstrap; hanya dist/ yang dimuat. Rujukan ke nama berkas: 0. | 1 berkas, 2 KB | LOG (s7.txt) + CHK | ya | ya |

Bootstrap: `dist/css/*.css` dan `dist/js/*.js` menunjuk ke `.map` bersebelahan lewat `sourceMappingURL` (10 berkas, semua ada), sehingga `dist/` dipertahankan utuh.

## C. Berkas dan subdirektori template lain (gelombang pertama)

| path | alasan | ukuran | sumber | ada di sumber | absen sekarang |
|---|---|---|---|---|---|
| `public/gentelella-master/vendors/bootstrap/site` | dokumentasi/situs Bootstrap, contoh HTML. Hanya `dist/` yang dirujuk. Tidak ada path `bootstrap/site/` di korpus. | 252 berkas, 2181 KB | LOG (clean1.log) + CHK | ya | ya |
| `public/gentelella-master/vendors/bootstrap/scss` | sumber SCSS, tidak ada pipeline build di repo. | 88 berkas, 203 KB | LOG (clean1.log) + CHK | ya | ya |
| `public/gentelella-master/vendors/bootstrap/js` | sumber JS Bootstrap (bukan `dist/js`). | 71 berkas, 921 KB | LOG (clean1.log) + CHK | ya | ya |
| `public/gentelella-master/vendors/bootstrap/build` | skrip build upstream. | 10 berkas, 15 KB | LOG (clean1.log) + CHK | ya | ya |
| `public/gentelella-master/vendors/bootstrap/nuget` | metadata NuGet. | 3 berkas, 4 KB | LOG (clean1.log) + CHK | ya | ya |
| `public/gentelella-master/docs` | dokumentasi template. Tidak dimuat dan tidak dirujuk. | 47 berkas, 1337 KB | LOG (clean1.log) + CHK | ya | ya |
| `public/gentelella-master/src` | sumber SCSS/JS template, hanya untuk gulp (tidak ada pipeline di repo). | 5 berkas, 266 KB | LOG (clean1.log) + CHK | ya | ya |
| `public/gentelella-master/production/tc-lib-pdf-main` | pustaka PDF di web root. Aplikasi memakai `tecnickcom/tcpdf` dari Composer (`new TCPDF` di 8 tempat); tidak ada rujukan `tc-lib` atau `Com\Tecnick`. | 34 berkas, 205 KB | LOG (clean1.log) + CHK | ya | ya |
| `public/gentelella-master/build/images` | gambar bawaan DataTables template. `custom.min.css` hanya punya `url()` ke domain eksternal; tidak ada rujukan ke `build/images`. | 7 berkas, 38 KB | LOG (clean1.log) + CHK | ya | ya |
| `public/gentelella-master/build/css/custom.css` | versi tak diminifikasi; layout hanya memuat `custom.min.css`. | 1 berkas | LOG (clean1.log) + CHK | ya | ya |
| `public/gentelella-master/build/js/custom.js` | versi tak diminifikasi; layout hanya memuat `custom.min.js`. | 1 berkas | LOG (clean1.log) + CHK | ya | ya |
| `public/gentelella-master/production/css/maps/jquery-jvectormap-2.0.3.css` | CSS peta vektor; tidak dimuat dan `mystyle.css` tidak meng-`@import`-nya. | 1 berkas | LOG (clean1.log) + CHK | ya | ya |
| `public/gentelella-master/.bowerrc` | konfigurasi alat dev template. | 1 berkas | LOG (clean1.log) + CHK | ya | ya |
| `public/gentelella-master/bower.json` | metadata alat dev template. | 1 berkas | LOG (clean1.log) + CHK | ya | ya |
| `public/gentelella-master/package.json` | metadata alat dev template. | 1 berkas | LOG (clean1.log) + CHK | ya | ya |
| `public/gentelella-master/gulpfile.js` | skrip build template; tidak ada gulp di repo. | 1 berkas | LOG (clean1.log) + CHK | ya | ya |
| `public/gentelella-master/changelog.md` | catatan rilis template. | 1 berkas | LOG (clean1.log) + CHK | ya | ya |
| `public/gentelella-master/README_CN.md` | README Mandarin template. | 1 berkas | LOG (clean1.log) + CHK | ya | ya |
| `public/gentelella-master/.gitignore` | gitignore template, tidak berlaku di repo ini. | 1 berkas | LOG (clean1.log) + CHK | ya | ya |

## D. Berkas aplikasi mati

| path | alasan dan bukti | sumber | ada di sumber | absen sekarang |
|---|---|---|---|---|
| `app/Controllers/Tolak.php` | Kelas di dalamnya bernama `TolakController`, tidak cocok dengan nama berkas `Tolak.php`, sehingga tidak bisa di-autoload. Tidak ada route. View yang dipanggil (`/tolak`) tidak ada. Halaman penolakan yang aktif adalah `Home::tolak` di route `/404`. | LOG (clean1.log) + CHK | ya | ya |
| `app/Controllers/PeminjamanBerhasilController.php` | Tidak ada route (auto-route nonaktif), form action, atau redirect ke controller ini. Halaman yang sama dilayani `Home::peminjamanBerhasil` di route `/peminjaman_berhasil`. | LOG (clean1.log) + CHK | ya | ya |
| `app/Views/peminjaman_barang/tambah1.php` | Tidak ada `view()`/`extend()` yang memanggilnya. Berkas ini sendiri meng-`extend` `layout/main1` yang tidak ada. | LOG (clean1.log) + CHK | ya | ya |
| `app/Views/welcome_message.php` | Hanya dipakai `Home::index2` yang tidak punya route; halaman bawaan CodeIgniter. `Home::index2` ikut dihapus (bagian E). | LOG (clean1.log) + CHK | ya | ya |

## D2. Penghapusan tahap persiapan open source (laporan sebelumnya)

Sumber `LAPORAN`: tercatat di laporan sesi persiapan awal (skrip apply1 dan apply3 di luar repo), alasannya privasi atau hak aset, bukan karena tidak dipakai. Keadaan akhir diperiksa ulang (`CHK`).
| path | alasan | ada di sumber | absen sekarang |
|---|---|---|---|
| `db/man_lab.sql` | dump database asli (data pengguna, hash password); diganti `db/schema.sql` dan `db/demo.sql`. | ya | ya |
| `db/man_lab.pdf` | dokumentasi basis data asli. | ya | ya |
| `public/gentelella-master/production/images/kalab.jpg` | foto pihak ketiga. | ya | ya |
| `public/gentelella-master/production/images/hafiz.jpg` | foto pribadi pengembang. | ya | ya |
| `public/gentelella-master/production/images/nasya.jpg` | foto pribadi pengembang. | ya | ya |
| `public/gentelella-master/production/images/indah.jpg` | foto pribadi pengembang. | ya | ya |
| `public/gentelella-master/production/images/barang.PNG` | gambar panduan yang mungkin memuat data nyata; diganti `demo-assets/logo.svg`. | ya | ya |
| `public/gentelella-master/production/images/HIMASI.png` | logo organisasi; hak publikasi belum jelas; diganti `demo-assets/logo.svg`. | ya | ya |
| `public/gentelella-master/production/images/logouin.jpg` | logo institusi; diganti `demo-assets/logo.svg`. | ya | ya |
| `public/gentelella-master/production/images/kop.jpg` | kop surat institusi; diganti `demo-assets/kop.svg`. | ya | ya |
| `public/gentelella-master/production/images/KopL.jpeg` | kop surat institusi; diganti `demo-assets/kop.svg`. | ya | ya |
| `public/gentelella-master/production/images/logo.jpeg` | logo institusi; diganti `demo-assets/logo.svg`. | ya | ya |
| `public/gentelella-master/vendors/bootstrap-wysiwyg/examples/php` | skrip upload contoh yang dapat dieksekusi dari web root (direktori induk kini sudah terhapus). | ya | ya |
| `public/gentelella-master/production/tc-lib-pdf-main/examples` | skrip PHP contoh di web root (induknya kini terhapus). | ya | ya |

Tidak disalin sejak awal (tidak pernah ada di salinan): `.git`, `.env`, `vendor/`, log, session, debugbar, unggahan asli, `public/qr_cache/*`.

## E. Perubahan kode (bukan penghapusan berkas)

| path | perubahan | alasan dan bukti | status |
|---|---|---|---|
| `app/Config/Routes.php` | hapus route `GET pemusnahan_barang/cetak`, `GET pemusnahan_barang/search(:any)` | target `PemusnahanBarangController::cetak` dan `::search` tidak ada (diperiksa dengan membaca daftar method controller). Tidak ada tautan, form, atau redirect ke path tersebut. | CHK, route tersisa semuanya cocok dengan method |
| `app/Config/Routes.php` | hapus route `GET peminjaman_barang/detail/(:any)` | kelas `PeminjamanBarangDetailController` tidak ada di `app/Controllers`. Tidak ada rujukan lain. | CHK |
| `app/Config/Routes.php` | hapus route `GET dokumentasi/preview/(:num)`, `GET public/uploads/(:any)` | `DokumentasiController::preview` dan `::showFile` tidak ada. Tautan unggahan di view memakai `base_url('/uploads/...')`, bukan `public/uploads/`. | CHK |
| `app/Config/Routes.php` | hapus `GET peminjaman_barang` -> `ReferensiController::index` dan `GET peminjaman_ruangan` -> `ReferensiController::index` | **Deklarasi kedua, tidak pernah dipakai.** Karena deklarasi pertama yang berlaku (lihat fakta framework), handler efektif adalah `PeminjamanBarangController::index` dan `PeminjamanRuanganController::index`. Keduanya sesuai tautan di menu (`layout/main.php`), `dashboard.php`, dan semua `redirect()->to(base_url().'/peminjaman_barang' atau '/peminjaman_ruangan')` di controller. View `peminjaman_barang/index` dan `peminjaman_ruangan/index` butuh `$id_referensi` yang hanya disediakan controller pertama. Perilaku aktif tidak berubah. | CHK |
| `app/Config/Routes.php` | hapus duplikat identik `POST peminjaman_barang/tambah` (deklarasi kedua) | target sama dengan deklarasi pertama, tidak berefek. | CHK |
| `app/Config/Routes.php` | hapus `GET` dan `POST peminjaman_barang/tambah_biaya` | Diperiksa sebagai satu alur: view tujuan `peminjaman_barang/tambah_biaya` **tidak ada**, tidak ada tautan atau form yang menuju `peminjaman_barang/tambah_biaya` (tombol "Edit" di `peminjaman_barang/index.php` menuju `peminjaman_ruangan/tambah_biaya`), `AccessFilter` hanya membatasi varian ruangan. Satu-satunya rujukan adalah route dan method itu sendiri. Alur ini sudah rusak sejak awal dan tidak punya pemanggil aktif. | CHK |
| `app/Controllers/ReferensiController.php` | hapus method `index()`, `tambah_biaya2()`, `insertData2()` | setelah route di atas dihapus, ketiganya tanpa pemanggil. `tambah_biaya()` dan `insertData()` (alur biaya ruangan, aktif) dipertahankan. | CHK |
| `app/Controllers/Home.php` | hapus `index2()` | satu-satunya pemanggil `view('welcome_message')`; tidak ada route (auto-route nonaktif). | CHK |
| `app/Views/barang/edit.php` | hapus 6 blok komentar HTML berisi field lama (pendanaan, ruang, tahun, kategori, subkategori, tanggal masuk) | semua blok seimbang (`<div>` = `</div>`), sudah digantikan input `hidden` aktif tepat di bawahnya. Blok mengandung PHP yang tetap dieksekusi di dalam komentar, tanpa efek samping. 17314 -> 10403 byte. | CHK |
| `app/Views/barang/tambah.php` | hapus pasangan komentar pembuka dan penutup di sekitar `<input type="date" hidden name="tgl_masuk_barang">` | kedua blok hanya membungkus markup yang disembunyikan; input aktif tidak disentuh. Dibaca ulang setelah perubahan. 23008 -> 22280 byte. | CHK |
| `app/Views/maintenance/index.php` | hapus 1 blok komentar `<td>` kolom status lama | blok seimbang, tidak ada isi aktif. 11303 -> 10745 byte. | CHK |
| `app/Views/about.php`, `app/Views/pengembang.php` | hapus 3 tag `../assets/...` (bootstrap css, `color-modes.js`, `bootstrap.bundle.min.js`) | `public/assets` dan `assets/` di root tidak ada, jadi ketiga tag selalu 404. Halaman tetap memuat Bootstrap dari `gentelella-master/vendors/bootstrap/dist`. | CHK |
| `app/Views/peminjaman_ruangan/pinjam.php` | `alur.PNG` -> `alur.png` (2 tempat) | berkas nyata bernama `alur.png`. Di Linux rujukan lama akan 404. | CHK |

## F. Dipertahankan (tidak dihapus)

| path | alasan |
|---|---|
| `composer.json`, `composer.lock` | sesuai instruksi. `google/apiclient`, `mailjet/mailjet-apiv3-php`, `nyholm/psr7`, `php-http/*` tidak dirujuk kode aplikasi (`Mailer` memakai cURL langsung), tetapi penghapusan butuh `composer update`, yang tidak boleh dijalankan. Lihat bagian G. |
| `public/uploads/**` (semua `demo-*` dan `.gitkeep`) | semua nama dirujuk `db/demo.sql`, ada di direktori yang dibaca view atau controller (diperiksa dengan kapitalisasi tepat). `demo-bukti.svg` ada di tiga direktori karena `peminjaman_barang/index.php` membaca dari `uploads/`, sedangkan redirect/unduh peminjaman memakai `uploads/peminjaman/`, dan maintenance memakai `uploads/maintenance/`. `demo-pemusnahan.pdf` ada di `pemusnahan_barang/` (tujuan unggah) dan `dokumentasi/` (view `pemusnahan_barang/edit.php` membaca dari sini). |
| `public/qr_cache/.gitkeep` | `cetak_qr.php` menulis ke `./qr_cache` dan membuatnya bila tidak ada (`mkdir`). Direktori dipertahankan agar jalur tulis tersedia. |
| `writable/{cache,logs,session,debugbar,uploads}` (penanda direktori) | dibutuhkan runtime CodeIgniter. |
| `public/gentelella-master/production/images/{dummy.png,user.png,alur.png}` | placeholder fallback di 8 controller (`dummy.png`), `UserController`, `about.php`, `pengembang.php` (`user.png`), dan `peminjaman_ruangan/pinjam.php` (`alur.png`). |
| `public/gentelella-master/production/css/maps/mystyle.css`, `production/js/myscript.js` | dimuat `layout/main.php`, `about.php`, `pengembang.php`, `login.php`. Rujukan `mystyle.css` memakai backslash (`production\css\maps\mystyle.css`) sehingga pencarian dengan `/` tidak menemukannya. |
| `public/gentelella-master/build/css/custom.min.css`, `build/js/custom.min.js` | dimuat tiga layout utama. |
| `public/gentelella-master/vendors/` : 22 pustaka (`animate.css`, `bootstrap`, `datatables.net*` x12, `fastclick`, `font-awesome`, `iCheck`, `jquery`, `jQuery-Smart-Wizard`, `jszip`, `nprogress`, `pdfmake`, `validator`) | tiap pustaka dimuat view/layout. Semua `url()` dan `@import` di CSS yang dipertahankan (224 rujukan) diperiksa ada, dengan kapitalisasi tepat. `bootstrap/dist/*.map` dipertahankan karena dirujuk komentar `sourceMappingURL`. `bootstrap/{LICENSE,README.md,package.json,composer.json,.bower.json}` dipertahankan sebagai lisensi dan metadata versi. |
| `public/gentelella-master/{LICENSE.txt,README.md}` | lisensi dan atribusi template. |
| `system/`, `tests/`, `preload.php`, `spark`, `phpunit.xml.dist` | inti framework dan infrastruktur test. Contoh test bawaan (`tests/_support/**`, `ExampleDatabaseTest`) tidak saya hapus karena `phpunit.xml.dist` dan test `HealthTest` bergantung pada struktur ini dan tidak bisa diverifikasi tanpa menjalankan test. |
| `app/Views/errors/**`, `app/Config/**`, `.gitkeep` di `app/*` | dipakai framework. |
| Pustaka yang dipertahankan masih membawa berkas non-runtime (mis. `jquery/src`) | tidak dipangkas. Pemangkasan lebih jauh tidak punya bukti yang cukup dan keuntungannya kecil. |

## G. Perlu tinjauan pemilik

| item | alasan |
|---|---|
| `public/gentelella-master/production/images/alur.png` | infografik alur peminjaman. Sumber dan hak publikasi tidak terbukti (gaya templat desain pihak ketiga). **Konfirmasi hak sebelum publikasi.** Tidak dihapus karena dipakai `peminjaman_ruangan/pinjam.php`. |
| Dependensi Composer yang tidak dirujuk kode: `google/apiclient`, `mailjet/mailjet-apiv3-php`, `nyholm/psr7`, `php-http/curl-client`, `php-http/message` | pencarian `Google\`, `Mailjet`, `Nyholm`, `Http\Client` di `app/` tidak menemukan apa pun. Keputusan pemilik dan butuh `composer update` oleh orang yang boleh menjalankannya. |
| Teks "Program Studi Sistem Informasi Fakultas Sains dan Teknologi UIN SUSKA RIAU" di halaman cetak | nama institusi, bukan rahasia. Pemilik memutuskan apakah dibuat generik. |
| Nama dan kontak orang di `about.php`/`pengembang.php` | sudah diganti placeholder (`*@example.com`, "Pembimbing DEMO"). Pemilik memutuskan apakah nama asli boleh tampil dan dengan izin siapa. |
| Hak atas template Gentelella dan pustaka yang dipertahankan | lisensi masing-masing ikut terbawa (`LICENSE.txt`, `bootstrap/LICENSE`, header pustaka). Konfirmasi kepatuhan atribusi MIT/lainnya. |
| Lisensi proyek (`LICENSE`, MIT) | konfirmasi dengan kontributor. |

## H. Verifikasi statis akhir

Dijalankan dengan skrip baca-saja di luar repo; semua keluaran sudah ditinjau.

| pemeriksaan | hasil |
|---|---|
| Konfigurasi auto-route efektif | nonaktif (lihat bagian fakta framework) |
| Route tersisa | 111 deklarasi get/post aktif di Routes.php setelah semua penghapusan route di bagian E (10 deklarasi dihapus: 2 pemusnahan_barang, 1 detail, 2 dokumentasi/public-uploads, 2 ReferensiController::index, 1 duplikat POST, 2 tambah_biaya barang) |
| Target controller dan method tiap route | semua ada, tidak ada nama kelas yang berbeda dari nama berkas |
| Kunci route ganda (verb + path) | tidak ada setelah pembersihan |
| Controller tanpa route | tidak ada (`BaseController` dikecualikan) |
| Target `view()`/`extend()` | 60 rujukan, semua ada dengan kapitalisasi tepat; tidak ada view yang tidak dirujuk; tidak ada pemanggilan `view()` dinamis |
| Aset lokal dari view (167 rujukan berekstensi aset) | semua ada kecuali yang tercatat di bagian I (sudah rusak sebelum pembersihan) |
| `url()`/`@import` pada CSS yang dipertahankan | 224 diperiksa, 0 masalah (path dan kapitalisasi) |
| Rujukan SQL demo | 8 nama berkas `demo-*` ada di semua direktori yang dibaca kode, kapitalisasi tepat; tidak ada nilai berkas non-demo |
| Direktori unggahan, `qr_cache`, `writable/*` | ada dengan berkas penjaga |
| Rujukan ke item yang dihapus (nama kelas, view, route, vendor, `../assets`) | tidak ada, selain kata "tolak" yang sah: `Home::tolak` (route `/404`) dan komentar `AccessFilter` |

## I. Masalah yang sudah ada sebelum pembersihan (tidak disebabkan penghapusan)

Dibedakan dengan membandingkan hasil pemeriksaan awal (sebelum penghapusan) dengan hasil akhir.

| temuan | lokasi | keterangan |
|---|---|---|
| Tautan `styles.css` tidak ada | `peminjaman_berhasil.php`, `peminjaman_barang/tambah.php` | berkas tidak ada di `public/`. Tidak diubah. |
| `cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css` tanpa protokol | `about.php`, `pengembang.php`, `layout/main.php`, `main_form.php`, `main_peminjaman.php` | dibaca browser sebagai path relatif, bukan CDN. Tidak diubah. |
| `public/uploads/d` + nama berkas | `MaintenanceController` baris fallback `copy($dummyImagePath, ROOTPATH . 'public/uploads/d' . $fileName)` | menyalin placeholder ke `uploads/ddummy.png`, bukan `uploads/maintenance/`. Kemungkinan salah ketik. Perbaikan terpisah. |
| Tombol "Edit" biaya di `peminjaman_barang/index.php` menuju `peminjaman_ruangan/tambah_biaya` | `peminjaman_barang/index.php` | biaya satu tabel `referensi` dipakai bersama. Ini mengonfirmasi alur `peminjaman_barang/tambah_biaya` memang tidak pernah dipakai. |
| `ReferensiController::insertData` selalu redirect ke `/peminjaman_ruangan` | `ReferensiController` | wajar karena hanya dipanggil dari form ruangan. |
| Pemeriksaan hak aset `alur.png` | lihat G | |

Perbaikan terpisah (di luar tugas pembersihan): fallback `MaintenanceController`, tautan `styles.css`, URL CDN DataTables.

## Syarat sebelum publikasi

Hasil di atas hanya diverifikasi secara statis. Publikasi masih menunggu:

1. Rotasi credential yang pernah ada di riwayat repo lama (lihat `AUDIT-PRIVATE.md` di luar salinan).
2. Penanganan akun dan session yang terekspos (reset password, invalidasi session).
3. Konfirmasi hak publikasi aset (`alur.png`, template, logo pengganti) dan lisensi proyek.
4. Verifikasi runtime pada lingkungan yang diizinkan: halaman utama dimuat tanpa 404 aset, alur login, unggah, cetak PDF/QR, dan impor `db/schema.sql` + `db/demo.sql` + seeder.
5. Pemindaian rahasia pada riwayat Git baru.
