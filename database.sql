-- Database Perpustakaan - Kelompok DDS
-- Import lewat phpMyAdmin (tab Import) atau jalankan: mysql -u root < database.sql
-- PERHATIAN: file ini menghapus lalu membuat ulang semua tabel. Kalau sudah ada data
-- yang ingin dipertahankan, pakai migrasi.sql saja.

CREATE DATABASE IF NOT EXISTS db_perpustakaan CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE db_perpustakaan;

DROP TABLE IF EXISTS peminjaman;
DROP TABLE IF EXISTS buku;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nama VARCHAR(100) NOT NULL,
  username VARCHAR(50) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  role ENUM('admin','petugas','anggota') NOT NULL,
  kelas VARCHAR(30) DEFAULT NULL,        -- kelas anggota (siswa)
  akses_kelas VARCHAR(30) DEFAULT NULL,  -- petugas: kelas yang boleh diakses (NULL = semua kelas)
  bisa_ubah TINYINT(1) NOT NULL DEFAULT 1,   -- petugas: 1 = boleh proses pengembalian, 0 = hanya lihat
  akses_admin TINYINT(1) NOT NULL DEFAULT 0, -- 1 = boleh masuk halaman admin
  no_wa VARCHAR(20) DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE buku (
  id INT AUTO_INCREMENT PRIMARY KEY,
  judul VARCHAR(150) NOT NULL,
  penulis VARCHAR(100) NOT NULL,
  genre ENUM('sains','komedi','horor','aksi') NOT NULL,
  stok INT NOT NULL DEFAULT 3,
  gambar VARCHAR(255) DEFAULT NULL    -- gambar sampul unggahan (opsional), mis. gambar/abc.jpg
) ENGINE=InnoDB;

CREATE TABLE peminjaman (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_user INT NOT NULL,
  id_buku INT NOT NULL,
  tgl_pinjam DATE NOT NULL,
  tgl_jatuh_tempo DATE NOT NULL,
  tgl_kembali DATE DEFAULT NULL,
  denda INT NOT NULL DEFAULT 0,
  status ENUM('dipinjam','dikembalikan') NOT NULL DEFAULT 'dipinjam',
  id_petugas INT DEFAULT NULL,
  FOREIGN KEY (id_user) REFERENCES users(id),
  FOREIGN KEY (id_buku) REFERENCES buku(id),
  FOREIGN KEY (id_petugas) REFERENCES users(id)
) ENGINE=InnoDB;

-- Akun admin dan petugas. Password: admin123 / petugas123
--  admin    : semua akses, termasuk halaman admin
--  petugas1 : semua kelas, semua tugas, boleh masuk halaman admin
--  petugas2 : mengatur kelas PPLG 1 (proses pengembalian), tanpa halaman admin
--  petugas3 : mengatur kelas PPLG 2 (proses pengembalian), tanpa halaman admin
INSERT INTO users (nama, username, password, role, akses_kelas, bisa_ubah, akses_admin) VALUES
('Administrator', 'admin',    '$2y$10$cAWpSjqhjepz9v1iDDjZKON124h1SxbLxcQgobu3JPkQ7MPT.a0sa', 'admin',   NULL,     1, 1),
('Petugas 1',     'petugas1', '$2y$10$ovQiVwFRuxfdV7C9QWG/VuTcNIw66TqR5xH0hOs3ZkZIyxExJjIra', 'petugas', NULL,     1, 1),
('Petugas 2',     'petugas2', '$2y$10$ovQiVwFRuxfdV7C9QWG/VuTcNIw66TqR5xH0hOs3ZkZIyxExJjIra', 'petugas', 'PPLG 1', 1, 0),
('Petugas 3',     'petugas3', '$2y$10$ovQiVwFRuxfdV7C9QWG/VuTcNIw66TqR5xH0hOs3ZkZIyxExJjIra', 'petugas', 'PPLG 2', 1, 0);

