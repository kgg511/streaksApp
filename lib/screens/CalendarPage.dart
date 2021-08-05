//the page ppl navigate to
//import 'dart:html';



import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:streaksApp/DatabaseHandler.dart'; //for the calendar database
import 'package:streaksApp/Events.dart';

import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CalendarPage extends StatefulWidget {
  @override
  static const String id = 'CalendarPage';
  int streakNum;

  CalendarPage({this.streakNum});

  CalendarPageState createState() => CalendarPageState(streakNum: streakNum);

}

class CalendarPageState extends State<CalendarPage> {


  CalendarPageState({this.streakNum});

  int streakNum; //the streak id
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

  Map<DateTime, List<Event>> c;

  List<DateTime> d = []; //the dates for a streak, but now as datetime objects
  DateTime date;

  Future<Map<DateTime, List<Event>>> setDates(int id) async { //this method is called in the streakRow file
    print("SETTING THINGS UP");
    this.handler = DatabaseHandler();
    dates = await handler.retrieveDates(id);
    print("Stored Dates:"); //checking to see if it's actually returning the dates & turning each into DateTime object
    for(int i = 0; i < dates.length; i++){
      print(dates[i]);
      date = new DateTime.fromMillisecondsSinceEpoch(dates[i]);
      d.add(date);
    }

    Map<DateTime, List<Event>> events = {}; //temporary variable within method.
    for(int k = 0; k < d.length; k++){
      //print("PRINT DATETIME");
      print(DateFormat("dd-MM-yyyy").format(d[k]));
      events[d[k]] = [Event(title: "DONE")]; //it's like it's not being saved..but why

    }
    selectedEvents = events;
    print(selectedEvents.length);
    return events;

  }

  Map<DateTime, List<Event>> selectedEvents; //global variable
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setDates(streakNum).then((Map<DateTime, List<Event>> result){
      selectedEvents = result;

    });
    print(selectedEvents.length ?? []);


  }

  List<Event> _getEventsfromDay(DateTime date) {



    print("now here it is from the event loader method");
    //print(e.length);
    print("YO");
    print([date] ?? []);
    return selectedEvents[date] ?? [];
  }

  CalendarFormat format = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now(); //change to first day of streak
  DateTime _focusedDay = DateTime.now();
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
                firstDay: DateTime.utc(2020, 6, 20), //first day of streak, aka the first day on list for given streak
                lastDay: DateTime.now(),
                focusedDay: DateTime.now(),


                eventLoader: _getEventsfromDay,

                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay; // update `_focusedDay` here as well
                  });
                },

                //dynamically update visible calendar format
                calendarFormat: format,
                onFormatChanged: (CalendarFormat _format){
                  setState(() {
                    format = _format;
                  });

                },

                calendarStyle: CalendarStyle(
                  isTodayHighlighted: true,
                  selectedDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  selectedTextStyle: TextStyle(color: Colors.white),
                  todayDecoration: BoxDecoration(
                    color: Colors.purpleAccent,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  defaultDecoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  weekendDecoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),

                headerStyle: HeaderStyle(
                  formatButtonVisible: true,
                  titleCentered: true,
                  formatButtonShowsNext: false,
                  formatButtonDecoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  formatButtonTextStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),


            ),



          ],
        ),
      ),
    );
  }
}