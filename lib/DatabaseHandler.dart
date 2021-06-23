import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:streaksApp/Streak.dart';
import 'package:flutter/widgets.dart';

class DatabaseHandler {
  //make singleton database class so that the database can only be made once
  static final DatabaseHandler _singleton = DatabaseHandler._internal();

  factory DatabaseHandler() {
    return _singleton;
  }
  DatabaseHandler._internal();


  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    print(path);
    return openDatabase(
      join(path, 'streaks2.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE streakTable(id INTEGER PRIMARY KEY, name TEXT, length INTEGER, start INTEGER, col INTEGER)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertStreak(List<Streak> streaks) async {
    int result = 0;
    final Database db = await initializeDB();

    for(var s in streaks){
      result = await db.insert('streakTable', s.toMap());
    }
    return result;
  }

  Future<List<Streak>> retrieveStreaks() async {
    final Database db = await initializeDB();
    final List<Map<String, Object>> queryResult = await db.query('streakTable');
    //return queryResult.map((e) => Streak.fromMap(e)).toList();

    return List.generate(queryResult.length, (i) {
      return Streak(
        length: queryResult[i]['length'],
        name: queryResult[i]['name'],
        start: queryResult[i]['start'],
        col: queryResult[i]['col'],
      );
    });
  }

  Future<void> deleteStreak(int id) async {
    final db = await initializeDB();
    await db.delete(
      'streaks',
      where: "name = ?",
      whereArgs: [id],
    );
  }


}
