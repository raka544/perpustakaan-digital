<?php
require 'config.php';
require_admin_area();

// Apakah kolom gambar sudah ada? (tambah_gambar.sql sudah dijalankan / database.sql terbaru)
try { $pdo->query('SELECT gambar FROM buku LIMIT 1'); $fiturGambar = true; } catch (Throwable $t) { $fiturGambar = false; }

// Simpan gambar unggahan. Hasil: [path, galat]. path null + galat null = tidak ada file.
function simpan_gambar(array $f) {
    if (($f['error'] ?? UPLOAD_ERR_NO_FILE) === UPLOAD_ERR_NO_FILE) return [null, null];
    if ($f['error'] !== UPLOAD_ERR_OK) return [null, 'Gambar gagal diunggah (kode ' . (int)$f['error'] . ').'];
    if ($f['size'] > 2 * 1024 * 1024) return [null, 'Gambar terlalu besar (maksimal 2 MB).'];
    $info = @getimagesize($f['tmp_name']);
    $ext = [IMAGETYPE_JPEG => 'jpg', IMAGETYPE_PNG => 'png', IMAGETYPE_WEBP => 'webp'][$info[2] ?? 0] ?? null;
    if (!$ext) return [null, 'File harus gambar JPG, PNG, atau WEBP.'];
    $dir = __DIR__ . '/' . GAMBAR_DIR;
    if (!is_dir($dir) && !mkdir($dir, 0755, true)) return [null, 'Folder gambar tidak bisa dibuat.'];
    $nama = bin2hex(random_bytes(8)) . '.' . $ext;
    if (!move_uploaded_file($f['tmp_name'], $dir . '/' . $nama)) return [null, 'Gambar tidak bisa disimpan di folder ' . GAMBAR_DIR . '.'];
    return [GAMBAR_DIR . '/' . $nama, null];
}
function hapus_file_gambar($path) {
    if ($path && preg_match('~^' . GAMBAR_DIR . '/[A-Za-z0-9_.-]+$~', $path) && is_file(__DIR__ . '/' . $path)) @unlink(__DIR__ . '/' . $path);
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_check();
    $aksi = $_POST['aksi'] ?? '';
    $id = (int)($_POST['id'] ?? 0);

    if ($aksi === 'tambah') {
        $judul = trim($_POST['judul'] ?? '');
        $penulis = trim($_POST['penulis'] ?? '');
        $genre = $_POST['genre'] ?? '';
        $stok = (int)($_POST['stok'] ?? 0);
        if ($judul === '' || $penulis === '' || !isset(GENRE[$genre]) || $stok < 0 || $stok > 999) {
            flash('Judul, penulis, genre wajib diisi dan stok 0-999.', 'err');
        } else {
            [$path, $galat] = $fiturGambar ? simpan_gambar($_FILES['gambar'] ?? []) : [null, null];
            if ($galat) {
                flash($galat, 'err');
            } elseif ($fiturGambar) {
                $pdo->prepare('INSERT INTO buku (judul, penulis, genre, stok, gambar) VALUES (?,?,?,?,?)')->execute([$judul, $penulis, $genre, $stok, $path]);
                flash('Buku "' . $judul . '" ditambahkan.');
            } else {
                $pdo->prepare('INSERT INTO buku (judul, penulis, genre, stok) VALUES (?,?,?,?)')->execute([$judul, $penulis, $genre, $stok]);
                flash('Buku "' . $judul . '" ditambahkan.');
            }
        }

    } elseif ($aksi === 'stok') {
        $stok = (int)($_POST['stok'] ?? -1);
        if ($stok < 0 || $stok > 999) {
            flash('Stok harus 0-999.', 'err');
        } else {
            $pdo->prepare('UPDATE buku SET stok=? WHERE id=?')->execute([$stok, $id]);
            flash('Stok diperbarui.');
        }

    } elseif ($aksi === 'gambar' && $fiturGambar) {
        [$path, $galat] = simpan_gambar($_FILES['gambar'] ?? []);
        if ($galat) {
            flash($galat, 'err');
        } elseif (!$path) {
            flash('Pilih file gambar terlebih dahulu.', 'err');
        } else {
            $lama = $pdo->prepare('SELECT gambar FROM buku WHERE id=?');
            $lama->execute([$id]);
            $lamaPath = $lama->fetchColumn();
            $pdo->prepare('UPDATE buku SET gambar=? WHERE id=?')->execute([$path, $id]);
            hapus_file_gambar($lamaPath);
            flash('Sampul diperbarui.');
        }

    } elseif ($aksi === 'hapus_gambar' && $fiturGambar) {
        $lama = $pdo->prepare('SELECT gambar FROM buku WHERE id=?');
        $lama->execute([$id]);
        $lamaPath = $lama->fetchColumn();
        $pdo->prepare('UPDATE buku SET gambar=NULL WHERE id=?')->execute([$id]);
        hapus_file_gambar($lamaPath);
        flash('Gambar sampul dihapus.');

    } elseif ($aksi === 'hapus') {
        $c = $pdo->prepare('SELECT COUNT(*) FROM peminjaman WHERE id_buku=?');
        $c->execute([$id]);
        if ((int)$c->fetchColumn() > 0) {
            flash('Buku ini punya riwayat peminjaman, jadi tidak bisa dihapus. Set stok ke 0 saja.', 'err');
        } else {
            if ($fiturGambar) {
                $lama = $pdo->prepare('SELECT gambar FROM buku WHERE id=?');
                $lama->execute([$id]);
                $lamaPath = $lama->fetchColumn();
            }
            $pdo->prepare('DELETE FROM buku WHERE id=?')->execute([$id]);
            if ($fiturGambar) hapus_file_gambar($lamaPath);
            flash('Buku dihapus.');
        }
    }
    header('Location: admin_buku.php' . (isset(GENRE[$_POST['genre_filter'] ?? '']) ? '?genre=' . $_POST['genre_filter'] : ''));
    exit;
}

