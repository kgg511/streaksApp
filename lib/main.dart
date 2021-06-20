import 'package:streaksApp/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:streaksApp/screens/TasksPage.dart';
import 'package:streaksApp/screens/AddHabitPage.dart';

import 'package:streaksApp/DatabaseHandler.dart';

void main() => runApp(streaksApp());

class streaksApp extends StatelessWidget {
  DatabaseHandler handler;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //initialRoute: WelcomeScreen.id,
      initialRoute: TasksPage.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        //LoginScreen.id: (context) => LoginScreen(),
        TasksPage.id: (context) => TasksPage(),
        AddHabitPage.id: (context) => AddHabitPage(),

      },

      theme: ThemeData.light().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFFFFFFFF),
      ),

    );
  }
}
