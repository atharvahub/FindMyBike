import 'dart:math';

import 'package:gps_tracker/History/History.dart';
import 'package:gps_tracker/Observer/Observable.dart';
import 'package:gps_tracker/Observer/Observer.dart';
import 'package:gps_tracker/gpstracker.dart';

List<String> bikeStates = ["Bike lock opened", "Bike location changed"];

class NotificationsObservable implements Observable {
  List<Observer> observers = [];

  @override
  void addObserver(Observer observer) {
    observers.add(observer);
  }

  @override
  void notifyObservers() {
    var rng = Random();
    int stateIndex = rng.nextInt(2);
    for (var observer in observers) {
      observer.notifyChange(bikeStates[stateIndex]);
    }
    ListOfPastEvents.add(History(DateTime.now(), bikeStates[stateIndex]));
  }

  @override
  void removeObserver(Observer observer) {
    observers.remove(observer);
  }
}
