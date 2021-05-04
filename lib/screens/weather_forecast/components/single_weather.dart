import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'dart:convert';

import './weather_forecast_components.dart';

import '../../../helpers/helpers.dart';

import '../../../models/future_weather.dart';

class SingleWeather extends StatefulWidget {
  final Map mainWeather;
  final List<FutureWeather> futureWeather;
  final int index;

  SingleWeather({this.mainWeather, this.futureWeather, this.index});

  @override
  _SingleWeatherState createState() => _SingleWeatherState();
}

class _SingleWeatherState extends State<SingleWeather> {
  DateTime _date = DateTime.now();
  String _weatherImage = 'assets/images/blank_weather.png';

  Future getWeather(index) async {
    http.Response response;
    String _location;
    switch (index) {
      case 0:
        _location = 'Rosario, La Union';
        response = await http.get(Uri.parse(
            'https://api.openweathermap.org/data/2.5/onecall?lat=16.2304&lon=120.4863&units=metric&exclude=minutely,hourly&appid=a22dab136c67a6f904266f9113083fa7'));
        break;
      case 1:
        _location = 'City of San Fernando, La Union';
        response = await http.get(Uri.parse(
            'https://api.openweathermap.org/data/2.5/onecall?lat=15.0286&lon=120.6898&units=metric&exclude=minutely,hourly&appid=a22dab136c67a6f904266f9113083fa7'));
        break;
      case 2:
        _location = 'Baguio City';
        response = await http.get(Uri.parse(
            'https://api.openweathermap.org/data/2.5/onecall?lat=16.4164&lon=120.5931&units=metric&exclude=minutely,hourly&appid=a22dab136c67a6f904266f9113083fa7'));
        break;
      case 3:
        _location = 'Manila, Philippines';
        response = await http.get(Uri.parse(
            'https://api.openweathermap.org/data/2.5/onecall?lat=14.6042&lon=120.9822&units=metric&exclude=minutely,hourly&appid=a22dab136c67a6f904266f9113083fa7'));
        break;
    }

    var results = jsonDecode(response.body);
    setState(() {
      String _temperature = results['current']['temp'].toString() + '°C';
      String _wind = results['current']['wind_gust'].toString() + 'm/s';
      String _description =
          titleCase(results['current']['weather'][0]['description']);
      String _precipitation = results['current']['clouds'].toString() + '%';
      String _humidity = results['current']['humidity'].toString() + '%';

      widget.mainWeather.update('location', (value) => _location);
      widget.mainWeather.update('temperature', (value) => _temperature);
      widget.mainWeather.update('wind', (value) => _wind);

      if (_description.contains('Sky')) {
        _weatherImage = 'assets/images/sunny.png';
      }
      if (_description.contains('Clouds')) {
        _weatherImage = 'assets/images/cloudy.png';
      }
      if (_description.contains('Rain')) {
        _weatherImage = 'assets/images/rain.png';
      }
      if (_description.contains('Thunderstorm')) {
        _weatherImage = 'assets/images/storm.png';
      }

      widget.mainWeather.update('description', (value) => _description);
      widget.mainWeather.update('precipitation', (value) => _precipitation);
      widget.mainWeather.update('humidity', (value) => _humidity);

      widget.futureWeather.clear();
      for (int i = 1; i <= 3; i++) {
        IconData _weatherIcon;
        String _curTemp =
            results['daily'][i]['temp']['day'].toStringAsFixed(2) + '°C';
        String _desc = results['daily'][i]['weather'][0]['description'];

        if (_desc.contains('clear sky')) {
          _weatherIcon = Icons.wb_sunny;
        }
        if (_desc.contains('clouds')) {
          _weatherIcon = Icons.wb_cloudy_outlined;
        }
        if (_desc.contains('rain')) {
          _weatherIcon = Icons.circle;
        }
        if (_desc.contains('thunderstorm')) {
          _weatherIcon = Icons.cloud_circle;
        }

        _date = _date.add(Duration(days: 1));
        String _strDate = DateFormat('EEEE').format(_date);
        FutureWeather futureWeatherItem = new FutureWeather(
            date: _strDate, icon: _weatherIcon, temperature: _curTemp);
        widget.futureWeather.add(futureWeatherItem);
      }
    });
  }

  @override
  void initState() {
    setState(() {
      getWeather(widget.index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.teal,
              image: DecorationImage(
                image: AssetImage(_weatherImage),
                alignment: AlignmentDirectional.bottomCenter,
              ),
            ),
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height - 220,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Column(
                    children: [],
                  ),
                ),
                Text(
                  (widget.mainWeather['location'] != null)
                      ? widget.mainWeather['location']
                      : '',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(
                  color: Colors.white,
                  height: 20,
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                ),
                Text(
                  (widget.mainWeather['temperature'] != null)
                      ? widget.mainWeather['temperature'] +
                          '  (' +
                          widget.mainWeather['description'] +
                          ')'
                      : '',
                  style: TextStyle(
                    fontSize: 21,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: Icon(
                    Icons.waves_outlined,
                    color: Colors.white,
                  ),
                  title: Text(
                    (widget.mainWeather['wind'] != null)
                        ? 'Wind: ' + widget.mainWeather['wind']
                        : '',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.cloud,
                    color: Colors.white,
                  ),
                  title: Text(
                    (widget.mainWeather['precipitation'] != null)
                        ? 'Precipitation: ' +
                            widget.mainWeather['precipitation']
                        : '',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.circle,
                    color: Colors.white,
                  ),
                  title: Text(
                    (widget.mainWeather['humidity'] != null)
                        ? 'Humidity: ' + widget.mainWeather['humidity']
                        : '',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: widget.futureWeather
              .map((futureWeatherData) => futureWeatherTile(
                  context,
                  futureWeatherData.date,
                  futureWeatherData.icon,
                  futureWeatherData.temperature))
              .toList(),
        ),
      ],
    );
  }
}
