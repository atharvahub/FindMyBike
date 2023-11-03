import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GoogleMaps extends StatefulWidget {
  final String lat;
  final String long;
  const GoogleMaps({super.key, required this.lat, required this.long});

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  late final WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(
          "https://www.google.com/maps/search/?api=1&query=45.495413,-73.5802679"));
  }

  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: height,
          width: width,
          child: WebViewWidget(
            controller: controller,
          ),
        ),
      ),
    );
  }
}
