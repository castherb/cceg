import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class CourseDetailScreen extends StatelessWidget {
  final int id;
  final String name;
  final String description;
  final String image;

  const CourseDetailScreen({
    Key? key,
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  }) : super(key: key);

  Future<void> _takeCourse(BuildContext context) async {
    final db = await DatabaseHelper().database;

    // Marcar el curso como tomado
    await db.update(
      'courses',
      {'isTaken': 1},
      where: 'id = ?',
      whereArgs: [id],
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Has tomado el curso: $name')),
    );

    Navigator.pop(context); // Volver al Home
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [
          IconButton(
            icon: const Icon(Icons.home), // Icono Home
            onPressed: () => Navigator.pushNamed(context, '/home'),
          ),
          IconButton(
            icon: const Icon(Icons.person), // Icono Perfil
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(image, fit: BoxFit.cover, height: 200, width: double.infinity),
            const SizedBox(height: 16),
            Text(
              name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(description, style: const TextStyle(fontSize: 16)),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () => _takeCourse(context),
              label: const Text('Tomar Curso'),
              icon: const Icon(Icons.play_arrow), // Icono de "Reproducir" o "Tomar Curso"
            ),
          ],
        ),
      ),
    );
  }
}
