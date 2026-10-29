-- Migrasi untuk database yang SUDAH diimport sebelumnya (data lama tetap aman).
-- Jalankan di phpMyAdmin: pilih db_perpustakaan > tab SQL > tempel > Go.
-- Jalankan HANYA SEKALI. Kalau muncul error "Duplicate column name", berarti sudah pernah dijalankan.

USE db_perpustakaan;

ALTER TABLE users
  ADD COLUMN kelas VARCHAR(30) DEFAULT NULL AFTER role,
  ADD COLUMN akses_kelas VARCHAR(30) DEFAULT NULL AFTER kelas,
  ADD COLUMN bisa_ubah TINYINT(1) NOT NULL DEFAULT 1 AFTER akses_kelas,
  ADD COLUMN akses_admin TINYINT(1) NOT NULL DEFAULT 0 AFTER bisa_ubah;

-- admin dan petugas1: semua kelas, boleh halaman admin
UPDATE users SET akses_admin = 1, akses_kelas = NULL, bisa_ubah = 1 WHERE username IN ('admin', 'petugas1');
-- petugas2: mengatur kelas PPLG 1
UPDATE users SET akses_kelas = 'PPLG 1', bisa_ubah = 1, akses_admin = 0 WHERE username = 'petugas2';
-- petugas3: mengatur kelas PPLG 2
UPDATE users SET akses_kelas = 'PPLG 2', bisa_ubah = 1, akses_admin = 0 WHERE username = 'petugas3';

-- Hapus akun anggota contoh (aman dijalankan walau sudah dihapus)
UPDATE buku SET stok = stok + (
  SELECT COUNT(*) FROM peminjaman p
  JOIN users u ON u.id = p.id_user
  WHERE p.id_buku = buku.id AND p.status = 'dipinjam'
    AND u.username IN ('anggota1','anggota2')
);
DELETE FROM peminjaman WHERE id_user IN (SELECT id FROM users WHERE username IN ('anggota1','anggota2'));
DELETE FROM users WHERE username IN ('anggota1','anggota2');
