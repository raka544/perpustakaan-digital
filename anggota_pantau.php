<?php
require 'config.php';
require_login(['admin', 'petugas']);

$q = trim($_GET['q'] ?? '');
$kf = $_GET['kelas'] ?? '';
[$sw, $sa] = scope_where('u.kelas');

$sql = "SELECT u.* FROM users u WHERE u.role='anggota' AND (u.nama LIKE ? OR u.username LIKE ?)$sw";
$args = array_merge(["%$q%", "%$q%"], $sa);
if (akses_kelas() === null && in_array($kf, KELAS, true)) { $sql .= ' AND u.kelas=?'; $args[] = $kf; }
$sql .= ' ORDER BY u.kelas, u.nama';
$st = $pdo->prepare($sql);
$st->execute($args);
$anggota = $st->fetchAll();

$st = $pdo->prepare("SELECT p.*, b.judul FROM peminjaman p JOIN buku b ON b.id=p.id_buku JOIN users u ON u.id=p.id_user WHERE p.status='dipinjam'$sw");
$st->execute($sa);
$byUser = [];
foreach ($st as $a) $byUser[$a['id_user']][] = $a;

$st = $pdo->prepare("SELECT p.id_user, SUM(p.denda) t FROM peminjaman p JOIN users u ON u.id=p.id_user WHERE p.status='dikembalikan'$sw GROUP BY p.id_user");
$st->execute($sa);
$dendaLunas = [];
foreach ($st as $r) $dendaLunas[$r['id_user']] = (int)$r['t'];

page_header('Pantau Anggota');
?>
<h1>Pantau Anggota<?= akses_kelas() ? ' · ' . e(akses_kelas()) : '' ?></h1>
<p class="sub">Lihat pinjaman aktif, keterlambatan, dan denda setiap anggota. Total: <b><?= count($anggota) ?></b> anggota.</p>

<?php if (akses_kelas() === null): ?>
<div class="filters">
  <a class="chip <?= $kf === '' ? 'on' : '' ?>" href="?q=<?= urlencode($q) ?>">Semua kelas</a>
  <?php foreach (KELAS as $k): ?>
    <a class="chip <?= $kf === $k ? 'on' : '' ?>" href="?kelas=<?= urlencode($k) ?>&q=<?= urlencode($q) ?>"><?= e($k) ?></a>
  <?php endforeach; ?>
</div>
<?php endif; ?>

<form class="search" method="get">
  <?php if ($kf !== ''): ?><input type="hidden" name="kelas" value="<?= e($kf) ?>"><?php endif; ?>
  <input name="q" value="<?= e($q) ?>" placeholder="Cari nama atau username anggota...">
  <button class="btn" type="submit">Cari</button>
</form>
<div class="tablewrap">
<table>
  <tr><th>Anggota</th><th>Kelas</th><th>No. WA</th><th>Pinjaman aktif</th><th>Terlambat</th><th>Denda berjalan</th><th>Denda tercatat</th></tr>
  <?php if (!$anggota): ?><tr><td colspan="7">Belum ada anggota<?= akses_kelas() ? ' di kelas ini' : '' ?>.</td></tr><?php endif; ?>
  <?php foreach ($anggota as $a):
    $list = $byUser[$a['id']] ?? [];
    $telat = 0; $berjalan = 0;
    foreach ($list as $l) { if (sisa_hari($l['tgl_jatuh_tempo']) < 0) { $telat++; $berjalan += hitung_denda($l['tgl_jatuh_tempo']); } }
  ?>
  <tr>
    <td><b><?= e($a['nama']) ?></b><br><small>@<?= e($a['username']) ?></small></td>
    <td><?= e($a['kelas'] ?? '-') ?></td>
    <td><?= e($a['no_wa'] ?: '-') ?></td>
    <td><?= count($list) ?><?php foreach ($list as $l): ?><br><small>• <?= e($l['judul']) ?> (<?= tanggal($l['tgl_jatuh_tempo']) ?>)</small><?php endforeach; ?></td>
    <td><?= $telat ? '<span class="badge bad">' . $telat . ' buku</span>' : '-' ?></td>
    <td><?= $berjalan ? rupiah($berjalan) : '-' ?></td>
    <td><?= !empty($dendaLunas[$a['id']]) ? rupiah($dendaLunas[$a['id']]) : '-' ?></td>
  </tr>
  <?php endforeach; ?>
</table>
</div>
<?php page_footer();
