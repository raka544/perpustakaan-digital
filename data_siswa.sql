USE db_perpustakaan;

-- Data siswa: 33 PPLG 1 + 33 PPLG 2. Username = nama depan, password = username + 123 (contoh: adly / adly123).
-- Bagian 1: kalau sebelumnya siswa sudah masuk dengan username NUS, ubah saja (bukan digandakan).
UPDATE users SET username='adly', password='$2y$10$d/AfDLXqVIXMqh7Los4G7eSVK6r87a9Jxu2rn.VU2yU6GAN5uVUwS' WHERE username='2407001' AND role='anggota';
UPDATE users SET username='akbar', password='$2y$10$1o70v4d3wumIgfFulYz3felEmZEUDbRRVh9Fxj/dBlTJ.q5NIWbfm' WHERE username='2407003' AND role='anggota';
UPDATE users SET username='amel', password='$2y$10$FYDfE9XLw3PmC0rxlJZG9entJ.UOCYFa6OJFgSLJvC07guHLGwjC6' WHERE username='2407004' AND role='anggota';
UPDATE users SET username='avinza', password='$2y$10$Vx53Ui/HTIFnTOlJnF2CdOn.6YRJuquJM31rdJ1xHRtV9yyZ/D2Xa' WHERE username='2407005' AND role='anggota';
UPDATE users SET username='baim', password='$2y$10$VD.oTcQ8I2R0Eh2fTz9Av.4WM06ZqaazTKn5dpc6aqRlWus5JNJTi' WHERE username='2407007' AND role='anggota';
UPDATE users SET username='fadhil.afredo', password='$2y$10$VcYsGM6nsIDxDFL.ylMyeO/QkCkcAEVo7C1UCHbJyLE0/N0UGJqMK' WHERE username='2407008' AND role='anggota';
UPDATE users SET username='farrel', password='$2y$10$0LybmEE7oQ2uMJfI22kGfew5ODnVyGJLmYf3FnDVXjSOnyjkDWziC' WHERE username='2407009' AND role='anggota';
UPDATE users SET username='fiyo', password='$2y$10$oiZW2SpRFkhupt15KxOGUu3XZWIhV/qzGSmhy35IMbjgLs/nETgxK' WHERE username='2407011' AND role='anggota';
UPDATE users SET username='gabriella', password='$2y$10$TmFChoBo/CwL9Jhrr6M8h.ZVqooyRwHruJWEgcCQrzYK6Ayjp3/TW' WHERE username='2407012' AND role='anggota';
UPDATE users SET username='hasby', password='$2y$10$HvLl8QYBpZmqnF..HEWureMnMwEX3F6yxb2hqai3HeRVJlBl0lP8m' WHERE username='2407013' AND role='anggota';
UPDATE users SET username='ibnu', password='$2y$10$HXSAiPVaVL0a5zx.yXpIdOdSHuieHyHldO6Mgdbb6v40ZKCpg5rDW' WHERE username='2407014' AND role='anggota';
UPDATE users SET username='jihan', password='$2y$10$Zu2iJJkTZDCf.nyPAPHInOa5VDm2liFRFj5VHuqDkh2pSEVUvNAxi' WHERE username='2407015' AND role='anggota';
UPDATE users SET username='kelvin', password='$2y$10$iM2W8gtfoF.SC7EBqsNVM.beGK7UXtSmy5A5wzpyu.171B.937rXq' WHERE username='2407016' AND role='anggota';
UPDATE users SET username='adli', password='$2y$10$tHtaWsYFaXyIWlsULxUZ6ekv9TKePzvrk0VM0MU0uPsfj0HqHITG.' WHERE username='2407017' AND role='anggota';
UPDATE users SET username='maqfirah', password='$2y$10$Rk3qaSfterpfj3Zrvz2yH.p9JybVWyfu2rG6diFP77kPQmxEKGTK6' WHERE username='2407018' AND role='anggota';
UPDATE users SET username='fajri', password='$2y$10$.EWWAar5Dbhmrr5MoOQcBeu8XZhXw6rVMSyVd78MMrNifJYWM6Psa' WHERE username='2407019' AND role='anggota';
UPDATE users SET username='hamid', password='$2y$10$2d9JDu8mNnKHTcQNHl0guuvwxFMySwS8V9vN4tBkz.085a88sw..m' WHERE username='2407020' AND role='anggota';
UPDATE users SET username='raka', password='$2y$10$yRas0dO.U78gE2gaRbNfae4ILQnaWZq6glzWgUgyCJ4iPWpjIDxWK' WHERE username='2407021' AND role='anggota';
UPDATE users SET username='zhafran', password='$2y$10$snYQ4WxyPUCQ3TFajV1xPukIlcqb2t9E0y3LhWdpDQC8SBcbUMvYm' WHERE username='2407022' AND role='anggota';
UPDATE users SET username='nabila', password='$2y$10$NZF9ylcBP2ZBjDBOQ8yKDu9bSyJoxYasrRyjtVI6GLamHPUesgfi2' WHERE username='2407023' AND role='anggota';
UPDATE users SET username='novril', password='$2y$10$5NymK7AA1RmNsTgpg75Uu.Iie1B0eOdrHlEntrzJumEiIjXakOCOC' WHERE username='2407025' AND role='anggota';
UPDATE users SET username='raiza', password='$2y$10$S0bq1vTIx0jteRJQootbcOBQqLGausq8YQmDT.zTfD.foVzYyjgGe' WHERE username='2407026' AND role='anggota';
UPDATE users SET username='razaki', password='$2y$10$IHb/Il6mutZ1lHYehjdEX.GjhDnH5L0Ti1iPvV1f6XFIAPhr4nl0W' WHERE username='2407027' AND role='anggota';
UPDATE users SET username='rey', password='$2y$10$WabRwXT6fFDxzEQ8jn3rg.373nAbonNaeweGeteKKX2vZ7TRiSaqK' WHERE username='2407028' AND role='anggota';
UPDATE users SET username='reyhan', password='$2y$10$e7OleCqSjdMHyrAGFD8QnO5R5eOyJTKQEQMgFsdzO6rO/H6kKgUqO' WHERE username='2407029' AND role='anggota';
UPDATE users SET username='ridho', password='$2y$10$OY7UpYhqlyvyumMC4ihCiux6/vwLzwDYxy3./QnWRPlRVFER8890a' WHERE username='2407030' AND role='anggota';
UPDATE users SET username='rifqa', password='$2y$10$s9vrQAYXA/46imVF.qmP0eHgxxmWS1dYwMLDT2fL6jg2MST/rqV4C' WHERE username='2407031' AND role='anggota';
UPDATE users SET username='sultan', password='$2y$10$jSrCgRDfW.s9nwzuYOCbg.q7IEeCXDQPQS81OYSQcTXYqLvUx/zv6' WHERE username='2407032' AND role='anggota';
UPDATE users SET username='vharel', password='$2y$10$JjTzZjNBC0Wmu4868sFmau.mSoi/gBKf/JftcgelAGp.TcwycaS0S' WHERE username='2407545' AND role='anggota';
UPDATE users SET username='vifian', password='$2y$10$BIqj/tyKVMYGyKufKQoB2OQhoaf1UQJjYBhzQkmBDELh5Bb6xZx.e' WHERE username='2407033' AND role='anggota';
UPDATE users SET username='viky', password='$2y$10$2Di7lNHJDjr51LTaFeQK3uH.ryUazBnzXgCzDQBip.rsPN6WECAwW' WHERE username='2407034' AND role='anggota';
UPDATE users SET username='yogi', password='$2y$10$D2A.gWBd87kui49LIceMe.N4ptt2cRGCqaXzQ5Y4RhtDwYjw0gXTC' WHERE username='2407035' AND role='anggota';
UPDATE users SET username='zhilla', password='$2y$10$armW.dL6ys8HEA/xZAeCjuTGDZ5DknrG2xnaWghDYD4lFGokb/dJK' WHERE username='2407036' AND role='anggota';
UPDATE users SET username='adhitya', password='$2y$10$aJz2ciBtnRm2KstTbK0hbukOTdxyb19YIM8mfXiudHA2/qjgdQJE6' WHERE username='2407037' AND role='anggota';
UPDATE users SET username='ahmad', password='$2y$10$YUh7xDRfBRBjJSYlMM.J4eurMXJIktLn1Mkb4b/3qVaVnfwqsvzNe' WHERE username='2407038' AND role='anggota';
UPDATE users SET username='aldrich', password='$2y$10$0bCAvHaKWTZXL.pm0b8ZcuzdAuM10.GuuVMrdM1ERPiCfTop5vyl.' WHERE username='2407040' AND role='anggota';
UPDATE users SET username='alvarino', password='$2y$10$RKXgoxo0ItxGgthSq8HK7u3uoGYcpoDwqOw.xJ7KSbzeJn4QIewSC' WHERE username='2407041' AND role='anggota';
UPDATE users SET username='aqilla', password='$2y$10$BAuC.aYDxJmlL2smnIiqM.X6dazZ6AosepF5DwLT.qBGNMbhcioB.' WHERE username='2407042' AND role='anggota';
UPDATE users SET username='baghdadi', password='$2y$10$/VAabhOxEBCx0nFGJ1IINOEV17pYNLo1aPqkyi1sQzwcjGBTa1PoO' WHERE username='2407043' AND role='anggota';
UPDATE users SET username='bilqis', password='$2y$10$hJfhO6GeLwNLBQi2nneO1.X/irqkNkUSClvUDnUT2hPhD34yQBPVu' WHERE username='2407044' AND role='anggota';
UPDATE users SET username='brilliano', password='$2y$10$TusE1d76bidanyTOvlJemOLw7qOfzsgXlsRjqtycEVFR6A4uf2MDS' WHERE username='2407045' AND role='anggota';
UPDATE users SET username='dzikra', password='$2y$10$oHn41eZ0N/Ux4leo4UhPYuWzR9LlISj2qRUWJFJYb79ggujivOdwa' WHERE username='2407046' AND role='anggota';
UPDATE users SET username='fadhil.rifarno', password='$2y$10$w3RapxMEwWvinxT0mCGUqOAEsTC0pcoMZMsP4.OLjIabX1LRoJyo2' WHERE username='2407047' AND role='anggota';
UPDATE users SET username='fahri', password='$2y$10$Uld51whKAR5WCwTZEbu4Eu6bXRYHzSE/0PZeYg2WZFUdCLonerFe6' WHERE username='2407048' AND role='anggota';
UPDATE users SET username='febrian', password='$2y$10$AqbafNPv5OVNP60e2VImEeebnh0oxWbagXr/p5F1sPq/3LkMnyMg2' WHERE username='2407050' AND role='anggota';
UPDATE users SET username='freedy', password='$2y$10$/NuONl2/PH.lByygcrV8NuiO9aUP6EWw9sfUx0/WicFT7LdguXj3a' WHERE username='2407051' AND role='anggota';
UPDATE users SET username='hannafi', password='$2y$10$qmDZmB6WSSCyIWR4WNqwJeFrXmqlZgK3aRlJ.mXnAbV5dNv.saDV.' WHERE username='2407052' AND role='anggota';
UPDATE users SET username='jerry', password='$2y$10$jEBnBz8cnQifw/tuvFbkbu6JVma1rsFairZEfTobuCeSJoH88y7xW' WHERE username='2407053' AND role='anggota';
UPDATE users SET username='michel', password='$2y$10$qdJqAUHufns.2vaKlmYq0OJZ2Z3itxueALEGNi2pEtqrl54YPi2eu' WHERE username='2407054' AND role='anggota';
UPDATE users SET username='daffa', password='$2y$10$en/JKZZ4Ew1JQ8fX8OI01ezbsgIXNvmFXAB8nUwU9Rq5PpLUMAoo6' WHERE username='2407055' AND role='anggota';
UPDATE users SET username='luthfi', password='$2y$10$gksDQ8CZQLm/l9SgR9dcr.cndrdG4AF/p095LBHFT1QXLP1CwPiSO' WHERE username='2407056' AND role='anggota';
UPDATE users SET username='razhel', password='$2y$10$kVYjtaWMrrD3siNSXzLmh.H5IIMl18UP4s4bBKFit.VZSTm7AhCjW' WHERE username='2407057' AND role='anggota';
UPDATE users SET username='mutiah', password='$2y$10$Rsu5B0F6u5uZn8mCwwpM8OiS9lxejIO7o5tGlUVPw4NOycRh3QHR2' WHERE username='2407058' AND role='anggota';
UPDATE users SET username='nadien', password='$2y$10$tUvlL6jLRGfIxAWWtMKmcumXHoUQJbGkY/889DoTon0yNN39BQErm' WHERE username='2407059' AND role='anggota';
UPDATE users SET username='najwa', password='$2y$10$GR/07rvFkZzRwdwqfpF61eESoYjWXVpvANDk9hWbf7U6hct2fGEm2' WHERE username='2407060' AND role='anggota';
UPDATE users SET username='qeisa', password='$2y$10$EMqBI5ZxOAjTevrI9mRhG.SVvEPZAw/Xk3fqUUSptUpIEs7KLCs62' WHERE username='2407061' AND role='anggota';
UPDATE users SET username='raafi', password='$2y$10$ykHqdqTvXEhwAIzb.ApAWe1XYowM8qevq0qduxt74KFKg3S6.tLXW' WHERE username='2407062' AND role='anggota';
UPDATE users SET username='rafifah', password='$2y$10$dwkaUXE5UhS0yKHJRbVNDeR4czmZC.ViallLllA3E5IyJbcixBNCq' WHERE username='2407063' AND role='anggota';
UPDATE users SET username='rafli', password='$2y$10$DcuRhHS1k21gwFNZ39SvNu4dLSp8RRhG0m7tPhgt5NnJTXzgwbn8.' WHERE username='2407064' AND role='anggota';
UPDATE users SET username='raisaha', password='$2y$10$xZSj0txjKFiUBvxzLA629e/CDuGb/IUo3w9pmQxKyarycm8DCnjsS' WHERE username='2407065' AND role='anggota';
UPDATE users SET username='ravi', password='$2y$10$iGiAd1HSlkmJTx.brR18teM564JXeMqzN8.D1klWwqXJxfaqoapam' WHERE username='2407066' AND role='anggota';
UPDATE users SET username='reza', password='$2y$10$ybULttCOgBpIcP1Zv5Ky/.tYyX644B7MKu7uygUk5Fagt5ftf1ZDK' WHERE username='2407067' AND role='anggota';
UPDATE users SET username='sulthan', password='$2y$10$vHUBHz3owPzXh6YNJO0HaOvlygTOl5MK0azNd5fYVULY50aOr3CTm' WHERE username='2407068' AND role='anggota';
UPDATE users SET username='sutan', password='$2y$10$Hm35BC14G12PUJtDTIpkmOZIz3rfufZkA5wBpBRlmJMQTrRMnSySe' WHERE username='2407069' AND role='anggota';
UPDATE users SET username='zahra', password='$2y$10$wiU5FtHgbfABc0RyYNAL/.4Ics0Ni4mPmzMOoK2LWvpHCqfeHmL6a' WHERE username='2407071' AND role='anggota';
UPDATE users SET username='zhilan', password='$2y$10$Ra6XafxlJ9hWQrst920i4.aW5FXnqmWXRlfWg/4v57E0r7X78pgTq' WHERE username='2407072' AND role='anggota';

