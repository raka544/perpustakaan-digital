<?php
// Konfigurasi aplikasi perpustakaan
date_default_timezone_set('Asia/Jakarta');
session_start();

const DB_HOST = 'localhost';
const DB_NAME = 'db_perpustakaan';
const DB_USER = 'root';
const DB_PASS = '';

const NAMA_KELOMPOK = 'DDS';
const NAMA_APP = 'Perpustakaan DDS';
const LAMA_PINJAM = 7;        // hari
const DENDA_PER_HARI = 10000; // rupiah
const KELAS = ['PPLG 1', 'PPLG 2'];
const GENRE = [
    'sains'  => 'Sains (Pelajaran)',
    'komedi' => 'Komedi',
    'horor'  => 'Horor',
    'aksi'   => 'Aksi',
];

const GAMBAR_DIR = 'gambar';

try {
    $pdo = new PDO('mysql:host=' . DB_HOST . ';dbname=' . DB_NAME . ';charset=utf8mb4', DB_USER, DB_PASS, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]);
} catch (PDOException $ex) {
    die('Koneksi database gagal. Pastikan MySQL menyala dan database.sql sudah diimport.');
}

function e($s) { return htmlspecialchars((string)$s, ENT_QUOTES, 'UTF-8'); }
function rupiah($n) { return 'Rp' . number_format((int)$n, 0, ',', '.'); }
function tanggal($d) {
    if (!$d) return '-';
    $bulan = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'];
    $t = new DateTime($d);
    return $t->format('j') . ' ' . $bulan[(int)$t->format('n') - 1] . ' ' . $t->format('Y');
}

/* ---------- Pengguna dan izin ---------- */
function user() { return $_SESSION['user'] ?? null; }
function is_staff() { return in_array(user()['role'] ?? '', ['admin', 'petugas'], true); }
// Izin petugas: boleh mengubah data (proses pengembalian, kirim WA)?
function can_edit() { return !empty(user()['bisa_ubah']); }
// Boleh masuk halaman admin (kelola anggota/buku)?
function is_admin_area() { return !empty(user()['akses_admin']); }
// Kelas yang boleh diakses petugas. null = semua kelas.
function akses_kelas() { return user()['akses_kelas'] ?? null; }
function in_scope($kelasAnggota) {
    $a = akses_kelas();
    return $a === null || $a === $kelasAnggota;
}
// Potongan SQL pembatas kelas, mis. scope_where('u.kelas') => [" AND u.kelas = ?", ['PPLG 1']]
function scope_where($kolom) {
    $a = akses_kelas();
    return $a === null ? ['', []] : [" AND $kolom = ?", [$a]];
}

function require_login(array $roles = []) {
    if (!user()) { header('Location: login.php'); exit; }
    // Sesi lama (sebelum fitur izin) dianggap tidak valid: minta login ulang
    if (!array_key_exists('akses_kelas', user())) {
        $_SESSION = [];
        header('Location: login.php');
        exit;
    }
    if ($roles && !in_array(user()['role'], $roles, true)) {
        http_response_code(403);
        die('Akses ditolak untuk peran Anda.');
    }
}
function require_admin_area() {
    require_login(['admin', 'petugas']);
    if (!is_admin_area()) {
        http_response_code(403);
        die('Halaman admin. Akun Anda tidak punya akses ke halaman ini.');
    }
}

function home_for($role) {
    return $role === 'anggota' ? 'katalog.php' : 'staff.php';
}

function csrf_token() {
    if (empty($_SESSION['csrf'])) $_SESSION['csrf'] = bin2hex(random_bytes(16));
    return $_SESSION['csrf'];
}
function csrf_field() { return '<input type="hidden" name="csrf" value="' . csrf_token() . '">'; }
function csrf_check() {
    if (!hash_equals($_SESSION['csrf'] ?? '', $_POST['csrf'] ?? '')) {
        http_response_code(400);
        die('Permintaan tidak valid (token salah). Muat ulang halaman.');
    }
}

function flash($msg, $type = 'ok') { $_SESSION['flash'] = [$msg, $type]; }

