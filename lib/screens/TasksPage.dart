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
  List<StreakRow> streaks = []; //reads the database to fill itself?
  DatabaseHandler handler; //database

  @override
  void initState() {
    super.initState();
    //where to initialize the database?!
    this.handler = DatabaseHandler();
    this.handler.initializeDB(); //create database
    WidgetsFlutterBinding.ensureInitialized();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MY HABITS'),
      ),
      body: Column(
        children: [//**in order to display a list within a list, I embedded the column within another column
          BottomButton(
            buttonTitle: 'Add Habit',
            onTap: () async {
              print("Grabbing streaks");
              List streakss = await handler.retrieveStreaks();
              print(streakss.length);
              for(int i = 0; i < streakss.length; i++) {
                print(streakss[i].toMap());
              }

              Navigator.pushNamed(context, AddHabitPage.id);
              //collects data
              setState(() {//just a test. The AddHabitPage is actually in charge of this
                streaks.add(StreakRow(name: "test", number: 6,));
                print('added');
              });
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



