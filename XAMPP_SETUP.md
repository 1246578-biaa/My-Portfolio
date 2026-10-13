# Setup XAMPP + MySQL untuk My Portfolio

## 1. Jalankan XAMPP
Nyalakan:
- Apache
- MySQL

## 2. Pasang API
Salin folder `xampp/portfolio_api` ke:

`C:\xampp\htdocs\portfolio_api`

Hasilnya harus seperti:

`C:\xampp\htdocs\portfolio_api\config.php`

## 3. Buat database
Buka `http://localhost/phpmyadmin` lalu pilih **Import** dan masukkan file:

`xampp/portfolio_api/database.sql`

Database yang dibuat:

`portfolio_mahasiswa`

Tabel:

`projects`

## 4. Cek API dari browser
Buka:

`http://localhost/portfolio_api/read.php`

Jika berhasil, akan muncul JSON berisi data 5 karya.

## 5. Jalankan Flutter
Di terminal project:

```bash
flutter pub get
flutter run
```

### Android Emulator
Project sudah diarahkan ke:

`http://10.0.2.2/portfolio_api`

Jangan diganti jika memakai Android Emulator standar.

### HP Android fisik
HP dan laptop harus berada pada Wi-Fi yang sama. Cari IPv4 laptop dengan:

```bash
ipconfig
```

Lalu buka:

`lib/database/db_helper.dart`

Ganti:

```dart
static const String _androidBaseUrl = 'http://10.0.2.2/portfolio_api';
```

menjadi contoh:

```dart
static const String _androidBaseUrl = 'http://192.168.1.10/portfolio_api';
```

Gunakan IPv4 laptop kamu, bukan contoh tersebut.

## CRUD yang tersedia
- `GET read.php` → menampilkan karya
- `POST create.php` → tambah karya
- `PUT update.php` → edit karya
- `DELETE delete.php?id=...` → hapus karya
- `POST reset.php` → reset ke 5 data awal

## Catatan gambar
Database hanya menyimpan nama/path gambar. Gambar tetap berasal dari folder Flutter `assets/`.

## Jika muncul "Connection refused"
Pastikan Apache dan MySQL XAMPP menyala. Untuk emulator Android gunakan `10.0.2.2`, bukan `localhost`.
