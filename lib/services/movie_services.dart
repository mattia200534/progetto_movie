import 'package:movie/models/movie.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:sqflite/sqflite.dart';

class DBservice {
  static final DBservice _instance = DBservice._internal();

  factory DBservice() => _instance;
  DBservice._internal();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'movies.db');

    //apre o crea la connessione
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      '''CREATE TABLE movies( id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      duration INTEGER NOT NULL,
      plot TEXT NOT NULL,
      year INTEGER NOT NULL
      )''',
    );
  }

  Future<int> insertMovie(Movie movie) async {
    final db = await database;
    return await db.insert(
      'movies',
      movie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Movie>> getAllMovies() async {
    final db = await database;
    final result = await db.query('movies');
    return result.map((map) => Movie.fromMap(map)).toList();
  }

  Future<int> deleteMovie(int id) async {
    final db = await database;
    return await db.delete('movie', where: 'id= ?', whereArgs: [id]);
  }

  Future<int> updateMovie(Movie movie) async {
    final db = await database;
    return db.update(
      'movies',
      movie.toMap(),
      where: 'id=?',
      whereArgs: [movie.id],
    );
  }
}
