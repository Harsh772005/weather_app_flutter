import 'package:flutter/material.dart';
import 'package:whetherapp/Worker/worker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => LoadingState();
}

class LoadingState extends State<Loading> {
  String as_location = '';
  String as_temp = '';
  String as_humidity = '';
  String as_air_speed = '';
  String as_description = '';
  String as_main = '';
  String as_icon='';
  String location='';

  void startApp(String as_location) async {
    Worker instance = Worker(location: as_location);
    await instance.getData();
    as_temp = instance.temp;
    as_humidity = instance.humidity; // Corrected this line
    as_air_speed = instance.air_speed;
    as_description = instance.description;
    as_main = instance.main;
    as_icon=instance.icon;
    future: Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        'location': as_location,
        'temp': as_temp,
        'humidity': as_humidity,
        'air_speed': as_air_speed,
        'description': as_description,
        'main': as_main,
        'icon': as_icon,
      });
    });

  }

  @override
  void initState() {
    // startApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    Map search = args != null ? args as Map : {};
    if(search?.isNotEmpty ?? false){
      as_location=search['searchText'].toString();
    }
    startApp(as_location);
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('Images/Logo.jpeg', height: 200, width: 200),
            SizedBox(height: 5), // Adding space between the image and text
            Text(
              'BHANU Whether App',
              style: TextStyle(fontSize: 20, color: Colors.white), // Optional: Set text color to contrast with background
            ),
            SizedBox(height: 20), // Adding space between texts
            SpinKitWave(
              color: Colors.white,
              size: 50.0,
            ),
            SizedBox(height: 20), // Adding space between texts
            Text(
              "Made by Harsh Bhanushali",
              style: TextStyle(fontSize: 18,color: Colors.white), // Optional: Set text color to contrast with background
            ),
          ],
        ),
      ),
    );
  }
}