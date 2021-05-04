import 'package:flutter/material.dart';

Widget weatherTile(String title, IconData icon) {
  return Card(
    elevation: 3,
    margin: EdgeInsets.all(5),
    color: Colors.red[300],
    child: Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          Text(title),
        ],
      ),
    ),
  );
}

Widget titleTile(BuildContext context, String title, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
    color: color,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 17),
        ),
      ],
    ),
  );
}

Widget subtitleTitle(BuildContext context, String title) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
    color: Colors.teal[900],
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 15),
        ),
      ],
    ),
  );
}

Widget transparentCovidTile(String title, String data, IconData icon) {
  return Card(
    margin: EdgeInsets.all(5),
    elevation: 0,
    color: Colors.teal[900],
    child: Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text(title),
          Icon(
            icon,
            color: Colors.white,
          ),
          Text(data),
        ],
      ),
    ),
  );
}

Widget covidTile(String title, String data, IconData icon, Color color) {
  return Card(
    elevation: 3,
    margin: EdgeInsets.all(5),
    color: color,
    child: Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text(title),
          Icon(
            icon,
            color: Colors.white,
          ),
          Text(data),
        ],
      ),
    ),
  );
}
