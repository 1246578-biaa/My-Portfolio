<?php
require 'config.php';

$seed = [
    ['Aplikasi Djawara Dawet', 'Flutter', '2025', 'Flutter, Dart, PHP, MySQL', 'Aplikasi pemesanan dawet digital untuk pelanggan (pesan, bayar, riwayat) sekaligus manajemen toko (stok, pesanan, dan laporan keuangan).', 0xFF2E7D32, 'assets/appdjawara.jpg'],
    ['UI/UX Djawara Dawet', 'Figma', '2025', 'Figma, Wireframing, Prototyping', 'Desain antarmuka aplikasi pemesanan dawet yang intuitif, modern, dan mempermudah alur belanja pengguna.', 0xFF6A1B9A, 'assets/desaindjawara.png'],
    ['Web Supplier Toko El-Fath', 'Laravel', '2024', 'Laravel, PHP, MySQL, Bootstrap', 'Sistem informasi berbasis web untuk pengelolaan pasokan barang, riwayat transaksi, dan manajemen vendor supplier.', 0xFF1565C0, 'assets/websiteel-fath.jpg'],
    ['Seventeen', 'Flutter', '2025', 'Flutter, Dart', 'Aplikasi mobile hasil pembelajaran Flutter.', 0xFF2E7D32, null],
    ['Kariera', 'Flutter', '2025', 'Flutter, Dart', 'Aplikasi mobile untuk pengembangan dan pengelolaan informasi karier.', 0xFF2E7D32, null],
];

$pdo->beginTransaction();
try {
    $pdo->exec('DELETE FROM projects');
    $stmt = $pdo->prepare('INSERT INTO projects (title, category, year, tech, description, color, image) VALUES (?, ?, ?, ?, ?, ?, ?)');
    foreach ($seed as $p) $stmt->execute($p);
    $pdo->commit();
    respond(true, 'Data berhasil direset.');
} catch (Throwable $e) {
    $pdo->rollBack();
    respond(false, 'Reset gagal: ' . $e->getMessage(), null, 500);
}
