import 'package:flutter/material.dart';

class CourseImageScreen extends StatelessWidget {
  final String image;

  const CourseImageScreen({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vista del Curso')),
      body: Center(
        child: Image.asset(image, fit: BoxFit.contain),
      ),
    );
  }
}
