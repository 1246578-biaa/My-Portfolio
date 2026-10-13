<?php
require 'config.php';
$data = input_json();
$id = (int)($data['id'] ?? 0);
$title = trim($data['title'] ?? '');
$category = trim($data['category'] ?? '');
$year = trim($data['year'] ?? '');
$tech = trim($data['tech'] ?? '');
$description = trim($data['description'] ?? '');
$color = (int)($data['color'] ?? 0xFF6C63FF);
$image = $data['image'] ?? null;

if ($id <= 0 || $title === '' || $category === '' || $year === '' || $tech === '' || $description === '') {
    respond(false, 'Data tidak lengkap.', null, 422);
}

$stmt = $pdo->prepare('UPDATE projects SET title=?, category=?, year=?, tech=?, description=?, color=?, image=? WHERE id=?');
$stmt->execute([$title, $category, $year, $tech, $description, $color, $image, $id]);
respond(true, 'Karya berhasil diperbarui.', ['id' => $id]);
