import 'dart:async';

import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblWatchlist = 'watchlist';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    var db = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tblWatchlist (
        id INTEGER,
        title TEXT,
        overview TEXT,
        posterPath TEXT,
        type TEXT,
        PRIMARY KEY (id, type)
      );
    ''');
  }

  /// Insert watchlist item (movie / tv)
  Future<int> insertWatchlist(Map<String, dynamic> item) async {
    final db = await database;
    return await db!.insert(_tblWatchlist, item);
  }

  /// Remove watchlist item (by id & type)
  Future<int> removeWatchlist(int id, String type) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlist,
      where: 'id = ? AND type = ?',
      whereArgs: [id, type],
    );
  }

  /// Get watchlist item by id & type
  Future<Map<String, dynamic>?> getItemById(int id, String type) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlist,
      where: 'id = ? AND type = ?',
      whereArgs: [id, type],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  /// Get all watchlist items (movie + tv)
  Future<List<Map<String, dynamic>>> getWatchlist() async {
    final db = await database;
    return await db!.query(_tblWatchlist);
  }

  /// Get only watchlist items by type
  Future<List<Map<String, dynamic>>> getWatchlistByType(String type) async {
    final db = await database;
    return await db!.query(
      _tblWatchlist,
      where: 'type = ?',
      whereArgs: [type],
    );
  }
}
