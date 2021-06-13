import 'package:streaksApp/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:streaksApp/screens/TasksPage.dart';
import 'package:streaksApp/screens/AddHabitPage.dart';

void main() => runApp(streaksApp());

class streaksApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //initialRoute: WelcomeScreen.id,
      initialRoute: AddHabitPage.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        //LoginScreen.id: (context) => LoginScreen(),
        TasksPage.id: (context) => TasksPage(),
        AddHabitPage.id: (context) => AddHabitPage(),

      },

      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),

    );
  }
}
