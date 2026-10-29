<?php
require 'config.php';
if (user() && array_key_exists('akses_kelas', user())) { header('Location: ' . home_for(user()['role'])); exit; }

$err = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_check();
    $nama = trim($_POST['nama'] ?? '');
    $username = trim($_POST['username'] ?? '');
    $pass = $_POST['password'] ?? '';
    $wa = trim($_POST['no_wa'] ?? '');
    $kelas = cari_kelas($_POST['kelas'] ?? '');
    if ($nama === '' || $username === '' || strlen($pass) < 6) {
        $err = 'Nama, username wajib diisi dan password minimal 6 karakter.';
    } elseif (!$kelas) {
        $err = 'Pilih kelas Anda.';
    } elseif (!preg_match('/^[A-Za-z0-9_.]{3,30}$/', $username)) {
        $err = 'Username hanya huruf, angka, titik, underscore (3-30 karakter).';
    } elseif (!preg_match('/^[0-9+\s-]{9,20}$/', $wa)) {
        $err = 'Nomor WhatsApp tidak valid (dipakai untuk pengingat jatuh tempo).';
    } else {
        $cek = $pdo->prepare('SELECT 1 FROM users WHERE username=?');
        $cek->execute([$username]);
        if ($cek->fetch()) {
            $err = 'Username sudah dipakai.';
        } else {
            $pdo->prepare("INSERT INTO users (nama, username, password, role, kelas, no_wa) VALUES (?,?,?,'anggota',?,?)")
                ->execute([$nama, $username, password_hash($pass, PASSWORD_DEFAULT), $kelas, $wa]);
            flash('Pendaftaran berhasil. Silakan masuk.');
            header('Location: login.php');
            exit;
        }
    }
}
page_header('Daftar Anggota');
?>
<div class="center card">
  <h1>Daftar Anggota</h1>
  <?php if ($err): ?><div class="alert err"><?= e($err) ?></div><?php endif; ?>
  <form method="post">
    <?= csrf_field() ?>
    <label>Nama lengkap</label><input name="nama" required value="<?= e($_POST['nama'] ?? '') ?>">
    <label>Kelas</label>
    <select name="kelas" required>
      <option value="">- pilih kelas -</option>
      <?php foreach (KELAS as $k): ?><option <?= ($_POST['kelas'] ?? '') === $k ? 'selected' : '' ?>><?= e($k) ?></option><?php endforeach; ?>
    </select>
    <label>Username</label><input name="username" required value="<?= e($_POST['username'] ?? '') ?>">
    <label>Password (min. 6 karakter)</label><input name="password" type="password" required>
    <label>No. WhatsApp</label><input name="no_wa" placeholder="08xxxxxxxxxx" required value="<?= e($_POST['no_wa'] ?? '') ?>">
    <p><button class="btn" type="submit">Daftar</button> <a href="login.php">Kembali</a></p>
  </form>
</div>
<?php page_footer();
