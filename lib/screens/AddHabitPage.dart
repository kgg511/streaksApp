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
import 'package:flutter/widgets.dart';


//these variables are used in both the stateful widget class and stateful class so I put here
String habitTextBox = "Habit"; //the text that is already in the textbox
bool edit = false; //tells it if the streak is being added or edited
int editId; //so that we know which streak to update
String modeName = "Add Habit"; //the name for the bottom button/title. Either Add Habit/Edit Habit

class AddHabitPage extends StatefulWidget {
  static const String id = 'AddHabitPage';
  @override
  _AddHabitPageState createState() => _AddHabitPageState();

  //The TaskPage uses this to tell addHabitPage what to edit.
  void editHabit(StreakRow a){
    habitTextBox = a.name; //updating the UI. Also do for color
    edit = true; //tell it to edit, not add
    editId = a.id;
    modeName = "Edit Habit";
  }


}

class _AddHabitPageState extends State<AddHabitPage> {
  static Color screenPickerColor;
  String habitName;
  final nameCon = TextEditingController();//controller for habit name
  DatabaseHandler handler; //database


  @override
  void initState() {
    super.initState();
    screenPickerColor = Colors.blue;  // Material blue.
    this.handler = DatabaseHandler();
    this.handler.initializeDB(); //create database
    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(modeName),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            controller: nameCon,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: habitTextBox,

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
            buttonTitle: modeName,
            onTap: () async {
              setState(() {
                habitTextBox = "Habit";
                habitName = nameCon.text;
                if (!edit){//add item to database!
                  DateTime a = DateTime.now();
                  int time_s = (new DateTime(a.year, a.month, a.day, 0, 0, 0, 0, 0)).millisecondsSinceEpoch; // the time started and the id
                  Streak s = Streak(id: a.millisecondsSinceEpoch, length: 0, name: habitName, start: time_s, col: screenPickerColor.value); //make streak object
                  List<Streak> streakTest = [s]; //put streak in a list for the insert method. Fix later
                  handler.insertStreak(streakTest);
                  print("insert called");
                }
                else{//update a value in the database
                  handler.updateName(habitName, screenPickerColor.value, editId);
                  edit = false; //now reset things back to adding mode
                  modeName = "Add Habit";
                  
                }
              });

              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
