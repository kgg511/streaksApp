import 'package:flutter/material.dart';
import 'package:streaksApp/constants.dart';

class BottomButton extends StatelessWidget {
  BottomButton({@required this.onTap, @required this.buttonTitle});

  final Function onTap;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(

        child: Center(
          child: Text(
            buttonTitle,
            style: kLargeButtonTextStyle,
          ),
        ),

        margin: EdgeInsets.only(top: 10.0),
        padding: EdgeInsets.only(bottom: 10.0),
        width: 200.0,
        height: 70,
        decoration: new BoxDecoration(
          color: Colors.grey,
          //shape: BoxShape.circle,
          borderRadius: new BorderRadius.all(Radius.elliptical(100, 30)),
          //border: Border.all(width: 5.0, color: Colors.white),
        ),

      ),
    );
  }
}