-- Data siswa: 33 PPLG 1 + 33 PPLG 2. Username = nama depan, password = username + 123 (contoh: adly / adly123).
INSERT IGNORE INTO users (nama, username, password, role, kelas) VALUES
('Adly Triansyah Putra', 'adly', '$2y$10$d/AfDLXqVIXMqh7Los4G7eSVK6r87a9Jxu2rn.VU2yU6GAN5uVUwS', 'anggota', 'PPLG 1'),
('Akbar Fameg Adila', 'akbar', '$2y$10$1o70v4d3wumIgfFulYz3felEmZEUDbRRVh9Fxj/dBlTJ.q5NIWbfm', 'anggota', 'PPLG 1'),
('Amel Oktafebriani', 'amel', '$2y$10$FYDfE9XLw3PmC0rxlJZG9entJ.UOCYFa6OJFgSLJvC07guHLGwjC6', 'anggota', 'PPLG 1'),
('Avinza Seno Effitra', 'avinza', '$2y$10$Vx53Ui/HTIFnTOlJnF2CdOn.6YRJuquJM31rdJ1xHRtV9yyZ/D2Xa', 'anggota', 'PPLG 1'),
('Baim Pratama', 'baim', '$2y$10$VD.oTcQ8I2R0Eh2fTz9Av.4WM06ZqaazTKn5dpc6aqRlWus5JNJTi', 'anggota', 'PPLG 1'),
('Fadhil Afredo', 'fadhil.afredo', '$2y$10$VcYsGM6nsIDxDFL.ylMyeO/QkCkcAEVo7C1UCHbJyLE0/N0UGJqMK', 'anggota', 'PPLG 1'),
('Farrel Maulana Zuhri', 'farrel', '$2y$10$0LybmEE7oQ2uMJfI22kGfew5ODnVyGJLmYf3FnDVXjSOnyjkDWziC', 'anggota', 'PPLG 1'),
('Fiyo Hendrawan', 'fiyo', '$2y$10$oiZW2SpRFkhupt15KxOGUu3XZWIhV/qzGSmhy35IMbjgLs/nETgxK', 'anggota', 'PPLG 1'),
('Gabriella Gracia Simangunsong', 'gabriella', '$2y$10$TmFChoBo/CwL9Jhrr6M8h.ZVqooyRwHruJWEgcCQrzYK6Ayjp3/TW', 'anggota', 'PPLG 1'),
('Hasby Ribalqi', 'hasby', '$2y$10$HvLl8QYBpZmqnF..HEWureMnMwEX3F6yxb2hqai3HeRVJlBl0lP8m', 'anggota', 'PPLG 1'),
('Ibnu Putra Batuta', 'ibnu', '$2y$10$HXSAiPVaVL0a5zx.yXpIdOdSHuieHyHldO6Mgdbb6v40ZKCpg5rDW', 'anggota', 'PPLG 1'),
('Jihan Aliyah Putri', 'jihan', '$2y$10$Zu2iJJkTZDCf.nyPAPHInOa5VDm2liFRFj5VHuqDkh2pSEVUvNAxi', 'anggota', 'PPLG 1'),
('Kelvin Mario Pratama', 'kelvin', '$2y$10$iM2W8gtfoF.SC7EBqsNVM.beGK7UXtSmy5A5wzpyu.171B.937rXq', 'anggota', 'PPLG 1'),
('M. Adli Fahrezi', 'adli', '$2y$10$tHtaWsYFaXyIWlsULxUZ6ekv9TKePzvrk0VM0MU0uPsfj0HqHITG.', 'anggota', 'PPLG 1'),
('Maqfirah Indriyanti', 'maqfirah', '$2y$10$Rk3qaSfterpfj3Zrvz2yH.p9JybVWyfu2rG6diFP77kPQmxEKGTK6', 'anggota', 'PPLG 1'),
('Muhammad Fajri', 'fajri', '$2y$10$.EWWAar5Dbhmrr5MoOQcBeu8XZhXw6rVMSyVd78MMrNifJYWM6Psa', 'anggota', 'PPLG 1'),
('Muhammad Hamid Nasyuha', 'hamid', '$2y$10$2d9JDu8mNnKHTcQNHl0guuvwxFMySwS8V9vN4tBkz.085a88sw..m', 'anggota', 'PPLG 1'),
('Muhammad Raka Julio', 'raka', '$2y$10$yRas0dO.U78gE2gaRbNfae4ILQnaWZq6glzWgUgyCJ4iPWpjIDxWK', 'anggota', 'PPLG 1'),
('Muhammad Zhafran Safaldi Farraz', 'zhafran', '$2y$10$snYQ4WxyPUCQ3TFajV1xPukIlcqb2t9E0y3LhWdpDQC8SBcbUMvYm', 'anggota', 'PPLG 1'),
('Nabila Luviarmi Putri', 'nabila', '$2y$10$NZF9ylcBP2ZBjDBOQ8yKDu9bSyJoxYasrRyjtVI6GLamHPUesgfi2', 'anggota', 'PPLG 1'),
('Novril Pratama Surya', 'novril', '$2y$10$5NymK7AA1RmNsTgpg75Uu.Iie1B0eOdrHlEntrzJumEiIjXakOCOC', 'anggota', 'PPLG 1'),
('Raiza Putri Armadinah', 'raiza', '$2y$10$S0bq1vTIx0jteRJQootbcOBQqLGausq8YQmDT.zTfD.foVzYyjgGe', 'anggota', 'PPLG 1'),
('Razaki Kamal Vandi', 'razaki', '$2y$10$IHb/Il6mutZ1lHYehjdEX.GjhDnH5L0Ti1iPvV1f6XFIAPhr4nl0W', 'anggota', 'PPLG 1'),
('Rey Maulana Abdur Ra''uf', 'rey', '$2y$10$WabRwXT6fFDxzEQ8jn3rg.373nAbonNaeweGeteKKX2vZ7TRiSaqK', 'anggota', 'PPLG 1'),
('Reyhan Kurniawan', 'reyhan', '$2y$10$e7OleCqSjdMHyrAGFD8QnO5R5eOyJTKQEQMgFsdzO6rO/H6kKgUqO', 'anggota', 'PPLG 1'),
('Ridho Putra Efendi', 'ridho', '$2y$10$OY7UpYhqlyvyumMC4ihCiux6/vwLzwDYxy3./QnWRPlRVFER8890a', 'anggota', 'PPLG 1'),
('Rifqa Hamidah', 'rifqa', '$2y$10$s9vrQAYXA/46imVF.qmP0eHgxxmWS1dYwMLDT2fL6jg2MST/rqV4C', 'anggota', 'PPLG 1'),
('Sultan Muhammad Syauqi', 'sultan', '$2y$10$jSrCgRDfW.s9nwzuYOCbg.q7IEeCXDQPQS81OYSQcTXYqLvUx/zv6', 'anggota', 'PPLG 1'),
('Vharel Abdis Salam', 'vharel', '$2y$10$JjTzZjNBC0Wmu4868sFmau.mSoi/gBKf/JftcgelAGp.TcwycaS0S', 'anggota', 'PPLG 1'),
('Vifian Nayla', 'vifian', '$2y$10$BIqj/tyKVMYGyKufKQoB2OQhoaf1UQJjYBhzQkmBDELh5Bb6xZx.e', 'anggota', 'PPLG 1'),
('Viky Abdul Sidiq', 'viky', '$2y$10$2Di7lNHJDjr51LTaFeQK3uH.ryUazBnzXgCzDQBip.rsPN6WECAwW', 'anggota', 'PPLG 1'),
('Yogi Fernando Putra', 'yogi', '$2y$10$D2A.gWBd87kui49LIceMe.N4ptt2cRGCqaXzQ5Y4RhtDwYjw0gXTC', 'anggota', 'PPLG 1'),
('Zhilla Zhalila', 'zhilla', '$2y$10$armW.dL6ys8HEA/xZAeCjuTGDZ5DknrG2xnaWghDYD4lFGokb/dJK', 'anggota', 'PPLG 1'),
('Adhitya Reflin', 'adhitya', '$2y$10$aJz2ciBtnRm2KstTbK0hbukOTdxyb19YIM8mfXiudHA2/qjgdQJE6', 'anggota', 'PPLG 2'),
('Ahmad Adib Adzka', 'ahmad', '$2y$10$YUh7xDRfBRBjJSYlMM.J4eurMXJIktLn1Mkb4b/3qVaVnfwqsvzNe', 'anggota', 'PPLG 2'),
('Aldrich Febrian', 'aldrich', '$2y$10$0bCAvHaKWTZXL.pm0b8ZcuzdAuM10.GuuVMrdM1ERPiCfTop5vyl.', 'anggota', 'PPLG 2'),
('Alvarino Muharafil', 'alvarino', '$2y$10$RKXgoxo0ItxGgthSq8HK7u3uoGYcpoDwqOw.xJ7KSbzeJn4QIewSC', 'anggota', 'PPLG 2'),
('Aqilla Ahmad Alrizki', 'aqilla', '$2y$10$BAuC.aYDxJmlL2smnIiqM.X6dazZ6AosepF5DwLT.qBGNMbhcioB.', 'anggota', 'PPLG 2'),
('Baghdadi Amirul Mukminin', 'baghdadi', '$2y$10$/VAabhOxEBCx0nFGJ1IINOEV17pYNLo1aPqkyi1sQzwcjGBTa1PoO', 'anggota', 'PPLG 2'),
('Bilqis Zakira Putri', 'bilqis', '$2y$10$hJfhO6GeLwNLBQi2nneO1.X/irqkNkUSClvUDnUT2hPhD34yQBPVu', 'anggota', 'PPLG 2'),
('Brilliano Denizki', 'brilliano', '$2y$10$TusE1d76bidanyTOvlJemOLw7qOfzsgXlsRjqtycEVFR6A4uf2MDS', 'anggota', 'PPLG 2'),
('Dzikra Alfath', 'dzikra', '$2y$10$oHn41eZ0N/Ux4leo4UhPYuWzR9LlISj2qRUWJFJYb79ggujivOdwa', 'anggota', 'PPLG 2'),
('Fadhil Rifarno Rauf', 'fadhil.rifarno', '$2y$10$w3RapxMEwWvinxT0mCGUqOAEsTC0pcoMZMsP4.OLjIabX1LRoJyo2', 'anggota', 'PPLG 2'),
('Fahri Andoza Putra', 'fahri', '$2y$10$Uld51whKAR5WCwTZEbu4Eu6bXRYHzSE/0PZeYg2WZFUdCLonerFe6', 'anggota', 'PPLG 2'),
('Febrian Toni', 'febrian', '$2y$10$AqbafNPv5OVNP60e2VImEeebnh0oxWbagXr/p5F1sPq/3LkMnyMg2', 'anggota', 'PPLG 2'),
('Freedy Ananda Putra Pratama', 'freedy', '$2y$10$/NuONl2/PH.lByygcrV8NuiO9aUP6EWw9sfUx0/WicFT7LdguXj3a', 'anggota', 'PPLG 2'),
('Hannafi Jumeldi', 'hannafi', '$2y$10$qmDZmB6WSSCyIWR4WNqwJeFrXmqlZgK3aRlJ.mXnAbV5dNv.saDV.', 'anggota', 'PPLG 2'),
('Jerry Putra Pratama', 'jerry', '$2y$10$jEBnBz8cnQifw/tuvFbkbu6JVma1rsFairZEfTobuCeSJoH88y7xW', 'anggota', 'PPLG 2'),
('Michel Febian', 'michel', '$2y$10$qdJqAUHufns.2vaKlmYq0OJZ2Z3itxueALEGNi2pEtqrl54YPi2eu', 'anggota', 'PPLG 2'),
('Muhammad Daffa Prayata Hendri', 'daffa', '$2y$10$en/JKZZ4Ew1JQ8fX8OI01ezbsgIXNvmFXAB8nUwU9Rq5PpLUMAoo6', 'anggota', 'PPLG 2'),
('Muhammad Luthfi', 'luthfi', '$2y$10$gksDQ8CZQLm/l9SgR9dcr.cndrdG4AF/p095LBHFT1QXLP1CwPiSO', 'anggota', 'PPLG 2'),
('Muhammad Razhel Neraldi', 'razhel', '$2y$10$kVYjtaWMrrD3siNSXzLmh.H5IIMl18UP4s4bBKFit.VZSTm7AhCjW', 'anggota', 'PPLG 2'),
('Mutiah Ilmi', 'mutiah', '$2y$10$Rsu5B0F6u5uZn8mCwwpM8OiS9lxejIO7o5tGlUVPw4NOycRh3QHR2', 'anggota', 'PPLG 2'),
('Nadien Nerliani', 'nadien', '$2y$10$tUvlL6jLRGfIxAWWtMKmcumXHoUQJbGkY/889DoTon0yNN39BQErm', 'anggota', 'PPLG 2'),
('Najwa Fitrah Dwi Agsan', 'najwa', '$2y$10$GR/07rvFkZzRwdwqfpF61eESoYjWXVpvANDk9hWbf7U6hct2fGEm2', 'anggota', 'PPLG 2'),
('Qeisa Juana Sahren', 'qeisa', '$2y$10$EMqBI5ZxOAjTevrI9mRhG.SVvEPZAw/Xk3fqUUSptUpIEs7KLCs62', 'anggota', 'PPLG 2'),
('Raafi Arrazaq', 'raafi', '$2y$10$ykHqdqTvXEhwAIzb.ApAWe1XYowM8qevq0qduxt74KFKg3S6.tLXW', 'anggota', 'PPLG 2'),
('Rafifah Ashyla Ramadhani', 'rafifah', '$2y$10$dwkaUXE5UhS0yKHJRbVNDeR4czmZC.ViallLllA3E5IyJbcixBNCq', 'anggota', 'PPLG 2'),
('Rafli Ramadhan', 'rafli', '$2y$10$DcuRhHS1k21gwFNZ39SvNu4dLSp8RRhG0m7tPhgt5NnJTXzgwbn8.', 'anggota', 'PPLG 2'),
('Raisaha Shaila Marsitah', 'raisaha', '$2y$10$xZSj0txjKFiUBvxzLA629e/CDuGb/IUo3w9pmQxKyarycm8DCnjsS', 'anggota', 'PPLG 2'),
('Ravi Maulana Pratama', 'ravi', '$2y$10$iGiAd1HSlkmJTx.brR18teM564JXeMqzN8.D1klWwqXJxfaqoapam', 'anggota', 'PPLG 2'),
('Reza Perdiansyah', 'reza', '$2y$10$ybULttCOgBpIcP1Zv5Ky/.tYyX644B7MKu7uygUk5Fagt5ftf1ZDK', 'anggota', 'PPLG 2'),
('Sulthan Muhammad As Sauqi', 'sulthan', '$2y$10$vHUBHz3owPzXh6YNJO0HaOvlygTOl5MK0azNd5fYVULY50aOr3CTm', 'anggota', 'PPLG 2'),
('Sutan Rafa Haidarsyah', 'sutan', '$2y$10$Hm35BC14G12PUJtDTIpkmOZIz3rfufZkA5wBpBRlmJMQTrRMnSySe', 'anggota', 'PPLG 2'),
('Zahra Shavia Ramadhani', 'zahra', '$2y$10$wiU5FtHgbfABc0RyYNAL/.4Ics0Ni4mPmzMOoK2LWvpHCqfeHmL6a', 'anggota', 'PPLG 2'),
('Zhilan Maulana Fadhil', 'zhilan', '$2y$10$Ra6XafxlJ9hWQrst920i4.aW5FXnqmWXRlfWg/4v57E0r7X78pgTq', 'anggota', 'PPLG 2');

