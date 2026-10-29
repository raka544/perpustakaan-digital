<?php
require 'config.php';
require_login(['anggota']);
$uid = user()['id'];

// Proses pinjam
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_check();
    $idBuku = (int)($_POST['id_buku'] ?? 0);
    try {
        $pdo->beginTransaction();
        $st = $pdo->prepare('SELECT * FROM buku WHERE id=? FOR UPDATE');
        $st->execute([$idBuku]);
        $b = $st->fetch();
        $dup = $pdo->prepare("SELECT 1 FROM peminjaman WHERE id_user=? AND id_buku=? AND status='dipinjam'");
        $dup->execute([$uid, $idBuku]);
        if (!$b) {
            flash('Buku tidak ditemukan.', 'err');
        } elseif ($b['stok'] < 1) {
            flash('Stok buku habis.', 'err');
        } elseif ($dup->fetch()) {
            flash('Anda masih meminjam buku ini.', 'err');
        } else {
            $pdo->prepare('UPDATE buku SET stok=stok-1 WHERE id=?')->execute([$idBuku]);
            $pdo->prepare('INSERT INTO peminjaman (id_user,id_buku,tgl_pinjam,tgl_jatuh_tempo) VALUES (?,?,CURDATE(),DATE_ADD(CURDATE(), INTERVAL ' . LAMA_PINJAM . ' DAY))')
                ->execute([$uid, $idBuku]);
            flash('Berhasil meminjam "' . $b['judul'] . '". Jatuh tempo ' . LAMA_PINJAM . ' hari lagi.');
        }
        $pdo->commit();
    } catch (Throwable $t) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        flash('Terjadi kesalahan saat meminjam.', 'err');
    }
    header('Location: katalog.php?' . http_build_query(['genre' => $_POST['genre'] ?? '', 'q' => $_POST['q'] ?? '']));
    exit;
}

$genre = $_GET['genre'] ?? '';
$q = trim($_GET['q'] ?? '');
$sql = 'SELECT * FROM buku WHERE 1=1';
$args = [];
if (isset(GENRE[$genre])) { $sql .= ' AND genre=?'; $args[] = $genre; }
if ($q !== '') { $sql .= ' AND (judul LIKE ? OR penulis LIKE ?)'; $args[] = "%$q%"; $args[] = "%$q%"; }
$sql .= ' ORDER BY genre, judul';
$st = $pdo->prepare($sql);
$st->execute($args);
$buku = $st->fetchAll();

page_header('Katalog Buku');
?>
<h1>Katalog Buku</h1>
<p class="sub">Cari novel berdasarkan genre. Masa pinjam <?= LAMA_PINJAM ?> hari, denda keterlambatan <?= rupiah(DENDA_PER_HARI) ?> per hari.</p>

<form class="search" method="get">
  <?php if ($genre): ?><input type="hidden" name="genre" value="<?= e($genre) ?>"><?php endif; ?>
  <input name="q" value="<?= e($q) ?>" placeholder="Cari judul atau penulis...">
  <button class="btn" type="submit">Cari</button>
</form>
<div class="filters">
  <a class="chip <?= $genre === '' ? 'on' : '' ?>" href="katalog.php<?= $q ? '?q=' . urlencode($q) : '' ?>">Semua</a>
  <?php foreach (GENRE as $k => $label): ?>
    <a class="chip <?= $genre === $k ? 'on' : '' ?>" href="katalog.php?genre=<?= $k ?><?= $q ? '&q=' . urlencode($q) : '' ?>"><?= e($label) ?></a>
  <?php endforeach; ?>
</div>

<?php if (!$buku): ?>
  <div class="card">Tidak ada buku yang cocok.</div>
<?php else: ?>
<div class="grid">
<?php foreach ($buku as $b): ?>
  <div class="book">
    <?= cover_html($b) ?>
    <h3><?= e($b['judul']) ?></h3>
    <small><?= e($b['penulis']) ?></small>
    <small>Stok: <b><?= (int)$b['stok'] ?></b></small>
    <form method="post">
      <?= csrf_field() ?>
      <input type="hidden" name="id_buku" value="<?= (int)$b['id'] ?>">
      <input type="hidden" name="genre" value="<?= e($genre) ?>">
      <input type="hidden" name="q" value="<?= e($q) ?>">
      <button class="btn sm" type="submit" <?= $b['stok'] < 1 ? 'disabled' : '' ?>><?= $b['stok'] < 1 ? 'Stok habis' : 'Pinjam' ?></button>
    </form>
  </div>
<?php endforeach; ?>
</div>
<?php endif; ?>
<?php page_footer();
