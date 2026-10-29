-- Mengaktifkan fitur gambar sampul buku di database yang SUDAH berjalan (data lain tetap aman).
-- Jalankan SEKALI di phpMyAdmin: pilih db_perpustakaan > tab SQL > tempel > Go.
-- Kalau muncul "Duplicate column name 'gambar'", berarti sudah aktif; abaikan saja.
USE db_perpustakaan;

ALTER TABLE buku ADD COLUMN gambar VARCHAR(255) DEFAULT NULL;
