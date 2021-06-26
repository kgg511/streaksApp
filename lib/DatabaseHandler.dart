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
      join(path, 'streaks4.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE streakTable(id INTEGER PRIMARY KEY, name TEXT, length INTEGER, start INTEGER, last_checked INTEGER, col INTEGER)",
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
        id: queryResult[i]['id'],
        length: queryResult[i]['length'],
        name: queryResult[i]['name'],
        start: queryResult[i]['start'],
        col: queryResult[i]['col'],
      );
    });
  }

  Future<List<Streak>> retrieveStreak(int id) async {
    final Database db = await initializeDB();
    final List<Map<String, Object>> queryResult = await db.query('streakTable', where: "id = ?", whereArgs: [id]);
    return List.generate(queryResult.length, (i) {
      return Streak(
        id: queryResult[i]['id'],
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
      'streakTable',
      where: "id = ?",
      whereArgs: [id],
    );
    print("Deleted");
  }

  Future<void> incrementStreak(int id, int curr) async {
    final db = await initializeDB();
    await db.rawUpdate('''
    UPDATE streakTable 
    SET length = case
                  when length + 1, 
    WHERE _id = ?
    ''', ['Susan', 13, 1]);
    await db.update(
      'streakTable',
      streak.toMap(),
      where: "id = ?",
      whereArgs: [id],
    );
  }


  /*
  set column_b = case
                  when column_a = 1 then 'Y'
                  else null
                 end,
  onpressed for each button

  1. get current date, calculate difference between curr and start
  2. if 1 more increment 1, if it is equal, decrease 1
  curr - start
 2 - 1 = 1

  1 1
  2
  3

  on pressed:





   */


}
