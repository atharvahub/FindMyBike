class History {
  late DateTime eventTime;

  late String eventDescription;

  History(this.eventTime, this.eventDescription);

  DateTime getEventTime() {
    return eventTime;
  }

  String getEventDescription() {
    return eventDescription;
  }
}
