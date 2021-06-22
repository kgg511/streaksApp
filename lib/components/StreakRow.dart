
//when button is clicked and data is submitted, data should create a streak object

import 'package:flutter/material.dart';
import 'package:streaksApp/components/StreakCard.dart';
import 'package:streaksApp/components/StreakButton.dart';

//this should be a row which holds text for the number of days, a streakcard, and a button

class StreakRow extends StatelessWidget {

  StreakRow({this.length, this.name, this.start, this.col}){}
  int length; //number of days they have continued the streak
  String name; //name of the streak
  var start; // starting date of the streak
  int col; //take in as a number then turn into a color for display
  //what it should take in a streak widget...well it's as if a streak obj
  //it should return a row


  //StreakCard card;


  //the row initializes the card
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(length.toString()),
         Expanded(//widget stating the habit
             child: StreakCard(
              cardChild: Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  //color: Color(0xFF24D876),
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
         ),
        Expanded(child: StreakButton()),

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
