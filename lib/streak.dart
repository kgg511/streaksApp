
//when button is clicked and data is submitted, data should create a streak object

import 'package:flutter/material.dart';


class streak extends StatelessWidget {

  streak({this.name, this.number}){}
  //Color color;
  String name; //name of the streak
  int number;//number of days they have continued the streak

  //it should return a row


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(number.toString(),
            ),
          ),//just testing the row widget. Still need to add button

          Text(name),

        ],
      ),
    );
  }
}
