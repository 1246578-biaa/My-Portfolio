<?php

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');

$uploadDir = __DIR__ . '/uploads/';

if (!is_dir($uploadDir)) {
    mkdir($uploadDir, 0777, true);
}

if (!isset($_FILES['image'])) {
    echo json_encode([
        'success' => false,
        'message' => 'Tidak ada gambar yang dikirim.'
    ]);
    exit;
}

$file = $_FILES['image'];

if ($file['error'] !== UPLOAD_ERR_OK) {
    echo json_encode([
        'success' => false,
        'message' => 'Upload gambar gagal.'
    ]);
    exit;
}

$allowedExtensions = [
    'jpg',
    'jpeg',
    'png',
    'webp'
];

$extension = strtolower(
    pathinfo(
        $file['name'],
        PATHINFO_EXTENSION
    )
);

if (!in_array(
    $extension,
    $allowedExtensions
)) {
    echo json_encode([
        'success' => false,
        'message' =>
            'Format gambar harus JPG, JPEG, PNG, atau WEBP.'
    ]);
    exit;
}

if ($file['size'] > 5 * 1024 * 1024) {
    echo json_encode([
        'success' => false,
        'message' =>
            'Ukuran gambar maksimal 5 MB.'
    ]);
    exit;
}

$fileName =
    'project_' .
    time() .
    '_' .
    uniqid() .
    '.' .
    $extension;

$target =
    $uploadDir .
    $fileName;

if (!move_uploaded_file(
    $file['tmp_name'],
    $target
)) {
    echo json_encode([
        'success' => false,
        'message' =>
            'Gagal menyimpan gambar.'
    ]);
    exit;
}

$imagePath =
    'uploads/' . $fileName;

echo json_encode([
    'success' => true,
    'message' =>
        'Gambar berhasil diupload.',
    'image' => $imagePath
]);