$gf = $_GET['genre'] ?? '';
$sql = 'SELECT b.*, (SELECT COUNT(*) FROM peminjaman p WHERE p.id_buku=b.id) AS total FROM buku b';
$args = [];
if (isset(GENRE[$gf])) { $sql .= ' WHERE b.genre=?'; $args[] = $gf; }
$sql .= ' ORDER BY b.genre, b.judul';
$st = $pdo->prepare($sql);
$st->execute($args);
$buku = $st->fetchAll();

page_header('Kelola Buku');
?>
<h1>Kelola Buku</h1>
<p class="sub">Tambah buku, ubah stok, pasang gambar sampul, atau hapus buku yang belum pernah dipinjam.</p>

<?php if (!$fiturGambar): ?>
<div class="alert warn">Fitur gambar sampul belum aktif. Jalankan <b>tambah_gambar.sql</b> di phpMyAdmin (tab SQL) sekali saja, lalu muat ulang halaman ini.</div>
<?php endif; ?>

<div class="card" style="margin-bottom:16px">
  <h2 style="margin-top:0">Tambah buku</h2>
  <form method="post" enctype="multipart/form-data">
    <?= csrf_field() ?><input type="hidden" name="aksi" value="tambah">
    <div class="formgrid">
      <div><label>Judul</label><input name="judul" required></div>
      <div><label>Penulis</label><input name="penulis" required></div>
      <div><label>Genre</label><select name="genre"><?php foreach (GENRE as $k => $label): ?><option value="<?= $k ?>"><?= e($label) ?></option><?php endforeach; ?></select></div>
      <div><label>Stok</label><input name="stok" type="number" min="0" max="999" value="3" required></div>
      <?php if ($fiturGambar): ?><div><label>Sampul (opsional)</label><input type="file" name="gambar" accept="image/jpeg,image/png,image/webp"></div><?php endif; ?>
      <div><button class="btn" type="submit">Tambah</button></div>
    </div>
    <?php if ($fiturGambar): ?><p class="hint">Boleh dikosongkan dan diunggah nanti. Gambar JPG/PNG/WEBP, maksimal 2 MB.</p><?php endif; ?>
  </form>
</div>

<div class="filters">
  <a class="chip <?= $gf === '' ? 'on' : '' ?>" href="admin_buku.php">Semua</a>
  <?php foreach (GENRE as $k => $label): ?>
    <a class="chip <?= $gf === $k ? 'on' : '' ?>" href="?genre=<?= $k ?>"><?= e($label) ?></a>
  <?php endforeach; ?>
</div>

<div class="tablewrap">
<table>
  <tr><th>Sampul</th><th>Judul</th><th>Penulis</th><th>Genre</th><th>Stok tersedia</th><th>Gambar sampul</th><th></th></tr>
  <?php foreach ($buku as $b): ?>
  <tr>
    <td><?= cover_html($b, 'thumb') ?></td>
    <td><b><?= e($b['judul']) ?></b></td>
    <td><?= e($b['penulis']) ?></td>
    <td><?= e(GENRE[$b['genre']]) ?></td>
    <td>
      <form method="post" class="inline">
        <?= csrf_field() ?><input type="hidden" name="aksi" value="stok"><input type="hidden" name="id" value="<?= (int)$b['id'] ?>">
        <input type="hidden" name="genre_filter" value="<?= e($gf) ?>">
        <input type="number" name="stok" min="0" max="999" value="<?= (int)$b['stok'] ?>">
        <button class="btn sm ghost" type="submit">Simpan</button>
      </form>
    </td>
    <td>
    <?php if ($fiturGambar): ?>
      <form method="post" enctype="multipart/form-data" class="upl">
        <?= csrf_field() ?><input type="hidden" name="aksi" value="gambar"><input type="hidden" name="id" value="<?= (int)$b['id'] ?>">
        <input type="hidden" name="genre_filter" value="<?= e($gf) ?>">
        <input type="file" name="gambar" accept="image/jpeg,image/png,image/webp" required>
        <button class="btn sm ghost" type="submit">Unggah</button>
      </form>
      <?php if (!empty($b['gambar'])): ?>
      <form method="post" onsubmit="return confirm('Hapus gambar sampul ini?')" style="margin-top:4px">
        <?= csrf_field() ?><input type="hidden" name="aksi" value="hapus_gambar"><input type="hidden" name="id" value="<?= (int)$b['id'] ?>">
        <input type="hidden" name="genre_filter" value="<?= e($gf) ?>">
        <button class="btn sm danger" type="submit">Hapus gambar</button>
      </form>
      <?php endif; ?>
    <?php else: ?><small>-</small><?php endif; ?>
    </td>
    <td>
      <form method="post" onsubmit="return confirm('Hapus buku ini?')">
        <?= csrf_field() ?><input type="hidden" name="aksi" value="hapus"><input type="hidden" name="id" value="<?= (int)$b['id'] ?>">
        <input type="hidden" name="genre_filter" value="<?= e($gf) ?>">
        <button class="btn sm danger" type="submit" <?= (int)$b['total'] > 0 ? 'disabled title="Punya riwayat peminjaman"' : '' ?>>Hapus buku</button>
      </form>
    </td>
  </tr>
  <?php endforeach; ?>
</table>
</div>
<?php page_footer();
