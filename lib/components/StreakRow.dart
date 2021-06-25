
//when button is clicked and data is submitted, data should create a streak object

import 'package:flutter/material.dart';
import 'package:streaksApp/components/StreakCard.dart';
import 'package:streaksApp/components/StreakButton.dart';
import 'package:toggle_switch/toggle_switch.dart';

//this should be a row which holds text for the number of days, a streakcard, and a button

class StreakRow extends StatelessWidget {

  StreakRow({this.id, this.length, this.name, this.start, this.col}){}
  int id; // id of the streak
  int length; // number of days they have continued the streak
  String name; // /name of the streak
  var start; // starting date of the streak
  int col; //take in as a number then turn into a color for display

  bool pressAttention = false;

  //the row initializes the card
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Color(col),
          child: Text(length.toString()),
        ),
        Text(
          name,
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
          activeFgColor: Colors.white,
          inactiveBgColor: Colors.grey,
          inactiveFgColor: Colors.white,
          totalSwitches: 2,
          icons: [Icons.clear_outlined, Icons.check],
          onToggle: (index) {
            print('switched to: $index');
          },
        )
      ],
    );

  }
}

//return Container(
//      child: Row(
//        children: <Widget>[
//          Padding(
//            padding: const EdgeInsets.all(3.0),
//            child: Text(length.toString(),
//            ),
//          ),//just testing the row widget. Still need to add button
//
//          Text(name),
//
//        ],
//      ),
//    );
