//the page ppl navigate to
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:streaksApp/DatabaseHandler.dart'; //for the calendar database

//


class CalendarPage extends StatefulWidget {
  @override
  static const String id = 'CalendarPage';
  CalendarPageState createState() => CalendarPageState();

}

class CalendarPageState extends State<CalendarPage> {
  DatabaseHandler handler;

  //we store the dates of a given day
  List<int> dates; //holds list of ints representing the days for a given streak

  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: new Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  void setDates(int id) async { //this method is called in the streakRow file
    this.handler = DatabaseHandler();
    dates = await handler.retrieveDates(id);
    print("Stored Dates:"); //checking to see if it's actually returning the dates
    for(int i = 0; i < dates.length; i++){
      print(dates[i]);
    }

  }
  //for every date in dates, turn into datetime object and add to events.
  @override
  void initState() {
    //create datetime objects from list. Could be helpful?
    //DateTime date = new DateTime.fromMillisecondsSinceEpoch(1486252500000)
    for(int day in dates){
      DateTime date = new DateTime.fromMillisecondsSinceEpoch(day);
    }



    //
    // TODO: implement initState
    super.initState();

    //_controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Calendar'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
              TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16), //first day of streak, aka the first day on list for given streak
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),

            ),
          ],
        ),
      ),
    );
  }
}