
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:streaksApp/components/StreakCard.dart';
import 'package:streaksApp/components/icon_content.dart';

//streakCard holds card where we input the icon

class StreakButton extends StatelessWidget {

  //Color kActiveCardColor = Color(0xFF1D1E33);
  //Color kInactiveCardColor = Color(0xFF111328);

  Color kUnpressedColor = Colors.yellowAccent.withOpacity(.2);
  Color kPressedButtonColor = Colors.yellowAccent;

  Color color;


  Widget build(BuildContext context) {
    return GestureDetector(

      child: Container(
        child: StreakCard(
          cardChild: IconContent(
            color: kUnpressedColor,
            icon: Icons.flash_on,
          ),
          onPress: (){//change color


          },
        ),
      ),

      //colour: selectedGender == Gender.male
      //                      ? kActiveCardColour
      //                      : kInactiveCardColour,

      //onTap: Color == kActiveCardColor ? kInactiveCardColor: kActiveCardColor,
    );
  }


}
//card child holds the icon


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