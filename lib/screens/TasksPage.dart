import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:streaksApp/components/icon_content.dart';
import 'package:streaksApp/components/reusable_card.dart';
import 'package:streaksApp/constants.dart';
import 'package:streaksApp/screens/results_page.dart';
import 'package:streaksApp/components/bottom_button.dart';
import 'package:streaksApp/components/round_icon_button.dart';
import 'package:streaksApp/calculator_brain.dart';
import 'package:streaksApp/streak.dart';


class TasksPage extends StatefulWidget {
  @override
  static const String id = 'TasksPage';
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  List<streak> streaks = [];

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
            onTap: () {
              //collects data
              setState(() {
                streaks.add(streak(name: , number: ,));
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



//<Widget>[
//
//          BottomButton(
//            buttonTitle: 'Add Habit',
//            onTap: () {
//              //navigator.push
//              //collects data
//              setState(() {
//                streaks.add(streak(name: , number: ,));
//              });
//            },
//          ),
//        ],