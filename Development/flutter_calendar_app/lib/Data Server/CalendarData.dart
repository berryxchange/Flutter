import 'package:flutter/cupertino.dart';
import 'package:flutter_calendar_app/Models/CalendarDateModel.dart';
import 'package:flutter_calendar_app/Models/EventModel.dart';

class CalendarDataSingleton {
  static final CalendarDataSingleton instance =
      CalendarDataSingleton._protected();

  // Example holidays
  Map<DateTime, List> holidays = {
    DateTime(2021, 1, 1): ['New Year\'s Day'],
    DateTime(2021, 1, 6): ['Epiphany'],
    DateTime(2021, 2, 14): ['Valentine\'s Day'],
    DateTime(2021, 2, 23): ['Chinese New Year'],
    DateTime(2021, 4, 21): ['Easter Sunday'],
    DateTime(2021, 4, 22): ['Easter Monday'],
  };

  Map<DateTime, List> newEvents = {
    DateTime(2021, 1, 1): [
      CalendarDateModel(month: 1, day: 1, year: 2020, event: [
        EventModel(
            eventTitle: 'New Year\'s Day',
            eventDescription: "This is new years day sukka!",
            eventImage: "Assets/image1.jpg"),
      ])
    ],
    DateTime(2021, 1, 6): [
      CalendarDateModel(month: 1, day: 6, year: 2020, event: [
        EventModel(
            eventTitle: 'Epiphany',
            eventDescription: "This is about an epiphany",
            eventImage: "Assets/image4.jpg"),
        EventModel(
            eventTitle: 'Valentine\'s Day',
            eventDescription: "This is valentines day!!",
            eventImage: "Assets/image2.jpg"),
        EventModel(
            eventTitle: 'Chinese New Year',
            eventDescription: "Its Chinese new years!",
            eventImage: "Assets/image3.jpg"),
      ])
    ],
    DateTime(2021, 2, 14): [
      CalendarDateModel(month: 2, day: 14, year: 2020, event: [
        EventModel(
            eventTitle: 'Valentine\'s Day',
            eventDescription: "This is valentines day!!",
            eventImage: "Assets/image2.jpg"),
      ])
    ],
    DateTime(2021, 2, 23): [
      CalendarDateModel(month: 2, day: 23, year: 2020, event: [
        EventModel(
            eventTitle: 'Chinese New Year',
            eventDescription: "Its Chinese new years!",
            eventImage: "Assets/image3.jpg"),
      ])
    ],
    DateTime(2021, 4, 21): [
      CalendarDateModel(month: 4, day: 21, year: 2020, event: [
        EventModel(
            eventTitle: 'Easter Sunday',
            eventDescription: "Its Easter sukka!",
            eventImage: "Assets/image3.jpg"),
      ])
    ],
    DateTime(2021, 4, 22): [
      CalendarDateModel(month: 4, day: 22, year: 2020, event: [
        EventModel(
            eventTitle: 'Easter Monday',
            eventDescription: "Its another Easter day sukka!",
            eventImage: "Assets/image4.jpg"),
      ])
    ],
  };

  //models

  //initializers

  //factory

  //Voids

  //protected function

  CalendarDataSingleton._protected() {
    //put protected data here
  }
}
