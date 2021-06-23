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

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.green,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.edit,
              color: Colors.white,
            ),
            Text(
              " Edit",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
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

        //final List<String> entries = <String>['A', 'B', 'C'];
        //final List<int> colorCodes = <int>[600, 500, 100];
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: streaks.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  child: Container(
                    child: streaks[index],
                  ),
                    //direction: DismissDirection.endToStart,
                    key: UniqueKey(),
                  onDismissed: (DismissDirection direction){
                    setState(() {
                      //database removes item, then reinitialized
                      handler.deleteStreak(streaks[index].name);
                      print(streaks[index].name);
                      initializeStreaks(6); //also needs to be in same place
                    });
                  },
                  secondaryBackground: slideLeftBackground(),
                  background: slideRightBackground(),

                );

              }
            ),
          )
        ],
      ),
    );
  }
}



