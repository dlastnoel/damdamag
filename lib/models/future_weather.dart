import 'package:flutter/material.dart';

class FutureWeather {
  final String date;
  final IconData icon;
  final String temperature;

  FutureWeather(
      {@required this.date, @required this.icon, @required this.temperature});
}
