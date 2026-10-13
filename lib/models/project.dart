import 'package:flutter/material.dart';

class Project {
  final int? id;
  final String title;
  final String category;
  final String year;
  final String tech;
  final String desc;
  final int color;
  final String? image;

  const Project({
    this.id,
    required this.title,
    required this.category,
    required this.year,
    required this.tech,
    required this.desc,
    required this.color,
    this.image,
  });

  Color get colorValue => Color(color);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'year': year,
      'tech': tech,
      'description': desc,
      'color': color,
      'image': image,
    };
  }

  factory Project.fromMap(Map<String, dynamic> m) {
    final img = m['image']?.toString();

    return Project(
      id: int.tryParse(m['id'].toString()),
      title: m['title']?.toString() ?? '',
      category: m['category']?.toString() ?? '',
      year: m['year']?.toString() ?? '',
      tech: m['tech']?.toString() ?? '',
      desc: m['description']?.toString() ?? '',
      color: int.tryParse(m['color'].toString()) ?? 0xFF6C63FF,
      image: (img == null || img.isEmpty || img == 'null') ? null : img,
    );
  }
}

const kTechOptions = [
  'Flutter',
  'Laravel',
  'React',
  'Python',
  'Java',
  'PHP',
  'Figma',
];

const Map<String, int> kTechColors = {
  'Flutter': 0xFF2E7D32,
  'Laravel': 0xFF1565C0,
  'React': 0xFF00838F,
  'Python': 0xFFEF6C00,
  'Java': 0xFFC62828,
  'PHP': 0xFF4527A0,
  'Figma': 0xFF6A1B9A,
};

int colorForTech(String t) {
  return kTechColors[t] ?? 0xFF6C63FF;
}