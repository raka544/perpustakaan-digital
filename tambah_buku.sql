-- Tambah 2 buku per genre ke database yang SUDAH berjalan (stok awal 3 per buku).
-- Aman dijalankan ulang: buku dengan judul yang sama dilewati.
USE db_perpustakaan;

INSERT INTO buku (judul, penulis, genre) SELECT 'The Time Machine', 'H.G. Wells', 'sains' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM buku WHERE judul = 'The Time Machine');
INSERT INTO buku (judul, penulis, genre) SELECT 'The Andromeda Strain', 'Michael Crichton', 'sains' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM buku WHERE judul = 'The Andromeda Strain');
INSERT INTO buku (judul, penulis, genre) SELECT 'Diary of a Wimpy Kid', 'Jeff Kinney', 'komedi' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM buku WHERE judul = 'Diary of a Wimpy Kid');
INSERT INTO buku (judul, penulis, genre) SELECT 'The Princess Bride', 'William Goldman', 'komedi' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM buku WHERE judul = 'The Princess Bride');
INSERT INTO buku (judul, penulis, genre) SELECT 'Salem''s Lot', 'Stephen King', 'horor' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM buku WHERE judul = 'Salem''s Lot');
INSERT INTO buku (judul, penulis, genre) SELECT 'Interview with the Vampire', 'Anne Rice', 'horor' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM buku WHERE judul = 'Interview with the Vampire');
INSERT INTO buku (judul, penulis, genre) SELECT 'The Hobbit', 'J.R.R. Tolkien', 'aksi' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM buku WHERE judul = 'The Hobbit');
INSERT INTO buku (judul, penulis, genre) SELECT 'Ready Player One', 'Ernest Cline', 'aksi' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM buku WHERE judul = 'Ready Player One');
