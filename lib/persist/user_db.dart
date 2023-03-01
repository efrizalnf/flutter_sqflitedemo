import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../module/users/model/users_dataclass.dart';

class UserDB {
  static late Database _db;
  static const String dbName = 'user.db';

  Future<Database> get db async {
    _db = await _initUserDB();
    return _db;
  }

  Future<Database> _initUserDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    return await openDatabase(
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
      path,
      onCreate: _onCreateDb,
    );
  }

  void _onCreateDb(Database db, int version) async {
    await db.execute(
      'CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
    );
  }

  Future<void> insertUser(Users user) async {
    final db = await _initUserDB();
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // await db.rawInsert('INSERT INTO cats(name, age) VALUES("Andri", 35)');
  }

  Future<List<Users>> users() async {
    final db = await _initUserDB();
    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('users');

    // Convert the List<Map<String, dynamic> into a List<Cat>.
    return List.generate(maps.length, (i) {
      return Users(
        id: maps[i]['id'],
        name: maps[i]['name'],
        age: maps[i]['age'],
      );
    });
  }

  Future<void> updateUser(Users user) async {
    final db = await _initUserDB();

    await db.update(
      'users',
      user.toMap(),
      // Ensure that the Cat has a matching id.
      where: 'id = ?',
      // Pass the Ca's id as a whereArg to prevent SQL injection.
      whereArgs: [user.id],
    );
  }

  Future<void> deleteUser(int id) async {
    final db = await _initUserDB();

    await db.delete(
      'users',
      // Use a `where` clause to delete a specific cat.
      where: 'id = ?',
      // Pass the Cat's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}
