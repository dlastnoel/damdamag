import 'package:flutter/material.dart';

import '../../config/routes/routing_constants.dart';

import 'components/dashboard_components.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        titleTile(context, 'Weather Forecast', Theme.of(context).primaryColor),
        Container(
          color: Theme.of(context).primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              weatherTile('69°C Inferno', Icons.wb_twighlight),
              weatherTile('05:28 am', Icons.wb_sunny_sharp),
              weatherTile('06:35 pm', Icons.wb_sunny_outlined),
            ],
          ),
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
                onTap: () =>
                    Navigator.pushNamed(context, WeatherForecastScreenRoute),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 40,
        ),
        titleTile(context, 'COVID-19 Updates', Colors.teal[900]),
        Container(
          child: Column(
            children: [
              subtitleTitle(context, 'Philippines'),
              Container(
                color: Colors.teal[900],
                padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    transparentCovidTile(
                        'Total', '300,000', Icons.supervised_user_circle),
                    transparentCovidTile(
                        'Active', '70,000', Icons.sick_outlined),
                    transparentCovidTile(
                        'Recovered', '200,000', Icons.person_add_alt_1),
                    transparentCovidTile('Deaths', '20,000', Icons.dangerous),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          child: Column(
            children: [
              Container(
                color: Colors.teal[900],
                padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    covidTile(
                        'New Cases', '12', Icons.sick_outlined, Colors.teal),
                    covidTile('New Recoveries', '49', Icons.person_add_alt_1,
                        Colors.teal),
                    covidTile('New Deaths', '0', Icons.dangerous, Colors.teal),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          child: Column(
            children: [
              subtitleTitle(context, 'Barangay Poblacion West'),
              Container(
                color: Colors.teal[900],
                padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    covidTile('Total', '53', Icons.supervised_user_circle,
                        Colors.indigo[400]),
                    covidTile('Active', '12', Icons.sick_outlined,
                        Colors.indigo[400]),
                    covidTile('Recovered', '49', Icons.person_add_alt_1,
                        Colors.indigo[400]),
                    covidTile(
                        'Deaths', '0', Icons.dangerous, Colors.indigo[400]),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.teal[900],
          padding: EdgeInsets.fromLTRB(0, 0, 10, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                child: Text(
                  'VIEW FULL DETAILS',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () =>
                    Navigator.pushNamed(context, CovidCasesScreenRoute),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
