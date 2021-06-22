import 'package:flutter/material.dart';
import 'package:streaksApp/constants.dart';


class IconContent extends StatelessWidget {
  IconContent({this.icon, this.color});

  final IconData icon;
  //final String label;
  Color color; //color of the icon itself


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          color: color,
          size: 80.0,
        ),
        SizedBox(
          height: 15.0,
        ),

      ],
    );
  }
}


