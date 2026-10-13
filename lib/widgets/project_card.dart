import 'package:flutter/material.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final String year;
  final String tech;
  final String desc;
  final Color color;

  const ProjectCard({
    super.key,
    required this.title,
    required this.year,
    required this.tech,
    required this.desc,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 170,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.phone_android,
                color: Colors.white,
                size: 80,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.calendar_month, size: 18),
                    const SizedBox(width: 6),
                    Text(year),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.layers, size: 18),
                    const SizedBox(width: 6),
                    Expanded(child: Text(tech)),
                  ],
                ),
                const SizedBox(height: 12),
                Text(desc),
              ],
            ),
          )
        ],
      ),
    );
  }
}