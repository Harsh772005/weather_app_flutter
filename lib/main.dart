import 'package:flutter/material.dart';
import 'package:whetherapp/Activity/home.dart';
import 'package:whetherapp/Activity/loding.dart';
import 'package:whetherapp/Activity/location.dart';
import 'package:http/http.dart';

import 'Activity/loding.dart';


void main() {
  runApp(
    MaterialApp(
      initialRoute: "/",  // Set the initial route to "/"
      routes: {
        "/": (context) => Loading(),
        "/home": (context) => Home(),
        "/loading": (context) => Loading(),
        // '/location': (context) => Location(),
      },
      debugShowCheckedModeBanner: false,
    ),
  );
}
