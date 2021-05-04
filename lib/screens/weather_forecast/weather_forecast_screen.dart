import 'package:flutter/material.dart';

import '../../models/future_weather.dart';

import 'components/slider_dot.dart';
import './components/single_weather.dart';

class WeatherForecastScreen extends StatefulWidget {
  @override
  _WeatherForecastScreenState createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  Map<String, dynamic> mainWeather = {
    'location': null,
    'temperature': null,
    'wind': null,
    'precipitation': null,
    'humidity': null,
    'description': null,
  };
  List<FutureWeather> futureWeather = [];
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
  }

  void _onPageChanged(index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Forecast'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: Colors.teal,
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                for (int i = 0; i <= 3; i++)
                  (i == _currentPage)
                      ? SliderDot(
                          isActive: true,
                        )
                      : SliderDot(
                          isActive: false,
                        )
              ],
            ),
          ),
          Expanded(
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: PageController(initialPage: 0),
              onPageChanged: _onPageChanged,
              itemBuilder: (ctx, i) => new SingleWeather(
                mainWeather: mainWeather,
                futureWeather: futureWeather,
                index: i,
              ),
              itemCount: 4,
            ),
          ),
        ],
      ),
    );
  }
}
