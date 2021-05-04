import 'package:flutter/material.dart';

Widget futureWeatherTile(
    BuildContext context, String date, IconData icon, String temperature) {
  return Card(
    color: Theme.of(context).accentColor,
    elevation: 5,
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(date),
          Icon(
            icon,
            color: Colors.white,
          ),
          Text(temperature),
        ],
      ),
    ),
  );
}
