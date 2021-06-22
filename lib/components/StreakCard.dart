import 'dart:ui';

import 'package:flutter/material.dart';

//UI design for square that says the name of the habit


class StreakCard extends StatelessWidget {
  StreakCard({this.color, this.cardChild, this.onPress, this.name});
  //
  final Color color; //turn color back into int? Has this been done yet?
  final Widget cardChild;
  final Function onPress;
  final String name; //I guess this needs part of the streak......
  //initializing a streakrow should then help initialize the streakcard

  @override
  Widget build(BuildContext context) {
    return Container(
      child: cardChild,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey,
        //borderRadius: BorderRadius.circular(10.0),
      ),
    );

  }
}


//GestureDetector(
//      onTap: onPress,
//      child: Container(
//        child: cardChild,
//        margin: EdgeInsets.all(15.0),
//        decoration: BoxDecoration(
//          color: color,
//          borderRadius: BorderRadius.circular(10.0),
//        ),
//      ),
//    );