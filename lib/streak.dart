
//when button is clicked and data is submitted, data should create a streak object

import 'package:flutter/material.dart';


class streak extends StatelessWidget {

  streak({this.name, this.number}){}
  //Color color;
  String name; //name of the streak
  String number;//number of days they have continued the streak

  //it should return a row
  //the instance variables should be displayed within widgets. Use methods
  //text, text, button to continue streak

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Text(number),
          Text(name),
        ],
      ),
    );
  }
}
