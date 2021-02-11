//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_app/Controllers/HomeController.dart';
import 'package:flutter_calendar_app/Data Server/CalendarData.dart';
import 'package:flutter_calendar_app/Models/EventModel.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_calendar_app/Models/CalendarDateModel.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:core';

class HomeView extends StatefulWidget {
  HomeView({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeView> with TickerProviderStateMixin {
  Map<DateTime, List> _holidays;

  List _givenHolidays;
  List _newGivenHolidays;
  List _dayEvents;

  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //final _selectedDay = DateTime.now();
    //final _holidaySelecteeDay = DateTime;

    _givenHolidays = CalendarDataSingleton.instance.holidays[DateTime] ?? [];

    _newGivenHolidays =
        CalendarDataSingleton.instance.newEvents[DateTime] ?? [];

    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    _animationController.forward();

    getGivenHolidayList();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _givenHolidays = events;
      //getGivenHolidayList();
      getGivenHolidayEventsList();
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Calendar"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 12.0, right: 12, top: 12, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /*Text(
                    "Daily Tasks",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "..",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  )

                   */
                ],
              ),
            ),

            //The Calendar
            _buildTableCalendar(),
            const SizedBox(height: 20.0),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Today's Workouts",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(
              height: 20,
            ),

            //The event List under Calendar
            Expanded(child: _buildEventList()),
          ],
        ),
      ),
    );
  }

  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: CalendarDataSingleton.instance.newEvents,
      holidays: CalendarDataSingleton.instance.newEvents,
      startingDayOfWeek: StartingDayOfWeek.monday,

      //style calendar selection date style
      calendarStyle: CalendarStyle(
        markersColor: Colors.red,
        selectedColor: Colors.blue,
        todayColor: Colors.blue[900],
        //markersColor: Colors.brown[700],
        outsideDaysVisible: false,
      ),

      headerStyle: HeaderStyle(
          formatButtonTextStyle:
              TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
          formatButtonDecoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(4.0),
          ),
          formatButtonPadding: EdgeInsets.all(8.0)),
      onDaySelected: (date, events, holidays) {
        _onDaySelected(date, events);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  List<CalendarDateModel> getGivenHolidayList() {
    List givenHolidaysList = _givenHolidays.map((event) {
      var thisEvent = CalendarDateModel.fromCalendarDateModel(event);
      return thisEvent;
    }).toList();
    print("Top List: ${givenHolidaysList.length}");
    return givenHolidaysList;
  }

  List<Container> getGivenHolidayEventsList() {
    List<CalendarDateModel> mainHolidayList = List();
    List<Container> secondaryHolidayList = List();

    mainHolidayList = getGivenHolidayList().map((unmappedEvent) {
      secondaryHolidayList = unmappedEvent.event.map((event) {
        var thisEvent = EventModel.fromEventModel(event);

        return Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.8),
            borderRadius: BorderRadius.circular(12.0),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: GestureDetector(
            child: Container(
              //height: 80,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                      color: Colors.black, width: 1.5)),
                              height: 75,
                              width: 75,
                              child: Image.asset(
                                event.eventImage,
                                fit: BoxFit.cover,
                              ),
                            ))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          thisEvent.eventTitle,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(thisEvent.eventDescription),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "11:00 am",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("20 mins"),
                      ],
                    )
                  ],
                ),
              ),
            ),
            onTap: () {
              print(event.eventTitle);
            },
          ),
        );
      }).toList();

      print(secondaryHolidayList.length);
    }).toList();

    return secondaryHolidayList;
  }

  Widget _buildEventList() {
    return ListView(children: getGivenHolidayEventsList());
  }
}
