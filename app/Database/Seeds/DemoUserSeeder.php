<?php

namespace App\Database\Seeds;

use App\Libraries\DemoMode;
use CodeIgniter\Database\Seeder;
use RuntimeException;

/**
 * Mengatur kata sandi akun demo. Hanya berjalan jika CI_ENVIRONMENT=development
 * dan sitaris.demoMode=true. Kata sandi dibaca dari sitaris.demoPassword (.env).
 *
 * Penggunaan: php spark db:seed DemoUserSeeder
 */
class DemoUserSeeder extends Seeder
{
    private const ACCOUNTS = [
        ['demokalab',    'Kepala Lab DEMO',  'DEMO-0001', 'kalab.demo@example.com',    'Kalab'],
        ['demoadmin',    'Admin DEMO',       'DEMO-0002', 'admin.demo@example.com',    'Admin'],
        ['demokaprodi',  'Kaprodi DEMO',     'DEMO-0003', 'kaprodi.demo@example.com',  'Kaprodi'],
        ['demosekprodi', 'Sekprodi DEMO',    'DEMO-0004', 'sekprodi.demo@example.com', 'Sekprodi'],
        ['demopeminjam', 'Peminjam DEMO',    'DEMO-0005', 'peminjam.demo@example.com', 'Peminjam'],
        ['demoaslab',    'Asisten Lab DEMO', 'DEMO-0006', 'aslab.demo@example.com',    'Aslab'],
    ];

    public function run(): void
    {
        if (! DemoMode::enabled()) {
            throw new RuntimeException('Seeder ditolak: butuh CI_ENVIRONMENT=development dan sitaris.demoMode=true.');
        }

        $password = (string) env('sitaris.demoPassword', '');
        if (trim($password) === '') {
            throw new RuntimeException('Seeder ditolak: sitaris.demoPassword kosong. Isi di .env.');
        }

        $table = $this->db->table('user');

        // Periksa semua konflik dulu, sebelum menulis apa pun.
        foreach (self::ACCOUNTS as [$username]) {
            $existing = $table->where('username', $username)->get()->getRowArray();
            if ($existing !== null && strpos((string) $existing['no_identitas'], 'DEMO-') !== 0) {
                throw new RuntimeException("Seeder ditolak: username '{$username}' dipakai akun non-demo.");
            }
        }

        $hash = password_hash($password, PASSWORD_DEFAULT);

        foreach (self::ACCOUNTS as [$username, $nama, $noIdentitas, $email, $role]) {
            $existing = $this->db->table('user')->where('username', $username)->get()->getRowArray();

            if ($existing !== null) {
                $this->db->table('user')->where('id_user', $existing['id_user'])->update(['password_hash' => $hash]);
                continue;
            }

            $this->db->table('user')->insert([
                'nama'          => $nama,
                'foto'          => 'demo-user.svg',
                'no_identitas'  => $noIdentitas,
                'username'      => $username,
                'password_hash' => $hash,
                'email'         => $email,
                'role_user'     => $role,
            ]);
        }
    }
}