-- 4 genre x 10 novel
INSERT INTO buku (judul, penulis, genre) VALUES
('Perjalanan ke Pusat Bumi', 'Jules Verne', 'sains'),
('Dua Puluh Ribu Mil di Bawah Laut', 'Jules Verne', 'sains'),
('Dari Bumi ke Bulan', 'Jules Verne', 'sains'),
('The Martian', 'Andy Weir', 'sains'),
('Contact', 'Carl Sagan', 'sains'),
('Jurassic Park', 'Michael Crichton', 'sains'),
('Flowers for Algernon', 'Daniel Keyes', 'sains'),
('Ender''s Game', 'Orson Scott Card', 'sains'),
('Frankenstein', 'Mary Shelley', 'sains'),
('Dunia Sophie', 'Jostein Gaarder', 'sains'),
('Kambing Jantan', 'Raditya Dika', 'komedi'),
('Cinta Brontosaurus', 'Raditya Dika', 'komedi'),
('Manusia Setengah Salmon', 'Raditya Dika', 'komedi'),
('Marmut Merah Jambu', 'Raditya Dika', 'komedi'),
('Koala Kumal', 'Raditya Dika', 'komedi'),
('Babi Ngesot', 'Raditya Dika', 'komedi'),
('The Hitchhiker''s Guide to the Galaxy', 'Douglas Adams', 'komedi'),
('Three Men in a Boat', 'Jerome K. Jerome', 'komedi'),
('Good Omens', 'Terry Pratchett & Neil Gaiman', 'komedi'),
('Bossypants', 'Tina Fey', 'komedi'),
('Dracula', 'Bram Stoker', 'horor'),
('It', 'Stephen King', 'horor'),
('The Shining', 'Stephen King', 'horor'),
('Pet Sematary', 'Stephen King', 'horor'),
('Misery', 'Stephen King', 'horor'),
('Carrie', 'Stephen King', 'horor'),
('The Haunting of Hill House', 'Shirley Jackson', 'horor'),
('Danur', 'Risa Saraswati', 'horor'),
('Rosemary''s Baby', 'Ira Levin', 'horor'),
('The Exorcist', 'William Peter Blatty', 'horor'),
('Angels & Demons', 'Dan Brown', 'aksi'),
('The Da Vinci Code', 'Dan Brown', 'aksi'),
('The Hunger Games', 'Suzanne Collins', 'aksi'),
('Divergent', 'Veronica Roth', 'aksi'),
('The Bourne Identity', 'Robert Ludlum', 'aksi'),
('The Count of Monte Cristo', 'Alexandre Dumas', 'aksi'),
('The Three Musketeers', 'Alexandre Dumas', 'aksi'),
('Treasure Island', 'Robert Louis Stevenson', 'aksi'),
('Casino Royale', 'Ian Fleming', 'aksi'),
('Maze Runner', 'James Dashner', 'aksi'),
('The Time Machine', 'H.G. Wells', 'sains'),
('The Andromeda Strain', 'Michael Crichton', 'sains'),
('Diary of a Wimpy Kid', 'Jeff Kinney', 'komedi'),
('The Princess Bride', 'William Goldman', 'komedi'),
('Salem''s Lot', 'Stephen King', 'horor'),
('Interview with the Vampire', 'Anne Rice', 'horor'),
('The Hobbit', 'J.R.R. Tolkien', 'aksi'),
('Ready Player One', 'Ernest Cline', 'aksi');
