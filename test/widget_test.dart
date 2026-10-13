import 'package:flutter_test/flutter_test.dart';
import 'package:my_portofolio/models/project.dart';

// Unit test sederhana untuk model Project (tanpa database/perangkat).
void main() {
  const sample = Project(
    id: 1,
    title: 'Contoh Karya',
    category: 'Flutter',
    year: '2025',
    tech: 'Flutter, Dart',
    desc: 'Deskripsi contoh',
    color: 0xFF2E7D32,
    image: 'assets/appdjawara.jpg',
  );

  test('toMap lalu fromMap menghasilkan data yang sama', () {
    final hasil = Project.fromMap(sample.toMap());
    expect(hasil.id, sample.id);
    expect(hasil.title, sample.title);
    expect(hasil.category, sample.category);
    expect(hasil.year, sample.year);
    expect(hasil.tech, sample.tech);
    expect(hasil.desc, sample.desc);
    expect(hasil.color, sample.color);
    expect(hasil.image, sample.image);
  });

  test('kolom deskripsi disimpan dengan nama "description"', () {
    expect(sample.toMap().containsKey('description'), isTrue);
  });

  test('colorForTech memberi warna default untuk teknologi tak dikenal', () {
    expect(colorForTech('Flutter'), 0xFF2E7D32);
    expect(colorForTech('Rust'), 0xFF6C63FF);
  });

  test('semua gambar sampul yang dipilih berada di folder assets', () {
    for (final path in kImageOptions.values.where((v) => v.isNotEmpty)) {
      expect(path.startsWith('assets/'), isTrue);
    }
  });
}
