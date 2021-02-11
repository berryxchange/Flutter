//import 'dart:html';

import 'package:flutter_calendar_app/Models/EventModel.dart';

abstract class CalendarDateProtocol {
  var month;
  var day;
  var year;
}

class CalendarDateModel extends CalendarDateProtocol {
  var month;
  var day;
  var year;
  List<EventModel> event;

  CalendarDateModel({this.month, this.day, this.year, this.event});

  static CalendarDateModel fromCalendarDateModel(CalendarDateModel event) {
    return CalendarDateModel(
      month: event.month,
      day: event.day,
      year: event.year,
      event: event.event,
    );
  }
}
