
//when button is clicked and data is submitted, data should create a streak object

import 'package:flutter/material.dart';
import 'package:streaksApp/components/StreakCard.dart';
import 'package:streaksApp/components/StreakButton.dart';
import 'package:streaksApp/screens/CalendarPage.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:streaksApp/DatabaseHandler.dart';
import 'package:streaksApp/Streak.dart';
import 'package:streaksApp/main.dart';

//this should be a row which holds text for the number of days, a streakcard, and a button

//now, it holds a database as well
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
  DatabaseHandler handler; //database holding the streaks
  int checked;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.handler = DatabaseHandler();
    this.handler.initializeDB(); //create streak database

    DateTime d = DateTime.now();
    int curr = (new DateTime(d.year, d.month, d.day, 0, 0, 0, 0, 0)).millisecondsSinceEpoch;
    if (curr - widget.start + 86400000 == widget.length*86400000){this.checked = 1;}
    //if the length of the streak is already the max it could be, then it should have green check
    else{this.checked = 0;} //else it should be unchecked
  }
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        /*CircleAvatar(
            backgroundColor: Color(widget.col),
            child: Text(widget.length.toString(), style: TextStyle(color: Colors.black),),
        ), */

        MaterialButton(
          onPressed: () {
            //navigate to the calendar page
            Navigator.pushNamed(context, CalendarPage.id);
          },
          color: Color(widget.col),
          textColor: Colors.white,
          child: Text(widget.length.toString(), style: TextStyle(color: Colors.black),),
          padding: EdgeInsets.all(16),
          shape: CircleBorder(),
        ),

        Flexible(
          child: Text(
            widget.name,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              //color: Color(0xFF24D876),
              color: Colors.black,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ToggleSwitch(
            minWidth: 60.0,
            cornerRadius: 15.0,
            activeBgColors: [[Colors.red], [Colors.green]],
            //activeFgColor: Colors.white,
            //inactiveFgColor: Colors.white,
            inactiveBgColor: Colors.grey,
            initialLabelIndex: checked,
            totalSwitches: 2,
            icons: [Icons.clear_outlined, Icons.check],
            onToggle: (index) async {
              print('switched to: $index');
              DateTime a = DateTime.now();
              int curr_day = (new DateTime(a.year, a.month, a.day, 0, 0, 0, 0, 0)).millisecondsSinceEpoch;
              print(curr_day);
              handler.updateStreak(widget.id, curr_day, index);

              Streak ab = await handler.retrieveStreak(widget.id);
              print(ab.toMap());
              setState(() {
                widget.length = ab.length;
                DateTime d = DateTime.now();
                int curr = (new DateTime(d.year, d.month, d.day, 0, 0, 0, 0, 0)).millisecondsSinceEpoch;
                if (curr - widget.start + 86400000 == widget.length*86400000){this.checked = 1;}
                else{this.checked = 0;}
              });
            },
          ),
      ],
    );

  }
}
