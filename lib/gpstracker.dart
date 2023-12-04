import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gps_tracker/History/History.dart';
import 'package:gps_tracker/History/TrackHistory.dart';
import 'package:gps_tracker/Observer/Observer.dart';
import 'package:gps_tracker/main.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:workmanager/workmanager.dart';
import 'package:gps_tracker/Observer/NotificationsObservable.dart';
import 'googlemapsdisplay.dart';

class GPSTracker extends StatefulWidget {
  const GPSTracker({super.key});

  @override
  State<GPSTracker> createState() => _GPSTrackerState();
}

List<History> ListOfPastEvents = [];

Future<Position> _getCurrentLocation() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error("Location services disabled");
  }
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
  return await Geolocator.getCurrentPosition();
}

void _openMap(String lat, String long) async {
  String googleURL =
      'https://www.google.com/maps/search/?api=1&query=$lat,$long';
  await canLaunchUrlString(googleURL)
      ? await launchUrlString(googleURL)
      : throw 'Could not launch $googleURL';
}

class _GPSTrackerState extends State<GPSTracker> implements Observer {
  String location = 'Current location';
  String? latitude;
  String? longitude;
  @override
  void initState() {
    super.initState();
    Notifications.addObserver(this);
    Notifications.notifyObservers();
    DateTime dateTime = DateTime.now();
    ListOfPastEvents.add(History(
        dateTime.subtract(const Duration(hours: 1)), "Bike lock opened"));
    ListOfPastEvents.add(History(dateTime.subtract(const Duration(minutes: 5)),
        "Bike location changed"));
    ListOfPastEvents.add(History(
        dateTime.subtract(const Duration(minutes: 30)), "Bike lock closed"));
    ListOfPastEvents.add(History(
        dateTime.subtract(const Duration(minutes: 10)), "Bike lock opened"));
    ListOfPastEvents.add(History(
        dateTime.subtract(const Duration(minutes: 5)), "Bike lock opened"));
    ListOfPastEvents.add(History(
        dateTime.subtract(const Duration(minutes: 1)), "Bike lock opened"));
  }

  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: width * 0.17,
          title: Column(
            children: [
              Text("BikeTracker",
                  style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.2,
                      fontSize: width * 0.09)),
              const SizedBox(
                height: 5,
              ),
              Text("A simple app to keep your bike safe",
                  style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.2,
                      fontSize: width * 0.03)),
            ],
          ),
          backgroundColor: Color.fromRGBO(64, 75, 96, .9),
          elevation: 5,
        ),
        body: Container(
          height: height,
          width: width,
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height / 4,
                  width: width * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(84, 95, 116, .9),
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const GoogleMaps(
                                    lat: '45.4787615', long: '-73.626727')));
                      },
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Detect Bike Location ",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.1,
                ),
                SizedBox(
                  height: height / 4,
                  width: width * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(84, 95, 116, .9),
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const TrackHistory())));
                      },
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.directions_bike,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Check Bike history",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void notifyChange(String stateChange) {
    Workmanager().cancelAll();
    Workmanager().registerPeriodicTask("Show notification", stateChange,
        initialDelay: const Duration(seconds: 5),
        frequency: const Duration(hours: 1));
  }
}
