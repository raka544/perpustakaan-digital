<?php
require 'config.php';
require_admin_area();
header('Cache-Control: no-store'); // halaman ini bisa menampilkan password baru

$hasil = []; // akun yang baru dibuat/direset: [nama, kelas, username, password]
$galat = [];

// Menambah satu anggota. Password/username kosong dibuat otomatis.
$tambah = function ($nama, $kelas, $wa, $username, $pass, $label) use ($pdo, &$hasil, &$galat) {
    $nama = trim($nama);
    if ($nama === '') { $galat[] = "$label: nama kosong."; return; }
    $k = cari_kelas($kelas);
    if (!$k) { $galat[] = "$label ($nama): kelas \"$kelas\" tidak dikenal. Gunakan: " . implode(' atau ', KELAS) . '.'; return; }
    $username = trim($username);
    if ($username === '') {
        $username = buat_username($pdo, $nama);
    } elseif (!preg_match('/^[A-Za-z0-9_.]{3,30}$/', $username)) {
        $galat[] = "$label ($nama): username/NIS tidak valid (huruf, angka, titik, underscore; 3-30 karakter)."; return;
    } else {
        $c = $pdo->prepare('SELECT 1 FROM users WHERE username=?');
        $c->execute([$username]);
        if ($c->fetch()) { $galat[] = "$label ($nama): username \"$username\" sudah dipakai."; return; }
    }
    $wa = trim($wa);
    if ($wa !== '' && !preg_match('/^[0-9+\s-]{9,20}$/', $wa)) { $galat[] = "$label ($nama): nomor WA tidak valid."; return; }
    $pass = trim($pass);
    if ($pass === '') $pass = gen_password();
    elseif (strlen($pass) < 6) { $galat[] = "$label ($nama): password minimal 6 karakter."; return; }
    $pdo->prepare("INSERT INTO users (nama, username, password, role, kelas, no_wa) VALUES (?,?,?,'anggota',?,?)")
        ->execute([$nama, $username, password_hash($pass, PASSWORD_DEFAULT), $k, $wa !== '' ? $wa : null]);
    $hasil[] = [$nama, $k, $username, $pass];
};

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_check();
    $aksi = $_POST['aksi'] ?? '';

    if ($aksi === 'tambah') {
        try {
            $pdo->beginTransaction();
            $tambah($_POST['nama'] ?? '', $_POST['kelas'] ?? '', $_POST['no_wa'] ?? '', $_POST['username'] ?? '', $_POST['password'] ?? '', 'Form');
            $pdo->commit();
        } catch (Throwable $t) {
            if ($pdo->inTransaction()) $pdo->rollBack();
            $hasil = []; $galat[] = 'Gagal menyimpan ke database.';
        }

    } elseif ($aksi === 'import') {
        $file = $_FILES['csv'] ?? null;
        if (!$file || $file['error'] !== UPLOAD_ERR_OK || !is_uploaded_file($file['tmp_name'])) {
            $galat[] = 'Pilih file CSV terlebih dahulu.';
        } elseif ($file['size'] > 1024 * 1024) {
            $galat[] = 'File terlalu besar (maksimal 1 MB).';
        } elseif (strtolower(pathinfo($file['name'], PATHINFO_EXTENSION)) !== 'csv') {
            $galat[] = 'File harus berformat .csv (di Excel: Save As, pilih CSV).';
        } else {
            $raw = file_get_contents($file['tmp_name']);
            $raw = preg_replace('/^\xEF\xBB\xBF/', '', $raw); // buang BOM
            if (function_exists('mb_check_encoding') && !mb_check_encoding($raw, 'UTF-8')) {
                $raw = mb_convert_encoding($raw, 'UTF-8', 'Windows-1252');
            }
            $raw = str_replace(["\r\n", "\r"], "\n", $raw);
            $lines = array_values(array_filter(explode("\n", $raw), fn($l) => trim($l) !== ''));
            if (count($lines) < 2) {
                $galat[] = 'File kosong atau hanya berisi baris judul.';
            } else {
                $delim = substr_count($lines[0], ';') > substr_count($lines[0], ',') ? ';' : ','; // Excel Indonesia memakai titik koma
                $head = array_map(fn($h) => strtolower(trim($h)), str_getcsv($lines[0], $delim));
                $idx = function (array $names) use ($head) {
                    foreach ($names as $n) { $i = array_search($n, $head, true); if ($i !== false) return $i; }
                    return null;
                };
                $iNama = $idx(['nama']);
                $iKelas = $idx(['kelas']);
                $iUser = $idx(['username', 'nis']);
                $iWa = $idx(['no_wa', 'wa', 'hp', 'no_hp']);
                $iPass = $idx(['password']);
                if ($iNama === null || $iKelas === null) {
                    $galat[] = 'Baris judul (baris pertama) harus punya kolom "nama" dan "kelas".';
                } elseif (count($lines) - 1 > 500) {
                    $galat[] = 'Maksimal 500 baris per import.';
                } else {
                    try {
                        $pdo->beginTransaction();
                        foreach (array_slice($lines, 1) as $n => $line) {
                            $c = str_getcsv($line, $delim);
                            $get = fn($i) => $i === null ? '' : (string)($c[$i] ?? '');
                            $tambah($get($iNama), $get($iKelas), $get($iWa), $get($iUser), $get($iPass), 'Baris ' . ($n + 2));
                        }
                        $pdo->commit();
                    } catch (Throwable $t) {
                        if ($pdo->inTransaction()) $pdo->rollBack();
                        $hasil = []; $galat[] = 'Import dibatalkan karena error database. Tidak ada data yang masuk.';
                    }
                }
            }
        }

    } elseif ($aksi === 'reset') {
        $st = $pdo->prepare("SELECT * FROM users WHERE id=? AND role='anggota'");
        $st->execute([(int)($_POST['id'] ?? 0)]);
        if ($u = $st->fetch()) {
            $pass = gen_password();
            $pdo->prepare('UPDATE users SET password=? WHERE id=?')->execute([password_hash($pass, PASSWORD_DEFAULT), $u['id']]);
            $hasil[] = [$u['nama'], $u['kelas'] ?? '-', $u['username'], $pass];
        } else {
            $galat[] = 'Anggota tidak ditemukan.';
        }

    } elseif ($aksi === 'hapus') {
        $id = (int)($_POST['id'] ?? 0);
        $st = $pdo->prepare("SELECT nama FROM users WHERE id=? AND role='anggota'");
        $st->execute([$id]);
        $u = $st->fetch();
        $c = $pdo->prepare('SELECT COUNT(*) FROM peminjaman WHERE id_user=?');
        $c->execute([$id]);
        if (!$u) {
            flash('Anggota tidak ditemukan.', 'err');
        } elseif ((int)$c->fetchColumn() > 0) {
            flash('Anggota ini punya riwayat peminjaman, jadi tidak bisa dihapus.', 'err');
        } else {
            $pdo->prepare('DELETE FROM users WHERE id=?')->execute([$id]);
            flash('Anggota "' . $u['nama'] . '" dihapus.');
        }
        header('Location: admin_anggota.php');
        exit;
    }
}