-- Bagian 2: tambahkan siswa yang belum ada. Aman dijalankan ulang.
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

-- Bagian 3: samakan password siswa yang SUDAH ada di database (password = username + 123).
UPDATE users SET password='$2y$10$d/AfDLXqVIXMqh7Los4G7eSVK6r87a9Jxu2rn.VU2yU6GAN5uVUwS' WHERE username='adly' AND role='anggota';
UPDATE users SET password='$2y$10$1o70v4d3wumIgfFulYz3felEmZEUDbRRVh9Fxj/dBlTJ.q5NIWbfm' WHERE username='akbar' AND role='anggota';
UPDATE users SET password='$2y$10$FYDfE9XLw3PmC0rxlJZG9entJ.UOCYFa6OJFgSLJvC07guHLGwjC6' WHERE username='amel' AND role='anggota';
UPDATE users SET password='$2y$10$Vx53Ui/HTIFnTOlJnF2CdOn.6YRJuquJM31rdJ1xHRtV9yyZ/D2Xa' WHERE username='avinza' AND role='anggota';
UPDATE users SET password='$2y$10$VD.oTcQ8I2R0Eh2fTz9Av.4WM06ZqaazTKn5dpc6aqRlWus5JNJTi' WHERE username='baim' AND role='anggota';
UPDATE users SET password='$2y$10$VcYsGM6nsIDxDFL.ylMyeO/QkCkcAEVo7C1UCHbJyLE0/N0UGJqMK' WHERE username='fadhil.afredo' AND role='anggota';
UPDATE users SET password='$2y$10$0LybmEE7oQ2uMJfI22kGfew5ODnVyGJLmYf3FnDVXjSOnyjkDWziC' WHERE username='farrel' AND role='anggota';
UPDATE users SET password='$2y$10$oiZW2SpRFkhupt15KxOGUu3XZWIhV/qzGSmhy35IMbjgLs/nETgxK' WHERE username='fiyo' AND role='anggota';
UPDATE users SET password='$2y$10$TmFChoBo/CwL9Jhrr6M8h.ZVqooyRwHruJWEgcCQrzYK6Ayjp3/TW' WHERE username='gabriella' AND role='anggota';
UPDATE users SET password='$2y$10$HvLl8QYBpZmqnF..HEWureMnMwEX3F6yxb2hqai3HeRVJlBl0lP8m' WHERE username='hasby' AND role='anggota';
UPDATE users SET password='$2y$10$HXSAiPVaVL0a5zx.yXpIdOdSHuieHyHldO6Mgdbb6v40ZKCpg5rDW' WHERE username='ibnu' AND role='anggota';
UPDATE users SET password='$2y$10$Zu2iJJkTZDCf.nyPAPHInOa5VDm2liFRFj5VHuqDkh2pSEVUvNAxi' WHERE username='jihan' AND role='anggota';
UPDATE users SET password='$2y$10$iM2W8gtfoF.SC7EBqsNVM.beGK7UXtSmy5A5wzpyu.171B.937rXq' WHERE username='kelvin' AND role='anggota';
UPDATE users SET password='$2y$10$tHtaWsYFaXyIWlsULxUZ6ekv9TKePzvrk0VM0MU0uPsfj0HqHITG.' WHERE username='adli' AND role='anggota';
UPDATE users SET password='$2y$10$Rk3qaSfterpfj3Zrvz2yH.p9JybVWyfu2rG6diFP77kPQmxEKGTK6' WHERE username='maqfirah' AND role='anggota';
UPDATE users SET password='$2y$10$.EWWAar5Dbhmrr5MoOQcBeu8XZhXw6rVMSyVd78MMrNifJYWM6Psa' WHERE username='fajri' AND role='anggota';
UPDATE users SET password='$2y$10$2d9JDu8mNnKHTcQNHl0guuvwxFMySwS8V9vN4tBkz.085a88sw..m' WHERE username='hamid' AND role='anggota';
UPDATE users SET password='$2y$10$yRas0dO.U78gE2gaRbNfae4ILQnaWZq6glzWgUgyCJ4iPWpjIDxWK' WHERE username='raka' AND role='anggota';
UPDATE users SET password='$2y$10$snYQ4WxyPUCQ3TFajV1xPukIlcqb2t9E0y3LhWdpDQC8SBcbUMvYm' WHERE username='zhafran' AND role='anggota';
UPDATE users SET password='$2y$10$NZF9ylcBP2ZBjDBOQ8yKDu9bSyJoxYasrRyjtVI6GLamHPUesgfi2' WHERE username='nabila' AND role='anggota';
UPDATE users SET password='$2y$10$5NymK7AA1RmNsTgpg75Uu.Iie1B0eOdrHlEntrzJumEiIjXakOCOC' WHERE username='novril' AND role='anggota';
UPDATE users SET password='$2y$10$S0bq1vTIx0jteRJQootbcOBQqLGausq8YQmDT.zTfD.foVzYyjgGe' WHERE username='raiza' AND role='anggota';
UPDATE users SET password='$2y$10$IHb/Il6mutZ1lHYehjdEX.GjhDnH5L0Ti1iPvV1f6XFIAPhr4nl0W' WHERE username='razaki' AND role='anggota';
UPDATE users SET password='$2y$10$WabRwXT6fFDxzEQ8jn3rg.373nAbonNaeweGeteKKX2vZ7TRiSaqK' WHERE username='rey' AND role='anggota';
UPDATE users SET password='$2y$10$e7OleCqSjdMHyrAGFD8QnO5R5eOyJTKQEQMgFsdzO6rO/H6kKgUqO' WHERE username='reyhan' AND role='anggota';
UPDATE users SET password='$2y$10$OY7UpYhqlyvyumMC4ihCiux6/vwLzwDYxy3./QnWRPlRVFER8890a' WHERE username='ridho' AND role='anggota';
UPDATE users SET password='$2y$10$s9vrQAYXA/46imVF.qmP0eHgxxmWS1dYwMLDT2fL6jg2MST/rqV4C' WHERE username='rifqa' AND role='anggota';
UPDATE users SET password='$2y$10$jSrCgRDfW.s9nwzuYOCbg.q7IEeCXDQPQS81OYSQcTXYqLvUx/zv6' WHERE username='sultan' AND role='anggota';
UPDATE users SET password='$2y$10$JjTzZjNBC0Wmu4868sFmau.mSoi/gBKf/JftcgelAGp.TcwycaS0S' WHERE username='vharel' AND role='anggota';
UPDATE users SET password='$2y$10$BIqj/tyKVMYGyKufKQoB2OQhoaf1UQJjYBhzQkmBDELh5Bb6xZx.e' WHERE username='vifian' AND role='anggota';
UPDATE users SET password='$2y$10$2Di7lNHJDjr51LTaFeQK3uH.ryUazBnzXgCzDQBip.rsPN6WECAwW' WHERE username='viky' AND role='anggota';
UPDATE users SET password='$2y$10$D2A.gWBd87kui49LIceMe.N4ptt2cRGCqaXzQ5Y4RhtDwYjw0gXTC' WHERE username='yogi' AND role='anggota';
UPDATE users SET password='$2y$10$armW.dL6ys8HEA/xZAeCjuTGDZ5DknrG2xnaWghDYD4lFGokb/dJK' WHERE username='zhilla' AND role='anggota';
UPDATE users SET password='$2y$10$aJz2ciBtnRm2KstTbK0hbukOTdxyb19YIM8mfXiudHA2/qjgdQJE6' WHERE username='adhitya' AND role='anggota';
UPDATE users SET password='$2y$10$YUh7xDRfBRBjJSYlMM.J4eurMXJIktLn1Mkb4b/3qVaVnfwqsvzNe' WHERE username='ahmad' AND role='anggota';
UPDATE users SET password='$2y$10$0bCAvHaKWTZXL.pm0b8ZcuzdAuM10.GuuVMrdM1ERPiCfTop5vyl.' WHERE username='aldrich' AND role='anggota';
UPDATE users SET password='$2y$10$RKXgoxo0ItxGgthSq8HK7u3uoGYcpoDwqOw.xJ7KSbzeJn4QIewSC' WHERE username='alvarino' AND role='anggota';
UPDATE users SET password='$2y$10$BAuC.aYDxJmlL2smnIiqM.X6dazZ6AosepF5DwLT.qBGNMbhcioB.' WHERE username='aqilla' AND role='anggota';
UPDATE users SET password='$2y$10$/VAabhOxEBCx0nFGJ1IINOEV17pYNLo1aPqkyi1sQzwcjGBTa1PoO' WHERE username='baghdadi' AND role='anggota';
UPDATE users SET password='$2y$10$hJfhO6GeLwNLBQi2nneO1.X/irqkNkUSClvUDnUT2hPhD34yQBPVu' WHERE username='bilqis' AND role='anggota';
UPDATE users SET password='$2y$10$TusE1d76bidanyTOvlJemOLw7qOfzsgXlsRjqtycEVFR6A4uf2MDS' WHERE username='brilliano' AND role='anggota';
UPDATE users SET password='$2y$10$oHn41eZ0N/Ux4leo4UhPYuWzR9LlISj2qRUWJFJYb79ggujivOdwa' WHERE username='dzikra' AND role='anggota';
UPDATE users SET password='$2y$10$w3RapxMEwWvinxT0mCGUqOAEsTC0pcoMZMsP4.OLjIabX1LRoJyo2' WHERE username='fadhil.rifarno' AND role='anggota';
UPDATE users SET password='$2y$10$Uld51whKAR5WCwTZEbu4Eu6bXRYHzSE/0PZeYg2WZFUdCLonerFe6' WHERE username='fahri' AND role='anggota';
UPDATE users SET password='$2y$10$AqbafNPv5OVNP60e2VImEeebnh0oxWbagXr/p5F1sPq/3LkMnyMg2' WHERE username='febrian' AND role='anggota';
UPDATE users SET password='$2y$10$/NuONl2/PH.lByygcrV8NuiO9aUP6EWw9sfUx0/WicFT7LdguXj3a' WHERE username='freedy' AND role='anggota';
UPDATE users SET password='$2y$10$qmDZmB6WSSCyIWR4WNqwJeFrXmqlZgK3aRlJ.mXnAbV5dNv.saDV.' WHERE username='hannafi' AND role='anggota';
UPDATE users SET password='$2y$10$jEBnBz8cnQifw/tuvFbkbu6JVma1rsFairZEfTobuCeSJoH88y7xW' WHERE username='jerry' AND role='anggota';
UPDATE users SET password='$2y$10$qdJqAUHufns.2vaKlmYq0OJZ2Z3itxueALEGNi2pEtqrl54YPi2eu' WHERE username='michel' AND role='anggota';
UPDATE users SET password='$2y$10$en/JKZZ4Ew1JQ8fX8OI01ezbsgIXNvmFXAB8nUwU9Rq5PpLUMAoo6' WHERE username='daffa' AND role='anggota';
UPDATE users SET password='$2y$10$gksDQ8CZQLm/l9SgR9dcr.cndrdG4AF/p095LBHFT1QXLP1CwPiSO' WHERE username='luthfi' AND role='anggota';
UPDATE users SET password='$2y$10$kVYjtaWMrrD3siNSXzLmh.H5IIMl18UP4s4bBKFit.VZSTm7AhCjW' WHERE username='razhel' AND role='anggota';
UPDATE users SET password='$2y$10$Rsu5B0F6u5uZn8mCwwpM8OiS9lxejIO7o5tGlUVPw4NOycRh3QHR2' WHERE username='mutiah' AND role='anggota';
UPDATE users SET password='$2y$10$tUvlL6jLRGfIxAWWtMKmcumXHoUQJbGkY/889DoTon0yNN39BQErm' WHERE username='nadien' AND role='anggota';
UPDATE users SET password='$2y$10$GR/07rvFkZzRwdwqfpF61eESoYjWXVpvANDk9hWbf7U6hct2fGEm2' WHERE username='najwa' AND role='anggota';
UPDATE users SET password='$2y$10$EMqBI5ZxOAjTevrI9mRhG.SVvEPZAw/Xk3fqUUSptUpIEs7KLCs62' WHERE username='qeisa' AND role='anggota';
UPDATE users SET password='$2y$10$ykHqdqTvXEhwAIzb.ApAWe1XYowM8qevq0qduxt74KFKg3S6.tLXW' WHERE username='raafi' AND role='anggota';
UPDATE users SET password='$2y$10$dwkaUXE5UhS0yKHJRbVNDeR4czmZC.ViallLllA3E5IyJbcixBNCq' WHERE username='rafifah' AND role='anggota';
UPDATE users SET password='$2y$10$DcuRhHS1k21gwFNZ39SvNu4dLSp8RRhG0m7tPhgt5NnJTXzgwbn8.' WHERE username='rafli' AND role='anggota';
UPDATE users SET password='$2y$10$xZSj0txjKFiUBvxzLA629e/CDuGb/IUo3w9pmQxKyarycm8DCnjsS' WHERE username='raisaha' AND role='anggota';
UPDATE users SET password='$2y$10$iGiAd1HSlkmJTx.brR18teM564JXeMqzN8.D1klWwqXJxfaqoapam' WHERE username='ravi' AND role='anggota';
UPDATE users SET password='$2y$10$ybULttCOgBpIcP1Zv5Ky/.tYyX644B7MKu7uygUk5Fagt5ftf1ZDK' WHERE username='reza' AND role='anggota';
UPDATE users SET password='$2y$10$vHUBHz3owPzXh6YNJO0HaOvlygTOl5MK0azNd5fYVULY50aOr3CTm' WHERE username='sulthan' AND role='anggota';
UPDATE users SET password='$2y$10$Hm35BC14G12PUJtDTIpkmOZIz3rfufZkA5wBpBRlmJMQTrRMnSySe' WHERE username='sutan' AND role='anggota';
UPDATE users SET password='$2y$10$wiU5FtHgbfABc0RyYNAL/.4Ics0Ni4mPmzMOoK2LWvpHCqfeHmL6a' WHERE username='zahra' AND role='anggota';
UPDATE users SET password='$2y$10$Ra6XafxlJ9hWQrst920i4.aW5FXnqmWXRlfWg/4v57E0r7X78pgTq' WHERE username='zhilan' AND role='anggota';
