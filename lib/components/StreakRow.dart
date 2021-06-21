
//when button is clicked and data is submitted, data should create a streak object

import 'package:flutter/material.dart';


class StreakRow extends StatelessWidget {

  StreakRow({this.length, this.name, this.start, this.col}){}
  int length; //number of days they have continued the streak
  String name; //name of the streak
  var start; // starting date of the streak
  int col; //take in as a number then turn into a color for display

  //it should return a row


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(length.toString(),
            ),
          ),//just testing the row widget. Still need to add button

          Text(name),

        ],
      ),
    );
  }
}
