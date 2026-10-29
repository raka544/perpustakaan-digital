<?php
require 'config.php';
require_login();
$id = (int)($_GET['id'] ?? 0);
$st = $pdo->prepare("SELECT p.*, b.judul, u.nama, u.kelas AS kelas_anggota, pt.nama AS nama_petugas FROM peminjaman p
    JOIN buku b ON b.id=p.id_buku JOIN users u ON u.id=p.id_user LEFT JOIN users pt ON pt.id=p.id_petugas
    WHERE p.id=? AND p.status='dikembalikan'");
$st->execute([$id]);
$p = $st->fetch();
if (!$p
    || (user()['role'] === 'anggota' && (int)$p['id_user'] !== user()['id'])
    || (is_staff() && !in_scope($p['kelas_anggota']))) {
    http_response_code(404);
    die('Struk tidak ditemukan.');
}
$telat = hari_telat($p['tgl_jatuh_tempo'], $p['tgl_kembali']);

page_header('Struk #' . $p['id']);
?>
<div class="struk">
  <h2><?= e(NAMA_APP) ?></h2>
  <p class="c">Struk Pengembalian Buku</p>
  <hr>
  <div class="r"><span>No. Struk</span><span>#<?= str_pad((string)$p['id'], 5, '0', STR_PAD_LEFT) ?></span></div>
  <div class="r"><span>Anggota</span><span><?= e($p['nama']) ?></span></div>
  <div class="r"><span>Buku</span><span><?= e($p['judul']) ?></span></div>
  <hr>
  <div class="r"><span>Tgl pinjam</span><span><?= tanggal($p['tgl_pinjam']) ?></span></div>
  <div class="r"><span>Jatuh tempo</span><span><?= tanggal($p['tgl_jatuh_tempo']) ?></span></div>
  <div class="r"><span>Tgl kembali</span><span><?= tanggal($p['tgl_kembali']) ?></span></div>
  <hr>
  <div class="r"><span>Terlambat</span><span><?= $telat ?> hari</span></div>
  <div class="r"><span>Tarif denda/hari</span><span><?= rupiah(DENDA_PER_HARI) ?></span></div>
  <div class="r tot"><span>TOTAL DENDA</span><span><?= rupiah($p['denda']) ?></span></div>
  <hr>
  <p class="c">Petugas: <?= e($p['nama_petugas'] ?? '-') ?><br>Terima kasih telah mengembalikan buku.</p>
</div>
<p class="noprint" style="text-align:center">
  <button class="btn" onclick="window.print()">Cetak struk</button>
  <a class="btn ghost" href="<?= is_staff() ? 'staff.php' : 'pinjaman_saya.php' ?>">Kembali</a>
</p>
<?php page_footer();
