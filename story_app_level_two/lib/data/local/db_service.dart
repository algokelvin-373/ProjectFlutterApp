import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../model/restaurant.dart';

class DbService {
  static const String _databaseName = 'restaurant-app.db';
  static const String _tableName = 'restaurant';
  static const int _version = 4;

  Future<void> createTables(Database database) async {
    await database.execute(
      """CREATE TABLE $_tableName(
       id TEXT PRIMARY KEY,
       name TEXT,
       description TEXT,
       pictureId TEXT,
       city TEXT,
       rating REAL
     )
     """,
    );
  }

  Future<Database> _initializeDb() async {
    return openDatabase(
      _databaseName,
      version: _version,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }

  Future<int> insertRestaurantFavorite(Restaurant restaurant) async {
    if (kDebugMode) {
      print("Masuk insert data...");
    }
    final db = await _initializeDb();

    final data = restaurant.toJson();
    final id = await db.insert(
      _tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    if (kDebugMode) {
      print("Dapat data $id ...");
    }
    return id;
  }

  Future<List<Restaurant>> getAllItems() async {
    if (kDebugMode) {
      print("Masuk get all data...");
    }
    final db = await _initializeDb();
    final results = await db.query(_tableName);

    if (kDebugMode) {
      print(results);
    }

    return results.map((result) => Restaurant.fromJson(result)).toList();
  }

  Future<Restaurant> getItemById(String id) async {
    final db = await _initializeDb();
    final results =
        await db.query(_tableName, where: "id = ?", whereArgs: [id], limit: 1);

    return results.map((result) => Restaurant.fromJson(result)).first;
  }

  Future<int> removeItem(String id) async {
    final db = await _initializeDb();

    final result =
        await db.delete(_tableName, where: "id = ?", whereArgs: [id]);
    return result;
  }
}
