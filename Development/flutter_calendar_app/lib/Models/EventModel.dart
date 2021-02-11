abstract class EventProtocol {
  String eventTitle;
  String eventDescription;
  var eventImage;
}

class EventModel extends EventProtocol {
  var eventTitle;
  var eventDescription;
  var eventImage;

  EventModel({this.eventTitle, this.eventDescription, this.eventImage});

  static EventModel fromEventModel(EventModel event) {
    return EventModel(
        eventTitle: event.eventTitle,
        eventDescription: event.eventDescription,
        eventImage: event.eventImage);
  }
}
