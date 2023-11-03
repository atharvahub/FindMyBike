import 'package:flutter/material.dart';
import 'package:gps_tracker/Authentication/login_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gps_tracker/gpstracker.dart';
import 'package:gps_tracker/statedetect.dart';
import 'package:workmanager/workmanager.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void callbackDispacher() {
  Workmanager().executeTask((taskName, inputData) {
    StateDetect.showNotification(
        title: "State Change",
        message: "The lock for your bike has been opened",
        flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin);
    return Future.value(true);
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispacher);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of the application.
  @override
  void initState() {
    super.initState();
    StateDetect.initialize(flutterLocalNotificationsPlugin);
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