/* ---------- Denda dan tanggal ---------- */
// Selisih hari terlambat: tanggal acuan dikurangi jatuh tempo (minimal 0)
function hari_telat($jatuhTempo, $acuan = null) {
    $a = new DateTime($acuan ?: 'today');
    $j = new DateTime($jatuhTempo);
    return $a > $j ? (int)$j->diff($a)->days : 0;
}
function hitung_denda($jatuhTempo, $acuan = null) {
    return hari_telat($jatuhTempo, $acuan) * DENDA_PER_HARI;
}
// Sisa hari menuju jatuh tempo (negatif jika sudah lewat)
function sisa_hari($jatuhTempo) {
    $today = new DateTime('today');
    $j = new DateTime($jatuhTempo);
    $d = (int)$today->diff($j)->days;
    return $j >= $today ? $d : -$d;
}

/* ---------- WhatsApp ---------- */
function wa_link($noWa, $pesan) {
    $n = preg_replace('/\D+/', '', (string)$noWa);
    if ($n === '') return null;
    if ($n[0] === '0') $n = '62' . substr($n, 1);
    elseif ($n[0] === '8') $n = '62' . $n; // nomor dari Excel sering kehilangan angka 0 di depan
    return 'https://wa.me/' . $n . '?text=' . rawurlencode($pesan);
}

function pesan_pengingat($nama, $judul, $jatuhTempo) {
    $sisa = sisa_hari($jatuhTempo);
    if ($sisa < 0) {
        $denda = hitung_denda($jatuhTempo);
        return "Halo $nama, buku \"$judul\" sudah terlambat " . (-$sisa) . " hari (jatuh tempo " . tanggal($jatuhTempo) . "). Denda berjalan " . rupiah($denda) . " (" . rupiah(DENDA_PER_HARI) . "/hari). Mohon segera dikembalikan. - " . NAMA_APP;
    }
    $kapan = $sisa === 0 ? 'hari ini' : 'besok';
    return "Halo $nama, pengingat: buku \"$judul\" jatuh tempo $kapan (" . tanggal($jatuhTempo) . "). Kembalikan tepat waktu agar tidak kena denda " . rupiah(DENDA_PER_HARI) . "/hari. - " . NAMA_APP;
}

// Notifikasi untuk anggota yang sedang login
function notif_anggota(PDO $pdo, $idUser) {
    $st = $pdo->prepare("SELECT p.*, b.judul FROM peminjaman p JOIN buku b ON b.id=p.id_buku WHERE p.id_user=? AND p.status='dipinjam' ORDER BY p.tgl_jatuh_tempo");
    $st->execute([$idUser]);
    $out = [];
    foreach ($st as $r) {
        $sisa = sisa_hari($r['tgl_jatuh_tempo']);
        if ($sisa < 0) {
            $out[] = ['bad', 'Terlambat ' . (-$sisa) . ' hari: "' . $r['judul'] . '". Denda berjalan ' . rupiah(hitung_denda($r['tgl_jatuh_tempo'])) . '.'];
        } elseif ($sisa <= 1) {
            $out[] = ['warn', 'Buku "' . $r['judul'] . '" jatuh tempo ' . ($sisa === 0 ? 'hari ini' : 'besok') . '. Kembalikan tepat waktu agar tidak kena denda ' . rupiah(DENDA_PER_HARI) . '/hari.'];
        }
    }
    return $out;
}

/* ---------- Akun anggota (dipakai halaman admin) ---------- */
function gen_password($len = 6) {
    $abc = 'abcdefghjkmnpqrstuvwxyz23456789'; // tanpa huruf/angka yang mirip
    $s = '';
    for ($i = 0; $i < $len; $i++) $s .= $abc[random_int(0, strlen($abc) - 1)];
    return $s;
}
function norm_kelas($k) { return preg_replace('/\s+/', '', strtoupper((string)$k)); }
// "pplg1" / "PPLG  1" -> "PPLG 1"; null jika tidak dikenal
function cari_kelas($k) {
    foreach (KELAS as $kk) if (norm_kelas($kk) === norm_kelas($k)) return $kk;
    return null;
}
function buat_username(PDO $pdo, $nama) {
    $kata = preg_split('/\s+/', strtolower(trim((string)$nama)));
    $kata = array_values(array_filter(array_map(fn($w) => preg_replace('/[^a-z0-9]/', '', $w), $kata)));
    $base = substr(implode('.', array_slice($kata, 0, 2)), 0, 24);
    if (strlen($base) < 3) $base = 'siswa' . $base;
    $st = $pdo->prepare('SELECT 1 FROM users WHERE username=?');
    $u = $base; $i = 1;
    while (true) {
        $st->execute([$u]);
        if (!$st->fetch()) return $u;
        $i++;
        $u = $base . $i;
    }
}

