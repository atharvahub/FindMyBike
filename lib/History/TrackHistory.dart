import 'package:flutter/material.dart';
import 'package:gps_tracker/gpstracker.dart';
import 'package:time_range/time_range.dart';

class TrackHistory extends StatefulWidget {
  const TrackHistory({super.key});

  @override
  State<TrackHistory> createState() => _TrackHistoryState();
}

class _TrackHistoryState extends State<TrackHistory> {
  DateTime startTime = DateTime.now().subtract(const Duration(minutes: 60));
  DateTime endTime = DateTime.now();
  int listCounter = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    listCounter = 0;
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            centerTitle: true,
            toolbarHeight: width*0.17,
            title: Text("Bike Tracking History", style: TextStyle(color: Colors.white, letterSpacing: 1.2, fontSize: width*0.08)),
            backgroundColor: Color.fromRGBO(64, 75, 96, .9),
            elevation: 5,
          ),
      body: Container(
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                  child: Text("Select time range", style: TextStyle(color: Colors.white, fontSize: 25),)),
            ),
            const SizedBox(height: 10),
            TimeRange(
              fromTitle: Text('From', style: TextStyle(fontSize: 18, color: Colors.white),),
              toTitle: Text('To', style: TextStyle(fontSize: 18, color: Colors.white),),
              titlePadding: 20,
              textStyle: TextStyle(fontWeight: FontWeight.normal, color: Colors.white),
              activeTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              borderColor: Colors.white,
              backgroundColor: Colors.transparent,
              activeBackgroundColor: Colors.white,
              firstTime: TimeOfDay.fromDateTime(DateTime.now().subtract(Duration(hours: 1))),
              lastTime: TimeOfDay.now(),
              timeStep: 1,
              timeBlock: 1,
              onRangeCompleted: (range) => setState((){
                startTime = DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day, range!.start.hour, range!.start.minute);
                endTime = DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day, range!.end.hour, range!.end.minute);
              }),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: ListOfPastEvents.length,
                itemBuilder: ((context, index) {

                  if (ListOfPastEvents[index]
                          .getEventTime()
                          .isAfter(startTime) &&
                      ListOfPastEvents[index]
                          .getEventTime()
                          .isBefore(endTime)) {
                    DateTime getTime = ListOfPastEvents[index].getEventTime();
                    String time = "${getTime.hour}:${getTime.minute}, ${getTime.day}/${getTime.month}/${getTime.year}";
                    if(getTime.minute<10){
                      time = "${getTime.hour}:0${getTime.minute}, ${getTime.day}/${getTime.month}/${getTime.year}";
                    } else{
                      time = "${getTime.hour}:${getTime.minute}, ${getTime.day}/${getTime.month}/${getTime.year}";
                    }

                    return Card(
                      elevation: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Container(
                        decoration: const BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                        child: ListTile(
                          shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          contentPadding:const  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          leading: Container(
                            padding: const EdgeInsets.only(right: 12.0),
                            decoration: const BoxDecoration(
                                border: Border(
                                    right: BorderSide(width: 1.0, color: Colors.white24))),
                            child: Text("${++listCounter}", style: const TextStyle(color: Colors.white, fontSize: 20),),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(ListOfPastEvents[index].getEventDescription(), style: const TextStyle(color: Colors.white),),
                              Text(time, style: const TextStyle(color: Colors.white),)
                            ]
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked_s = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(startTime),
    );

    if (picked_s != null && picked_s != startTime) {
      setState(() {
        startTime = DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, picked_s.hour, picked_s.minute);
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay pickedS = (await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(endTime),
    ))!;

    setState(() {
      endTime = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, pickedS.hour, pickedS.minute);
    });
  }

  showAlertDialog(BuildContext context, String error) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Time range error"),
      content: Text(error),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
