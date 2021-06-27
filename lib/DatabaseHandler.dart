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

  Future<void> updateStreak(int id, int curr, int index) async { // index is the button clicked (x or check)
    final db = await initializeDB();
    await db.rawUpdate('''UPDATE streakTable 
    SET length = CASE
    WHEN ? - start + 86400000 = length*86400000 AND ? = 0 THEN length - 1
    WHEN ? - start - length = 0 AND ? = 1 THEN length + 1
    ELSE length
    END
    WHERE id = ?
    ''', [curr, index, curr, index, id]);
  }


  /*
  if (curr - start + 1) == length and index == 0(they have already checked that day and they click red): length -= 1
  else if (curr - start + 1) - length = 1 and index == 1 (they have not checked that day and they clicked green): length += 1

   */

  //for editing streaks
  Future<void> updateName(String n, int color, int id) async {//update name and color
    //get st
    final db = await initializeDB();
    await db.rawUpdate('''UPDATE streakTable 
    SET name = ?, col = ? 
    WHERE id = ?
    ''', [n, color, id]);
    print("Edit completed");
  }

}