$kf = $_GET['kelas'] ?? '';
$sql = "SELECT u.*,
  (SELECT COUNT(*) FROM peminjaman p WHERE p.id_user=u.id AND p.status='dipinjam') AS aktif,
  (SELECT COUNT(*) FROM peminjaman p WHERE p.id_user=u.id) AS total
  FROM users u WHERE u.role='anggota'";
$args = [];
if (in_array($kf, KELAS, true)) { $sql .= ' AND u.kelas=?'; $args[] = $kf; }
$sql .= ' ORDER BY u.kelas, u.nama';
$st = $pdo->prepare($sql);
$st->execute($args);
$anggota = $st->fetchAll();

$hitung = [];
foreach ($pdo->query("SELECT COALESCE(kelas,'-') k, COUNT(*) n FROM users WHERE role='anggota' GROUP BY kelas") as $r) $hitung[$r['k']] = (int)$r['n'];

page_header('Kelola Anggota');
?>
<h1>Kelola Anggota</h1>
<p class="sub">Tambah siswa satu per satu atau import sekaligus dari file CSV. Total anggota: <b><?= array_sum($hitung) ?></b>.</p>

<?php foreach ($galat as $g): ?><div class="alert err"><?= e($g) ?></div><?php endforeach; ?>

<?php if ($hasil): ?>
<div class="card" style="margin-bottom:16px">
  <h2 style="margin-top:0">Akun yang dibuat/direset (<?= count($hasil) ?>)</h2>
  <div class="alert warn noprint">Password hanya tampil sekarang dan tidak bisa dilihat lagi. Cetak atau simpan sebelum meninggalkan halaman ini. Kalau lupa, pakai tombol "Reset password".</div>
  <div class="tablewrap"><table>
    <tr><th>Nama</th><th>Kelas</th><th>Username</th><th>Password</th></tr>
    <?php foreach ($hasil as [$n, $k, $u, $p]): ?>
    <tr><td><?= e($n) ?></td><td><?= e($k) ?></td><td class="mono"><?= e($u) ?></td><td class="mono"><b><?= e($p) ?></b></td></tr>
    <?php endforeach; ?>
  </table></div>
  <p class="noprint"><button class="btn" onclick="window.print()">Cetak daftar akun</button></p>
