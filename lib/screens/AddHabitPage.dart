import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:streaksApp/components/icon_content.dart';
import 'package:streaksApp/components/reusable_card.dart';
import 'package:streaksApp/constants.dart';
import 'package:streaksApp/screens/results_page.dart';
import 'package:streaksApp/components/bottom_button.dart';
import 'package:streaksApp/components/round_icon_button.dart';
import 'package:streaksApp/calculator_brain.dart';



class AddHabitPage extends StatefulWidget {
  static const String id = 'AddHabitPage';
  @override
  _AddHabitPageState createState() => _AddHabitPageState();
}

class _AddHabitPageState extends State<AddHabitPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          BottomButton(
            buttonTitle: 'Add Habit',
            onTap: () {

            },
          ),
        ],
      ),
    );
  }
}
