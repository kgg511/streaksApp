import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:streaksApp/components/icon_content.dart';
import 'package:streaksApp/components/reusable_card.dart';
import 'package:streaksApp/constants.dart';
import 'package:streaksApp/screens/AddHabitPage.dart';
import 'package:streaksApp/screens/results_page.dart';
import 'package:streaksApp/components/bottom_button.dart';
import 'package:streaksApp/components/round_icon_button.dart';
import 'package:streaksApp/calculator_brain.dart';
import 'package:streaksApp/components/StreakRow.dart';
import 'package:streaksApp/DatabaseHandler.dart';
import 'package:streaksApp/Streak.dart';
import 'package:flutter/widgets.dart';

class TasksPage extends StatefulWidget {
  @override
  static const String id = 'TasksPage';
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  List<StreakRow> streaks=[]; //reads the database to fill itself?
  DatabaseHandler handler; //database

  @override
  void initState() {
    super.initState();
    this.handler = DatabaseHandler();
    this.handler.initializeDB(); //create database
    initializeStreaks(6); //Gets streaks from database and puts them in the streaks list to be displayed
    //it wanted a 'dynamic' value

    WidgetsFlutterBinding.ensureInitialized();
  }



  //fetches the streaks from the database and sets the variable streaks to the result
  FutureOr initializeStreaks(dynamic value) async {
    List<StreakRow> s = [];
    for (Streak a in await handler.retrieveStreaks()){
      s.add(StreakRow(length: a.length, name: a.name, start: a.start, col: a.col));
    }
    setState(() {
      streaks = s;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MY HABITS'),
      ),
      body: Column(
        children: [//in order to display a list within a list, I embedded the column within another column
          BottomButton(
            buttonTitle: 'Add Habit',
            onTap: () async {
              print("Grabbing streaks");
              List streakss = await handler.retrieveStreaks();
              print(streakss.length);
              for(int i = 0; i < streakss.length; i++) {
                print(streakss[i].toMap());
              }

              Navigator.pushNamed(context, AddHabitPage.id).then(initializeStreaks);
              //https://www.nstack.in/blog/flutter-refresh-on-navigator-pop-or-go-back/

            },
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: streaks, //the list of streak objects, each of which returns a row
          ),
        ],
      ),
    );
  }
}



