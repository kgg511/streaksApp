
//when button is clicked and data is submitted, data should create a streak object

import 'dart:html';

import 'package:flutter/material.dart';


class streak extends StatelessWidget {

  streak({this.name, this.number}){}
  //Color color;
  int name; //name of the streak
  String number;//number of days they have continued the streak

  //it should return a row


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Text(number),//just testing the row widget. Still need to add button
          Text(name.toString()),

        ],
      ),
    );
  }
}
