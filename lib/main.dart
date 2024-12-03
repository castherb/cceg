import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/home_screen.dart';
import 'screens/course_detail_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/course_image_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CCEG App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/home': (context) => HomeScreen(userName: ''),
        '/profile': (context) => ProfileScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/courseDetail') {
          final arguments = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => CourseDetailScreen(
              id: arguments['id'],
              name: arguments['name'],
              description: arguments['description'],
              image: arguments['image'],
            ),
          );
        } else if (settings.name == '/courseImage') {
          final arguments = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => CourseImageScreen(image: arguments['image']),
          );
        }
        return null;
      },
    );
  }
}
