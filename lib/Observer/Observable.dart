import 'package:gps_tracker/Observer/Observer.dart';

abstract class Observable {
  void addObserver(Observer observer) {}
  void removeObserver(Observer observer){}
  void notifyObservers(){}
}
