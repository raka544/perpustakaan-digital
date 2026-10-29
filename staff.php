<?php
require 'config.php';
require_login(['admin', 'petugas']);

// Proses pengembalian buku (hanya akun yang boleh mengubah data, dan hanya untuk kelasnya)
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_check();
    $id = (int)($_POST['id'] ?? 0);
    if (!can_edit()) {
        flash('Akun Anda hanya bisa melihat data, tidak bisa memproses pengembalian.', 'err');
        header('Location: staff.php');
        exit;
    }
    try {
        $pdo->beginTransaction();
        $st = $pdo->prepare("SELECT p.*, u.kelas FROM peminjaman p JOIN users u ON u.id=p.id_user WHERE p.id=? AND p.status='dipinjam' FOR UPDATE");
        $st->execute([$id]);
        $p = $st->fetch();
        if (!$p || !in_scope($p['kelas'])) {
            $pdo->rollBack();
            flash('Data peminjaman tidak ditemukan, sudah dikembalikan, atau di luar kelas Anda.', 'err');
        } else {
            $denda = hitung_denda($p['tgl_jatuh_tempo']);
            $pdo->prepare("UPDATE peminjaman SET status='dikembalikan', tgl_kembali=CURDATE(), denda=?, id_petugas=? WHERE id=?")
                ->execute([$denda, user()['id'], $id]);
            $pdo->prepare('UPDATE buku SET stok=stok+1 WHERE id=?')->execute([$p['id_buku']]);
            $pdo->commit();
            header('Location: struk.php?id=' . $id);
            exit;
        }
    } catch (Throwable $t) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        flash('Gagal memproses pengembalian.', 'err');
    }
    header('Location: staff.php');
    exit;
}

[$sw, $sa] = scope_where('u.kelas');
$st = $pdo->prepare("SELECT p.*, b.judul, u.nama, u.kelas, u.no_wa FROM peminjaman p JOIN buku b ON b.id=p.id_buku JOIN users u ON u.id=p.id_user WHERE p.status='dipinjam'$sw ORDER BY p.tgl_jatuh_tempo, p.id");
$st->execute($sa);
$rows = $st->fetchAll();
$totalStok = (int)$pdo->query('SELECT COALESCE(SUM(stok),0) FROM buku')->fetchColumn();
$telat = 0; $ingat = 0; $dendaBerjalan = 0;
foreach ($rows as $r) {
    $s = sisa_hari($r['tgl_jatuh_tempo']);
    if ($s < 0) { $telat++; $dendaBerjalan += hitung_denda($r['tgl_jatuh_tempo']); }
    elseif ($s <= 1) $ingat++;
}

page_header('Peminjaman Aktif');
?>
<h1>Peminjaman Aktif<?= akses_kelas() ? ' · ' . e(akses_kelas()) : '' ?></h1>
<p class="sub">
  <?php if (can_edit()): ?>
    Kelola buku yang sedang dipinjam dan proses pengembaliannya. Denda dihitung otomatis <?= rupiah(DENDA_PER_HARI) ?> per hari keterlambatan.
  <?php else: ?>
    Akun Anda hanya bisa <b>melihat</b> data kelas <?= e(akses_kelas() ?? 'semua kelas') ?>. Pengembalian diproses oleh petugas lain.
  <?php endif; ?>
</p>

<div class="stats">
  <div class="stat"><b><?= count($rows) ?></b><span>Sedang dipinjam</span></div>
  <div class="stat"><b><?= $ingat ?></b><span>Perlu diingatkan (jatuh tempo ≤ 1 hari)</span></div>
  <div class="stat"><b><?= $telat ?></b><span>Terlambat</span></div>
  <div class="stat"><b><?= rupiah($dendaBerjalan) ?></b><span>Denda berjalan</span></div>
  <div class="stat"><b><?= $totalStok ?></b><span>Total stok tersedia</span></div>
</div>

<h2>Daftar Peminjaman</h2>
<div class="tablewrap">
<table>
  <tr><th>Anggota</th><th>Kelas</th><th>Buku</th><th>Dipinjam</th><th>Jatuh tempo</th><th>Status</th><th>Denda sekarang</th><th>Aksi</th></tr>
  <?php if (!$rows): ?><tr><td colspan="8">Tidak ada buku yang sedang dipinjam.</td></tr><?php endif; ?>
  <?php foreach ($rows as $r):
    $s = sisa_hari($r['tgl_jatuh_tempo']);
    $denda = hitung_denda($r['tgl_jatuh_tempo']);
    $perluWa = $s <= 1;
    if ($s < 0) $badge = '<span class="badge bad">Terlambat ' . (-$s) . ' hari</span>';
    elseif ($s <= 1) $badge = '<span class="badge warn">Jatuh tempo ' . ($s === 0 ? 'hari ini' : 'besok') . '</span>';
    else $badge = '<span class="badge ok">Aman (' . $s . ' hari lagi)</span>';
    $wa = $perluWa ? wa_link($r['no_wa'], pesan_pengingat($r['nama'], $r['judul'], $r['tgl_jatuh_tempo'])) : null;
  ?>
  <tr>
    <td><?= e($r['nama']) ?></td>
    <td><?= e($r['kelas'] ?? '-') ?></td>
    <td><?= e($r['judul']) ?></td>
    <td><?= tanggal($r['tgl_pinjam']) ?></td>
    <td><?= tanggal($r['tgl_jatuh_tempo']) ?></td>
    <td><?= $badge ?></td>
    <td><?= $denda > 0 ? '<b>' . rupiah($denda) . '</b>' : '-' ?></td>
    <td>
    <?php if (can_edit()): ?>
      <div class="row">
      <form method="post" onsubmit="return confirm('Proses pengembalian buku ini?<?= $denda > 0 ? ' Denda ' . rupiah($denda) . '.' : '' ?>')">
        <?= csrf_field() ?><input type="hidden" name="id" value="<?= (int)$r['id'] ?>">
        <button class="btn sm" type="submit">Kembalikan</button>
      </form>
      <?php if ($wa): ?><a class="btn sm wa" target="_blank" rel="noopener" href="<?= e($wa) ?>">Ingatkan WA</a>
      <?php elseif ($perluWa): ?><small>No. WA kosong</small><?php endif; ?>
      </div>
    <?php else: ?>
      <small>Lihat saja</small>
    <?php endif; ?>
    </td>
  </tr>
  <?php endforeach; ?>
</table>
</div>
<?php page_footer();
