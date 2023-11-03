import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gps_tracker/main.dart';
import 'package:gps_tracker/statedetect.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:workmanager/workmanager.dart';
import 'googlemapsdisplay.dart';

class GPSTracker extends StatefulWidget {
  const GPSTracker({super.key});

  @override
  State<GPSTracker> createState() => _GPSTrackerState();
}

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

void _liveLocation() {
  LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high, distanceFilter: 100);
}

void _openMap(String lat, String long) async {
  String googleURL =
      'https://www.google.com/maps/search/?api=1&query=$lat,$long';
  await canLaunchUrlString(googleURL)
      ? await launchUrlString(googleURL)
      : throw 'Could not launch $googleURL';
}

class _GPSTrackerState extends State<GPSTracker> {
  @override
  void initState() {
    super.initState();
    Workmanager().cancelAll();
    Workmanager().registerPeriodicTask("Show notification", "Bike State Change",
        initialDelay: const Duration(seconds: 5),
        frequency: const Duration(hours: 1));
  }

  Widget build(BuildContext context) {
    String location = 'Current location';
    String? latitude;
    String? longitude;
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: height,
          width: width,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await _getCurrentLocation().then((value) {
                      latitude = '${value.latitude}';
                      longitude = '${value.longitude}';
                      setState(() {
                        location =
                            "Latitude = $latitude, Longitude = $longitude";
                      });
                      print(latitude);
                      print(longitude);
                    });
                  },
                  child: const Text("Get Phone location"),
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GoogleMaps(
                                lat: '45.4787615', long: '-73.626727')));
                  },
                  child: const Text("google maps"),
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: () {
                    StateDetect.showNotification(
                        title: "Change of State",
                        message: "Someone opened the lock of your bike",
                        flutterLocalNotificationsPlugin:
                            flutterLocalNotificationsPlugin);
                  },
                  child: const Text("Show Notification"),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  location,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
