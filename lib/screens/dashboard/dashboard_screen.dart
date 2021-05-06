import 'package:flutter/material.dart';

import '../../config/routes/routing_constants.dart';

import 'components/dashboard_components.dart';
import 'components/weather_forecast.dart';
import 'components/covid_updates.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Column(
            children: [
              titleTile(context, 'Weather Forecast (Rosario, La Union)',
                  Theme.of(context).primaryColor),
              Container(
                color: Theme.of(context).primaryColor,
                child: WeatherForecast(),
              ),
              Container(
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      child: Text(
                        'VIEW DETAILED FORECAST',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      onTap: () => Navigator.pushNamed(
                          context, WeatherForecastScreenRoute),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.all(10),
            width: double.infinity,
            child: Card(
              elevation: 5,
              color: Theme.of(context).accentColor,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    covidTitle(),
                    SizedBox(
                      height: 5,
                    ),
                    subtitleTitle('Global'),
                    Container(
                      child: CovidUpdates(
                        index: 0,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    subtitleTitle('Philippines'),
                    Container(
                      child: CovidUpdates(
                        index: 1,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          child: Text(
                            'VIEW LOCAL UPDATES',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onTap: () => Navigator.pushNamed(
                              context, CovidCasesScreenRoute),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
