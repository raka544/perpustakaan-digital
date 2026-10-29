<?php
require 'config.php';
if (user() && array_key_exists('akses_kelas', user())) { header('Location: ' . home_for(user()['role'])); exit; }

$err = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_check();
    $st = $pdo->prepare('SELECT * FROM users WHERE username=?');
    $st->execute([trim($_POST['username'] ?? '')]);
    $u = $st->fetch();
    if ($u && password_verify($_POST['password'] ?? '', $u['password'])) {
        if (!array_key_exists('akses_kelas', $u)) {
            die('Database belum diperbarui. Import database.sql terbaru atau jalankan migrasi.sql di phpMyAdmin.');
        }
        session_regenerate_id(true);
        $_SESSION['user'] = [
            'id'          => (int)$u['id'],
            'nama'        => $u['nama'],
            'role'        => $u['role'],
            'kelas'       => $u['kelas'] ?: null,
            'akses_kelas' => $u['akses_kelas'] ?: null,
            'bisa_ubah'   => (int)$u['bisa_ubah'],
            'akses_admin' => (int)$u['akses_admin'],
        ];
        header('Location: ' . home_for($u['role']));
        exit;
    }
    $err = 'Username atau password salah.';
}
page_header('Masuk');
?>
<div class="center card">
  <h1>Masuk</h1>
  <p class="sub">Admin, petugas, dan anggota masuk lewat halaman yang sama.</p>
  <?php if ($err): ?><div class="alert err"><?= e($err) ?></div><?php endif; ?>
  <form method="post">
    <?= csrf_field() ?>
    <label>Username</label><input name="username" required autofocus>
    <label>Password</label><input name="password" type="password" required>
    <p><button class="btn" type="submit">Masuk</button></p>
  </form>
  <p>Belum punya akun anggota? <a href="register.php">Daftar di sini</a></p>
</div>
<?php page_footer();
