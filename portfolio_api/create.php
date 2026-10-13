<?php
require 'config.php';
$data = input_json();

$title = trim($data['title'] ?? '');
$category = trim($data['category'] ?? '');
$year = trim($data['year'] ?? '');
$tech = trim($data['tech'] ?? '');
$description = trim($data['description'] ?? '');
$color = (int)($data['color'] ?? 0xFF6C63FF);
$image = $data['image'] ?? null;

if ($title === '' || $category === '' || $year === '' || $tech === '' || $description === '') {
    respond(false, 'Data wajib belum lengkap.', null, 422);
}

$stmt = $pdo->prepare('INSERT INTO projects (title, category, year, tech, description, color, image) VALUES (?, ?, ?, ?, ?, ?, ?)');
$stmt->execute([$title, $category, $year, $tech, $description, $color, $image]);
respond(true, 'Karya berhasil ditambahkan.', ['id' => (int)$pdo->lastInsertId()]);
