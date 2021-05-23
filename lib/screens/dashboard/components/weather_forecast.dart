import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import './dashboard_components.dart';

class WeatherForecast extends StatefulWidget {
  @override
  _WeatherForecastState createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  String _temperature;
  String _description;
  String _sunrise;
  String _sunset;
  IconData _weatherIcon;
  bool _isLoading = false;

  Future getWeather() async {
    http.Response response;
    response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?id=1691480&units=metric&appid=a22dab136c67a6f904266f9113083fa7'));

    if (response.statusCode == 200) {
      var results = jsonDecode(response.body);
      setState(() {
        _isLoading = true;
        _temperature = results['main']['temp'].toString() + '°C';
        _description = results['weather'][0]['main'];
        if (_description.contains('Clear')) {
          _weatherIcon = Icons.wb_sunny;
        }
        if (_description.contains('Thunderstorm')) {
          _weatherIcon = Icons.cloud_circle;
        }
        if (_description.contains('Rain')) {
          _weatherIcon = Icons.cloud_circle_outlined;
        }
        if (_description.contains('Clouds')) {
          _weatherIcon = Icons.cloud_outlined;
        }

        _sunrise = DateFormat('jm')
            .format(DateTime.fromMillisecondsSinceEpoch(
                results['sys']['sunrise'] * 1000))
            .toString();
        _sunset = DateFormat('jm')
            .format(DateTime.fromMillisecondsSinceEpoch(
                results['sys']['sunset'] * 1000))
            .toString();
      });
    }
  }

  @override
  void initState() {
    setState(() {
      getWeather();
    });
    super.initState();
  }

  Widget loadData() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        weatherTile(_temperature + ' ' + _description, _weatherIcon),
        weatherTile(_sunrise, Icons.wb_sunny_sharp),
        weatherTile(_sunset, Icons.wb_sunny_outlined),
      ],
    );
  }

  Widget loadBlank() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        weatherTile('', Icons.circle),
        weatherTile('', Icons.wb_sunny_sharp),
        weatherTile('', Icons.wb_sunny_outlined),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? loadData() : loadBlank();
  }
}
