import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'app_database.db'),
      version: 4, // Zwiększ wersję
      onCreate: (db, version) async {
        // Tworzenie tabel
        await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        full_name TEXT NOT NULL,
        username TEXT NOT NULL UNIQUE,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL
      )
      ''');

        await db.execute('''
CREATE TABLE notes(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  title TEXT,
  content TEXT NOT NULL,
  date TEXT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users (id)
)
''');


        // Dodanie domyślnego użytkownika (master)
        await db.insert(
          'users',
          {
            'full_name': 'Master User',
            'username': 'master',
            'email': 'master@example.com',
            'password': 'master1234',
          },
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 4) {
          await db.execute('ALTER TABLE notes ADD COLUMN date TEXT NOT NULL DEFAULT "";');
        }

      },
    );
  }


  // ----------------------------- Użytkownicy -----------------------------

  Future<int> insertUser(String fullName, String email, String password) async {
    final db = await database;
    return await db.insert(
      'users',
      {
        'full_name': fullName,
        'username': fullName,
        'email': email,
        'password': password,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getUser(
      String emailOrUsername, String password) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: '(email = ? OR username = ?) AND password = ?',
      whereArgs: [emailOrUsername, emailOrUsername, password],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<bool> emailExists(String email) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty;
  }

  // ----------------------------- Notatki -----------------------------

  Future<int> addNote({

    required int userId,
    String? title, // Tytuł opcjonalny
    required String content,
    required String date,
  }) async {
    final db = await database;
    print('Saving note for userId: $userId');

    return await db.insert(
      'notes',
      {
        'user_id': userId,
        'title': title,
        'content': content,
        'date': date,

      },
      conflictAlgorithm: ConflictAlgorithm.replace,


    );


  }




  Future<List<Map<String, dynamic>>> getNotes(int userId) async {
    final db = await database;
    return await db.query(
      'notes',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'date DESC',
    );
  }

  Future<int> updateNote({
    required int noteId,
    String? title,
    required String content,
    required String date,
  }) async {
    final db = await database;
    return await db.update(
      'notes',
      {
        'title': title,
        'content': content,
        'date': date, // Aktualizujemy datę
      },
      where: 'id = ?',
      whereArgs: [noteId],
    );
  }



  Future<int> deleteNote(int noteId) async {
    final db = await database;
    return await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [noteId],
    );
  }
}
