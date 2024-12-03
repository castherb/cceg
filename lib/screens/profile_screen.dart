import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import 'course_image_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? user;
  List<Map<String, dynamic>> takenCourses = [];

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final db = await DatabaseHelper().database;
    final userData = await db.query('user');
    final courses = await db.query('courses', where: 'isTaken = ?', whereArgs: [1]);

    setState(() {
      user = userData.isNotEmpty ? userData.first : null;
      takenCourses = courses;
    });
  }

  Future<void> _removeCourse(int courseId) async {
    final db = await DatabaseHelper().database;
    // Actualizar el curso a "no tomado"
    await db.update('courses', {'isTaken': 0}, where: 'id = ?', whereArgs: [courseId]);

    // Volver a cargar los cursos
    _loadProfileData();
  }

  int _currentIndex = 1;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (index == 0) {
        Navigator.pushNamed(context, '/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.person, size: 50), 
                  title: Text(user!['name']),
                  subtitle: Text(user!['email']),
                ),
                const Divider(),
                const Text('Cursos Tomados', style: TextStyle(fontSize: 18)),
                Expanded(
                  child: ListView.builder(
                    itemCount: takenCourses.length,
                    itemBuilder: (context, index) {
                      final course = takenCourses[index];
                      return ListTile(
                        title: Text(course['name']),
                        leading: Image.asset(course['image'], width: 50),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle, color: Colors.red),
                          onPressed: () => _removeCourse(course['id']),
                        ),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CourseImageScreen(image: course['image']),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home), 
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person), 
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
