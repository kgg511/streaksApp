import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:streaksApp/Streak.dart';
import 'package:flutter/widgets.dart';

class DatabaseHandler {
  //make singleton database class so that the database can only be made once

  //holds the name of the database?
  static final DatabaseHandler _singleton = DatabaseHandler._internal();

  factory DatabaseHandler() {
    return _singleton;
  }
  DatabaseHandler._internal();

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    print(path);
    return openDatabase(
      join(path, 'streaks9.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE streakTable(id INTEGER PRIMARY KEY, name TEXT, length INTEGER, start INTEGER, col INTEGER)",
        );
        await database.execute(//id, name & the date it was checked. Name not included in case name changed
          "CREATE TABLE dateTable(streakId INTEGER, date INTEGER)",
        );

      },
      version: 1,
    );
  }

  Future<bool> insertStreak(List<Streak> streaks) async {
    //changed to void since doesn't return anything if repeated name
    //returns true if the streak was inserted successfully else false

    int result = 0;
    final Database db = await initializeDB();

    //check if item already in database
    bool repetition = await repeatedName(streaks[0].name);
    if (repetition) {
      print("REPEATED");
      return false;
    } else {
      //if not already there, add item & return true
      for (var s in streaks) {
        result = await db.insert('streakTable', s.toMap());
      }
      return true;
    }
  }

  Future<List<Streak>> retrieveStreaks() async {
    final Database db = await initializeDB();
    final List<Map<String, Object>> queryResult = await db.query('streakTable');

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

  Future<Streak> retrieveStreak(int id) async {
    //returns a streak based on its ID
    final Database db = await initializeDB();
    final List<Map<String, Object>> queryResult =
        await db.query('streakTable', where: "id = ?", whereArgs: [id]);
      return Streak(
        id: queryResult[0]['id'],
        length: queryResult[0]['length'],
        name: queryResult[0]['name'],
        start: queryResult[0]['start'],
        col: queryResult[0]['col'],
      );

  }

  //////////don't use
  Future<List<Streak>> retrieveStreakN(int id) async {
    //returns a streak based on its NAME
    final Database db = await initializeDB();
    final List<Map<String, Object>> queryResult =
        await db.query('streakTable', where: "name = ?", whereArgs: [id]);

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
  ///////////////////


  Future<bool> repeatedName(String name) async {
    final Database db = await initializeDB();
    final List<Map<String, Object>> queryResult =
    await db.query('streakTable', where: "name = ?", whereArgs: [name]);
    if (queryResult.length != 0 || name == "") {
      print("Item already exists or is empty");
      return true;
    }
    return false;
  }

  Future<void> deleteStreak(int id) async {
    final db = await initializeDB();
    await db.delete(
      'streakTable',
      where: "id = ?",
      whereArgs: [id],
    );

    await db.delete(//deletes all columns associated with a given streak
      'dateTable',
      where: "id = ?",
      whereArgs: [id],
    );
    print("Deleted");
  }

  //increments the length when the streak is checked
  Future<void> updateStreak(int id, int curr, int index) async {
    // index is the button clicked (x or check)
    final db = await initializeDB();
    Streak b = await retrieveStreak(id);
    int maxLength = curr - b.start + 86400000;
    if(maxLength == b.length*86400000 && index == 0){//if you unchecked it --> remove
      await db.rawUpdate('''UPDATE streakTable 
    SET length = length - 1
    WHERE id = ?
    ''', [id]);

      await db.delete(
        'dateTable',
        where: "date = ? and streakId = ?",
        whereArgs: [curr, id],
      );
    }

    else if(curr - b.start - (b.length*86400000) == 0 && index == 1){//if you just checked it
      //increase length
      await db.rawUpdate('''UPDATE streakTable 
    SET length = length + 1
    WHERE id = ?
    ''', [id]);


      //add to table
      Map<String, dynamic> row = {//
        'streakId': id.toString(),
        'date' : curr.toString(),
      };
      //(id INTEGER PRIMARY KEY, date INTEGER)
      //add the date to the table. id,
      int result = await db.insert('dateTable', row);


    }



  }

  /*
  if (curr - start + 1) == length and index == 0(they have already checked that day and they click red): length -= 1
  else if (curr - start + 1) - length = 1 and index == 1 (they have not checked that day and they clicked green): length += 1
   */

  Future<void> expiresStreaks(int curr) async {
    final db = await initializeDB();
    await db.rawUpdate('''UPDATE streakTable 
    Set length = 0,
    start = ?
    WHERE ? - start + 86400000 - length*86400000 >= 172800000
    ''', [curr, curr]);
  }

/*
if (curr - start + 1) aka max len - length >= 2: reset length to zero and start to curr



refresh: for all streaks
1. get current date, calculate difference between curr and start + 1
2.  if it is 2 more than length, reset length to 0 and start to curr
3.


 */

  Future<void> changeStart(String name) async {
    final db = await initializeDB();
    await db.rawUpdate('''UPDATE streakTable 
    Set start = start - 86400000,
    WHERE name = ?
    ''', [name]);
  }

  //to edit a streak
  Future<bool> updateName(String n, int color, int id) async {
    //update name and color
    final db = await initializeDB();
    bool repeated = await repeatedName(n);

    //if suggested name is new, make change & return true
    if (!repeated) {
      await db.rawUpdate('''UPDATE streakTable 
    SET name = ?, col = ? 
    WHERE id = ?
    ''', [n, color, id]);
      print("Edit completed");
      return true;
    } else {
      //name already exists, return false, which will then trigger an error message
      return false;
    }
  }

  /////////////////////////methods for datetable

  //method to add one date for one streak: If they check box


  //method to delete one date for one streak: if they uncheck box


  //method to delete all dates for one streak: If the streak is deleted entirely





}
