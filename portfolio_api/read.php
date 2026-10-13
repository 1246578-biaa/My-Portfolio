<?php
require 'config.php';
$stmt = $pdo->query('SELECT id, title, category, year, tech, description, color, image FROM projects ORDER BY id ASC');
respond(true, '', $stmt->fetchAll(PDO::FETCH_ASSOC));
