import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:streaksApp/constants.dart';
import 'package:streaksApp/components/bottom_button.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:streaksApp/screens/TasksPage.dart';
import 'package:streaksApp/components/StreakRow.dart';
import 'package:streaksApp/constants.dart';
import 'package:streaksApp/Streak.dart';

import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:streaksApp/DatabaseHandler.dart';


class AddHabitPage extends StatefulWidget {
  static const String id = 'AddHabitPage';
  @override
  _AddHabitPageState createState() => _AddHabitPageState();
}

class _AddHabitPageState extends State<AddHabitPage> {
  static Color screenPickerColor;
  String habitName;
  final nameCon = TextEditingController();//controller for habit name


  @override
  void initState() {
    super.initState();

    screenPickerColor = Colors.blue;  // Material blue.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADD HABIT'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            controller: nameCon,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Habit',

            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Card(
                elevation: 2,
                child: ColorPicker(
                  // Use the screenPickerColor as start color.
                  color: screenPickerColor,
                  // Update the screenPickerColor using the callback.
                  onColorChanged: (Color color) =>
                      setState(() => screenPickerColor = color),
                  width: 44,
                  height: 44,
                  borderRadius: 22,
                  heading: Text(
                    'Select color',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  subheading: Text(
                    'Select color shade',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              ),
            ),
          ),
          BottomButton(
            buttonTitle: 'Add Habit',
            onTap: () {
              setState(() {
                habitName = nameCon.text;
                print(habitName); //next: make an object with the data/insert into database
              });
              Streak s = Streak(length: 0, name: habitName, start: DateTime.now()); //make streak object
              List<Streak> streakTest = [s]; //put streak in a list for the insert method. Fix later

              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
