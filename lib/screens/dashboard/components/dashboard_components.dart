import 'package:flutter/material.dart';

Widget weatherTile(String title, IconData icon) {
  return Expanded(
    child: Card(
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

Widget covidTitle() {
  return Row(
    children: [
      Text(
        'COVID 19 UPDATES',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ],
  );
}

Widget subtitleTitle(String text) {
  return Row(
    children: [
      Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ],
  );
}

Widget covidTile(Color color, String imageUrl, String count, String category) {
  return Expanded(
    child: Container(
      height: 70,
      child: Card(
        elevation: 2,
        color: color,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imageUrl),
              alignment: AlignmentDirectional.bottomCenter,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  count,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  category,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
