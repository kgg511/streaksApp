import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:streaksApp/Streak.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'example.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE streakTable(length INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, start INTEGER NOT NULL, color TEXT NOT NULL)",
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
    return queryResult.map((e) => Streak.fromMap(e)).toList();
  }

}
