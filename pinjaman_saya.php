<?php
require 'config.php';
require_login(['anggota']);
$uid = user()['id'];

$st = $pdo->prepare('SELECT p.*, b.judul, b.penulis FROM peminjaman p JOIN buku b ON b.id=p.id_buku WHERE p.id_user=? ORDER BY p.status, p.tgl_pinjam DESC, p.id DESC');
$st->execute([$uid]);
$rows = $st->fetchAll();

page_header('Pinjaman Saya');
?>
<h1>Pinjaman Saya</h1>
<p class="sub">Pengembalian buku dicatat oleh petugas di perpustakaan. Struk tersedia setelah buku dikembalikan.</p>

<div class="tablewrap">
<table>
  <tr><th>Buku</th><th>Dipinjam</th><th>Jatuh tempo</th><th>Dikembalikan</th><th>Status</th><th>Denda</th><th></th></tr>
  <?php if (!$rows): ?><tr><td colspan="7">Belum ada peminjaman.</td></tr><?php endif; ?>
  <?php foreach ($rows as $r):
    if ($r['status'] === 'dipinjam') {
        $sisa = sisa_hari($r['tgl_jatuh_tempo']);
        $denda = hitung_denda($r['tgl_jatuh_tempo']);
        if ($sisa < 0) { $badge = '<span class="badge bad">Terlambat ' . (-$sisa) . ' hari</span>'; }
        elseif ($sisa <= 1) { $badge = '<span class="badge warn">Jatuh tempo ' . ($sisa === 0 ? 'hari ini' : 'besok') . '</span>'; }
        else { $badge = '<span class="badge ok">Dipinjam (' . $sisa . ' hari lagi)</span>'; }
    } else {
        $badge = '<span class="badge gray">Dikembalikan</span>';
        $denda = (int)$r['denda'];
    }
  ?>
  <tr>
    <td><b><?= e($r['judul']) ?></b><br><small><?= e($r['penulis']) ?></small></td>
    <td><?= tanggal($r['tgl_pinjam']) ?></td>
    <td><?= tanggal($r['tgl_jatuh_tempo']) ?></td>
    <td><?= tanggal($r['tgl_kembali']) ?></td>
    <td><?= $badge ?></td>
    <td><?= $denda > 0 ? rupiah($denda) . ($r['status'] === 'dipinjam' ? ' (berjalan)' : '') : '-' ?></td>
    <td><?= $r['status'] === 'dikembalikan' ? '<a class="btn sm ghost" href="struk.php?id=' . (int)$r['id'] . '">Struk</a>' : '' ?></td>
  </tr>
  <?php endforeach; ?>
</table>
</div>
<?php page_footer();
