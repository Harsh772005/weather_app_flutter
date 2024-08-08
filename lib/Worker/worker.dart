import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart';
import 'dart:convert';

class Worker {
  String location;
  String temp = '';
  String humidity = '';
  String air_speed = '';
  String description = '';
  String main = '';
  String icon = '';

  Worker({required this.location});

  Future<void> getData() async {
    try {
      // Making the API call
      final response = await get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=a1983ea77fa2fd9daa39e3173884fc7a&units=metric'),
      );

      if (response.statusCode == 200) {
        // Parsing the response body
        final Map<String, dynamic> data = jsonDecode(response.body);

        // Extracting data from the response
        final Map<String, dynamic> mainData = data['main'];
        final double tempValue = mainData['temp'].toDouble();
        final int humidityValue = mainData['humidity'];

        final Map<String, dynamic> windData = data['wind'];
        final double airSpeedValue = windData['speed'].toDouble();

        final List<dynamic> weatherData = data['weather'];
        final Map<String, dynamic> weatherDetails = weatherData[0];
        final String mainDescription = weatherDetails['main'];
        final String detailedDescription = weatherDetails['description'];
        final String weatherIcon = weatherDetails['icon'];

        // Assigning values to the properties
        temp = tempValue.toString();
        humidity = humidityValue.toString();
        air_speed = airSpeedValue.toString();
        description = detailedDescription;
        main = mainDescription;
        icon = weatherIcon;

        print('Temp: $temp, Humidity: $humidity, Air Speed: $air_speed, Description: $description, Main: $main, Icon: $icon');
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print(e.toString());
      // Handling errors and assigning default values
      location = 'NA';
      temp = 'NA';
      humidity = 'NA';
      air_speed = 'NA';
      description = 'NA';
      main = 'NA';
      icon = '09d';
    }
  }
}


