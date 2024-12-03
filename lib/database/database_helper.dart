import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'app_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Crear tabla de usuarios
    await db.execute('''
      CREATE TABLE user (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL
      )
    ''');

    // Crear tabla de cursos
    await db.execute('''
      CREATE TABLE courses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        image TEXT NOT NULL,
        isTaken INTEGER DEFAULT 0
      )
    ''');

    // Insertar cursos de ejemplo con imágenes PNG
    await db.insert('courses', {
      'name': 'Introducción a Flutter',
      'description': 'Aprende a crear aplicaciones móviles con Flutter desde cero.',
      'image': 'assets/images/flutter_course.png',
    });
    await db.insert('courses', {
      'name': 'Programación en Python',
      'description': 'Domina los fundamentos del lenguaje de programación Python.',
      'image': 'assets/images/python_course.png',
    });
    await db.insert('courses', {
      'name': 'Desarrollo Web con JavaScript',
      'description': 'Crea sitios web interactivos utilizando JavaScript y frameworks.',
      'image': 'assets/images/javascript_course.png',
    });
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Implementa cambios en la estructura de la base de datos aquí si es necesario
  }

  Future<void> debugDatabase() async {
    // Imprimir datos de usuario
    final users = await _database!.query('user');
    print('Usuarios en la base de datos: $users');

    // Imprimir datos de cursos
    final courses = await _database!.query('courses');
    print('Cursos en la base de datos: $courses');
  }
}
