
//when button is clicked and data is submitted, data should create a streak object

import 'package:flutter/material.dart';
import 'package:streaksApp/components/StreakCard.dart';
import 'package:streaksApp/components/StreakButton.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:streaksApp/DatabaseHandler.dart';
import 'package:streaksApp/Streak.dart';

//this should be a row which holds text for the number of days, a streakcard, and a button

class StreakRow extends StatefulWidget {

  StreakRow({this.id, this.length, this.name, this.start, this.col}){}
  int id; // id of the streak
  int length; // number of days they have continued the streak
  String name; // /name of the streak
  var start; // starting date of the streak
  int col;

  @override
  _StreakRowState createState() => _StreakRowState();
}

class _StreakRowState extends State<StreakRow> {
  DatabaseHandler handler; //database

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.handler = DatabaseHandler();
    this.handler.initializeDB(); //create database
  }
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Color(widget.col),
          child: Text(widget.length.toString()),
        ),
        Text(
          widget.name,
          textAlign: TextAlign.center,
          style: TextStyle(
            //color: Color(0xFF24D876),
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        ToggleSwitch(
          minWidth: 60.0,
          cornerRadius: 15.0,
          activeBgColors: [[Colors.red], [Colors.green]],
          //activeFgColor: Colors.white,
          inactiveBgColor: Colors.grey,
          //inactiveFgColor: Colors.white,
          initialLabelIndex: 0 if
          totalSwitches: 2,
          icons: [Icons.clear_outlined, Icons.check],
          onToggle: (index) async {
            print('switched to: $index');
            DateTime a = DateTime.now();
            int curr_day = (new DateTime(a.year, a.month, a.day, 0, 0, 0, 0, 0)).millisecondsSinceEpoch;
            handler.updateStreak(widget.id, curr_day, index);
            List ab = await handler.retrieveStreak(widget.id);
            widget.length = ab[0].length;
            print(ab[0].toMap());
          },
        )
      ],
    );

  }
}
