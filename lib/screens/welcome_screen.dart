import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    final name = _nameController.text;
    if (name.isNotEmpty) {
      final db = await DatabaseHelper().database;

      await db.delete('user');
      await db.insert('user', {'name': name, 'email': '$name@gmail.com'});

      Navigator.pushReplacementNamed(context, '/home', arguments: {'userName': name});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', height: 500),
            const SizedBox(height: 32),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => _login(context),
              label: const Text('Iniciar'),
            ),
          ],
        ),
      ),
    );
  }
}