</div>
<?php endif; ?>

<div class="stack noprint">
  <div class="card">
    <h2 style="margin-top:0">Import dari CSV</h2>
    <form method="post" enctype="multipart/form-data">
      <?= csrf_field() ?><input type="hidden" name="aksi" value="import">
      <div class="formgrid">
        <div><label>File CSV</label><input type="file" name="csv" accept=".csv" required></div>
        <div><button class="btn" type="submit">Import</button></div>
      </div>
    </form>
    <p class="hint">Kolom: <b>nama</b>, <b>kelas</b> (wajib), lalu <b>nis</b> (jadi username), <b>no_wa</b>, <b>password</b> (boleh kosong). Kelas harus <?= e(implode(' atau ', KELAS)) ?>. Username kosong dibuat dari nama, password kosong dibuat acak. Baris yang salah dilewati dan dilaporkan, baris yang benar tetap masuk.
    Contoh format: <a href="contoh_anggota.csv" download>contoh_anggota.csv</a>. Dari Excel: File, Save As, pilih "CSV".</p>
  </div>

  <div class="card">
    <h2 style="margin-top:0">Tambah satu anggota</h2>
    <form method="post">
      <?= csrf_field() ?><input type="hidden" name="aksi" value="tambah">
      <div class="formgrid">
        <div><label>Nama</label><input name="nama" required></div>
        <div><label>Kelas</label><select name="kelas" required><?php foreach (KELAS as $k): ?><option><?= e($k) ?></option><?php endforeach; ?></select></div>
        <div><label>NIS / username (opsional)</label><input name="username"></div>
        <div><label>No. WhatsApp</label><input name="no_wa" placeholder="08xxxxxxxxxx"></div>
        <div><label>Password (opsional)</label><input name="password"></div>
        <div><button class="btn" type="submit">Tambah</button></div>
      </div>
    </form>
  </div>
</div>

<h2 class="noprint">Daftar Anggota</h2>
<div class="filters noprint">
  <a class="chip <?= $kf === '' ? 'on' : '' ?>" href="admin_anggota.php">Semua (<?= array_sum($hitung) ?>)</a>
  <?php foreach (KELAS as $k): ?>
    <a class="chip <?= $kf === $k ? 'on' : '' ?>" href="?kelas=<?= urlencode($k) ?>"><?= e($k) ?> (<?= $hitung[$k] ?? 0 ?>)</a>
  <?php endforeach; ?>
</div>
<div class="tablewrap noprint">
<table>
  <tr><th>Nama</th><th>Kelas</th><th>Username</th><th>No. WA</th><th>Pinjaman aktif</th><th>Aksi</th></tr>
  <?php if (!$anggota): ?><tr><td colspan="6">Belum ada anggota. Import CSV atau tambah di atas.</td></tr><?php endif; ?>
  <?php foreach ($anggota as $a): ?>
  <tr>
    <td><?= e($a['nama']) ?></td>
    <td><?= e($a['kelas'] ?? '-') ?></td>
    <td class="mono"><?= e($a['username']) ?></td>
    <td><?= e($a['no_wa'] ?: '-') ?></td>
    <td><?= (int)$a['aktif'] ?></td>
    <td><div class="row">
      <form method="post" onsubmit="return confirm('Buat password baru untuk <?= e(addslashes($a['nama'])) ?>?')">
        <?= csrf_field() ?><input type="hidden" name="aksi" value="reset"><input type="hidden" name="id" value="<?= (int)$a['id'] ?>">
        <button class="btn sm ghost" type="submit">Reset password</button>
      </form>
      <form method="post" onsubmit="return confirm('Hapus anggota ini?')">
        <?= csrf_field() ?><input type="hidden" name="aksi" value="hapus"><input type="hidden" name="id" value="<?= (int)$a['id'] ?>">
        <button class="btn sm danger" type="submit" <?= (int)$a['total'] > 0 ? 'disabled title="Punya riwayat peminjaman"' : '' ?>>Hapus</button>
      </form>
    </div></td>
  </tr>
  <?php endforeach; ?>
</table>
</div>
<?php page_footer();
