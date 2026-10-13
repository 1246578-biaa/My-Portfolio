<?php
require 'config.php';
$id = (int)($_GET['id'] ?? 0);
if ($id <= 0) respond(false, 'ID tidak valid.', null, 422);

$stmt = $pdo->prepare('DELETE FROM projects WHERE id=?');
$stmt->execute([$id]);
respond(true, 'Karya berhasil dihapus.', ['id' => $id]);