/* ---------- Sampul buku ---------- */
// Gambar sampul unggahan kalau ada; kalau belum, kotak polos berwarna sesuai genre.
function cover_html(array $b, $kelas = 'cover') {
    $g = $b['genre'] ?? 'sains';
    $label = GENRE[$g] ?? $g;
    $kosong = '<span class="kosong">Belum ada sampul</span><span class="gl">' . e($label) . '</span>';
    if (!empty($b['gambar']) && preg_match('~^' . GAMBAR_DIR . '/[A-Za-z0-9_.-]+$~', $b['gambar'])) {
        return '<div class="' . $kelas . ' has-img g-' . e($g) . '"><img src="' . e($b['gambar']) . '" alt="Sampul ' . e($b['judul'] ?? '') . '" loading="lazy" '
             . 'onerror="this.parentNode.classList.remove(\'has-img\');this.remove()">' . $kosong . '</div>';
    }
    return '<div class="' . $kelas . ' g-' . e($g) . '">' . $kosong . '</div>';
}

/* ---------- Tampilan ---------- */
function page_header($title) {
    $u = user();
    $info = '';
    if ($u) {
        if ($u['role'] === 'anggota') {
            $info = !empty($u['kelas']) ? ' · ' . $u['kelas'] : '';
        } else {
            $info = akses_kelas() ? ' · ' . akses_kelas() . (can_edit() ? '' : ' (lihat saja)') : ' · semua kelas';
        }
    }
    ?><!DOCTYPE html>
<html lang="id">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><?= e($title) ?> - <?= e(NAMA_APP) ?></title>
<link rel="stylesheet" href="style.css?v=<?= (int)@filemtime(__DIR__ . '/style.css') ?>">
</head>
<body>
<?php if ($u): ?>
<header class="topbar">
  <a class="brand" href="<?= home_for($u['role']) ?>">📚 <?= e(NAMA_APP) ?></a>
  <nav>
    <?php if ($u['role'] === 'anggota'): ?>
      <a href="katalog.php">Katalog Buku</a>
      <a href="pinjaman_saya.php">Pinjaman Saya</a>
    <?php else: ?>
      <a href="staff.php">Peminjaman Aktif</a>
      <a href="staff_riwayat.php">Riwayat</a>
      <a href="anggota_pantau.php">Pantau Anggota</a>
      <?php if (is_admin_area()): ?>
        <a href="admin_anggota.php">Kelola Anggota</a>
        <a href="admin_buku.php">Kelola Buku</a>
      <?php endif; ?>
    <?php endif; ?>
  </nav>
  <div class="who"><span class="role"><?= e($u['role']) ?></span> <?= e($u['nama']) ?><?= e($info) ?> · <a href="logout.php">Keluar</a></div>
</header>
<?php endif; ?>
<main class="wrap">
<?php
    if (!empty($_SESSION['flash'])) {
        [$m, $t] = $_SESSION['flash'];
        unset($_SESSION['flash']);
        echo '<div class="alert ' . e($t) . '">' . e($m) . '</div>';
    }
    if ($u && $u['role'] === 'anggota') {
        global $pdo;
        foreach (notif_anggota($pdo, $u['id']) as [$lvl, $msg]) {
            echo '<div class="alert ' . ($lvl === 'bad' ? 'bad' : 'warn') . '">🔔 ' . e($msg) . '</div>';
        }
    }
}

function page_footer() {
    echo '</main><footer class="foot">Kelompok ' . e(NAMA_KELOMPOK) . ' · Adly Transyah Putra, Fiyo Hendrawan, Muhammad Raka Julo</footer></body></html>';
}
