import 'package:flutter/material.dart';
import 'dart:core';
import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../models/future_weather.dart';

String getRandomString(int len) {
  const chars = "abcdefghijklmnopqrstuvwxyz0123456789";
  Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
  String result = "";
  for (var i = 0; i < len; i++) {
    result += chars[rnd.nextInt(chars.length)];
  }
  return result.toUpperCase();
}

String titleCase(String text) {
  if (text.length <= 1) return text.toUpperCase();
  var words = text.split(' ');
  var capitalized = words.map((word) {
    var first = word.substring(0, 1).toUpperCase();
    var rest = word.substring(1);
    return '$first$rest';
  });
  return capitalized.join(' ');
}

Future getWeather(index, Map mainWeather, List futureWeather) async {
  DateTime date = DateTime.now();
  http.Response response;
  String location;
  switch (index) {
    case 0:
      location = 'Rosario, La Union';
      response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/onecall?lat=16.2304&lon=120.4863&units=metric&exclude=minutely,hourly&appid=a22dab136c67a6f904266f9113083fa7'));
      break;
    case 1:
      location = 'City of San Fernando, La Union';
      response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/onecall?lat=15.0286&lon=120.6898&units=metric&exclude=minutely,hourly&appid=a22dab136c67a6f904266f9113083fa7'));
      break;
    case 2:
      location = 'Baguio City';
      response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/onecall?lat=16.4164&lon=120.5931&units=metric&exclude=minutely,hourly&appid=a22dab136c67a6f904266f9113083fa7'));
      break;
    case 3:
      location = 'Manila, Philippines';
      response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/onecall?lat=14.6042&lon=120.9822&units=metric&exclude=minutely,hourly&appid=a22dab136c67a6f904266f9113083fa7'));
      break;
  }

  var results = await jsonDecode(response.body);
  String temperature = results['current']['temp'].toString() + '°C';
  String wind = results['current']['wind_speed'].toString() + 'm/s';
  String description =
      titleCase(results['current']['weather'][0]['description']);
  String precipitation = results['current']['clouds'].toString() + '%';
  String humidity = results['current']['humidity'].toString() + '%';

  mainWeather.update('location', (value) => location);
  mainWeather.update('temperature', (value) => temperature);
  mainWeather.update('wind', (value) => wind);
  mainWeather.update('description', (value) => description);
  mainWeather.update('precipitation', (value) => precipitation);
  mainWeather.update('humidity', (value) => humidity);

  futureWeather.clear();
  for (int i = 1; i <= 3; i++) {
    String curTemp =
        results['daily'][i]['temp']['day'].toStringAsFixed(2) + '°C';

    date = date.add(Duration(days: 1));
    String _strDate = DateFormat('EEEE').format(date);
    FutureWeather futureWeatherItem = new FutureWeather(
        date: _strDate, icon: Icons.wb_sunny, temperature: curTemp);
    futureWeather.add(futureWeatherItem);
  }
}
