<?php
require 'config.php';
require_login(['admin', 'petugas']);

$f = $_GET['status'] ?? '';
[$sw, $sa] = scope_where('u.kelas');
$sql = "SELECT p.*, b.judul, u.nama, u.kelas, pt.nama AS nama_petugas FROM peminjaman p
        JOIN buku b ON b.id=p.id_buku JOIN users u ON u.id=p.id_user LEFT JOIN users pt ON pt.id=p.id_petugas
        WHERE 1=1$sw";
$args = $sa;
if (in_array($f, ['dipinjam', 'dikembalikan'], true)) { $sql .= ' AND p.status=?'; $args[] = $f; }
$sql .= ' ORDER BY p.id DESC LIMIT 300';
$st = $pdo->prepare($sql);
$st->execute($args);
$rows = $st->fetchAll();

$st = $pdo->prepare("SELECT COALESCE(SUM(p.denda),0) FROM peminjaman p JOIN users u ON u.id=p.id_user WHERE p.status='dikembalikan'$sw");
$st->execute($sa);
$totalDenda = (int)$st->fetchColumn();

page_header('Riwayat Peminjaman');
?>
<h1>Riwayat Peminjaman<?= akses_kelas() ? ' · ' . e(akses_kelas()) : '' ?></h1>
<p class="sub">Total denda yang sudah tercatat: <b><?= rupiah($totalDenda) ?></b></p>
<div class="filters">
  <a class="chip <?= $f === '' ? 'on' : '' ?>" href="staff_riwayat.php">Semua</a>
  <a class="chip <?= $f === 'dipinjam' ? 'on' : '' ?>" href="?status=dipinjam">Dipinjam</a>
  <a class="chip <?= $f === 'dikembalikan' ? 'on' : '' ?>" href="?status=dikembalikan">Dikembalikan</a>
</div>
<div class="tablewrap">
<table>
  <tr><th>#</th><th>Anggota</th><th>Kelas</th><th>Buku</th><th>Pinjam</th><th>Jatuh tempo</th><th>Kembali</th><th>Denda</th><th>Petugas</th><th></th></tr>
  <?php if (!$rows): ?><tr><td colspan="10">Belum ada data.</td></tr><?php endif; ?>
  <?php foreach ($rows as $r): ?>
  <tr>
    <td><?= (int)$r['id'] ?></td><td><?= e($r['nama']) ?></td><td><?= e($r['kelas'] ?? '-') ?></td><td><?= e($r['judul']) ?></td>
    <td><?= tanggal($r['tgl_pinjam']) ?></td><td><?= tanggal($r['tgl_jatuh_tempo']) ?></td><td><?= tanggal($r['tgl_kembali']) ?></td>
    <td><?= $r['status'] === 'dikembalikan' ? ((int)$r['denda'] > 0 ? rupiah($r['denda']) : '-') : '<span class="badge warn">Dipinjam</span>' ?></td>
    <td><?= e($r['nama_petugas'] ?? '-') ?></td>
    <td><?= $r['status'] === 'dikembalikan' ? '<a class="btn sm ghost" href="struk.php?id=' . (int)$r['id'] . '">Struk</a>' : '' ?></td>
  </tr>
  <?php endforeach; ?>
</table>
</div>
<?php page_footer();
