import 'package:streaksApp/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:streaksApp/screens/TasksPage.dart';
import 'package:streaksApp/screens/AddHabitPage.dart';
import 'package:streaksApp/DatabaseHandler.dart';
import 'package:flutter/widgets.dart';
import 'package:streaksApp/screens/CalendarPage.dart';

import 'package:streaksApp/DatabaseHandler.dart';

void main() => runApp(streaksApp());

class streaksApp extends StatelessWidget {
  DatabaseHandler handler;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      //initialRoute: TasksPage.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        //LoginScreen.id: (context) => LoginScreen(),
        TasksPage.id: (context) => TasksPage(),
        AddHabitPage.id: (context) => AddHabitPage(),
        CalendarPage.id: (context) => CalendarPage(),

      },

      theme: ThemeData.light().copyWith(
        primaryColor: Colors.grey,
        scaffoldBackgroundColor: Color(0xFFFFFFFF),
        //accentColor: Colors.blueAccent
      ),

      //-accentColor: foreground color for which
      //-primaryColor: Color given to background for major parts of app.
      //theme: ThemeData(
      //  primaryColor: Colors.red,
      //  accentColor: Colors.blue,
      //)
//Color(0xFF0A0E21)

    );
  }
}
