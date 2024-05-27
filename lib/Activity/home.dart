import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:math';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // getData();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var city_name = [
      'Mumbai',
      'Pune',
      'Ahmedabad',
      'Delhi',
      'Chennai',
      'Patna',
    ];
    final _random = Random();
    var City = city_name[_random.nextInt(city_name.length)];

    final Map info = ModalRoute.of(context)!.settings.arguments as Map;
    String temp = (info['temp']).toString();
    String icon = info['icon'].toString();
    String location = info['location'].toString();
    String humidity = info['humidity'].toString();
    String air_speed = info['air_speed'].toString();
    String description = info['description'].toString();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Weather App by Harsh'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Colors.red, Colors.blue],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue, Colors.green],
            ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        if((searchController.text).replaceAll(' ', '')==""){
                          print('Empty');
                        }
                        else{
                          Navigator.pushReplacementNamed(context, '/loading', arguments: {
                            'searchText': searchController.text,
                          });
                        }
                      },
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onSubmitted: (value) {
                          if (value.trim().isNotEmpty) {
                            Navigator.pushNamed(context, '/loading', arguments: {
                              'searchText': value.trim(),
                            });
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter City Like $City ',
                          hintStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[600],
                        borderRadius: BorderRadius.circular(35),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          Image.network(
                            "https://openweathermap.org/img/wn/$icon@2x.png",
                            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                              return Icon(Icons.error);
                            },
                          ),
                          SizedBox(width: 20),
                          Column(
                            children: <Widget>[
                              Text('$location', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                              Text('$description', style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[600],
                        borderRadius: BorderRadius.circular(35),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      padding: EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.thermostat_rounded, size: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('$temp', style: TextStyle(fontSize: 70)),
                              Text('°C', style: TextStyle(fontSize: 30)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[600],
                        borderRadius: BorderRadius.circular(35),
                      ),
                      margin: EdgeInsets.fromLTRB(25, 0, 10, 0),
                      padding: EdgeInsets.all(25),
                      height: 200,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.wind_power, size: 50),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text('$air_speed', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                          Text('km/hr', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[600],
                        borderRadius: BorderRadius.circular(35),
                      ),
                      margin: EdgeInsets.fromLTRB(10, 0, 25, 0),
                      padding: EdgeInsets.all(25),
                      height: 200,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(WeatherIcons.humidity, size: 50),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text('$humidity', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                          Text('percent', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 70),
              Text(
                'Made by Harsh Bhanushali',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              Text(
                'Data Provided by OpenWeatherMap.org',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
