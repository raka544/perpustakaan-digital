<?php
// Skrip sekali pakai: membuat/mereset akun contoh. HAPUS file ini setelah dipakai.
require 'config.php';

if (!in_array($_SERVER['REMOTE_ADDR'] ?? '', ['127.0.0.1', '::1'], true)) {
    http_response_code(403);
    die('Skrip ini hanya boleh dibuka dari komputer sendiri (localhost).');
}

$akun = [
    ['Administrator',    'admin',    'admin123',    'admin',    null],
    ['Petugas 1',        'petugas1', 'petugas123',  'petugas',  null],
    ['Petugas 2',        'petugas2', 'petugas123',  'petugas',  null],
    ['Petugas 3',        'petugas3', 'petugas123',  'petugas',  null],
    ['Anggota Contoh 1', 'anggota1', 'anggota123',  'anggota',  '081234567801'],
    ['Anggota Contoh 2', 'anggota2', 'anggota123',  'anggota',  '081234567802'],
];

try {
    foreach ($akun as [$nama, $user, $pass, $role, $wa]) {
        $hash = password_hash($pass, PASSWORD_DEFAULT);
        $st = $pdo->prepare('SELECT id FROM users WHERE username=?');
        $st->execute([$user]);
        if ($id = $st->fetchColumn()) {
            $pdo->prepare('UPDATE users SET password=?, role=?, nama=? WHERE id=?')->execute([$hash, $role, $nama, $id]);
        } else {
            $pdo->prepare('INSERT INTO users (nama, username, password, role, no_wa) VALUES (?,?,?,?,?)')->execute([$nama, $user, $hash, $role, $wa]);
        }
    }
    $rows = $pdo->query('SELECT id, username, role FROM users ORDER BY id')->fetchAll();
} catch (Throwable $t) {
    die('Gagal: tabel users belum ada atau rusak. Import database.sql dulu di phpMyAdmin, lalu buka halaman ini lagi.<br>' . e($t->getMessage()));
}
?><!DOCTYPE html>
<html lang="id"><head><meta charset="utf-8"><title>Reset akun</title><link rel="stylesheet" href="style.css"></head>
<body><main class="wrap">
<div class="alert ok">Akun berhasil dibuat/direset. Sekarang coba masuk, lalu <b>hapus file reset_akun.php</b>.</div>
<table>
<tr><th>Username</th><th>Peran</th><th>Password</th></tr>
<?php foreach ($akun as [$n, $u, $p, $r]): ?>
<tr><td><?= e($u) ?></td><td><?= e($r) ?></td><td><?= e($p) ?></td></tr>
<?php endforeach; ?>
</table>
<h2>Semua akun yang ada di database</h2>
<table>
<tr><th>ID</th><th>Username</th><th>Peran</th></tr>
<?php foreach ($rows as $r): ?>
<tr><td><?= (int)$r['id'] ?></td><td><?= e($r['username']) ?></td><td><?= e($r['role']) ?></td></tr>
<?php endforeach; ?>
</table>
<p><a class="btn" href="login.php">Ke halaman login</a></p>
</main></body></html>