import 'package:flutter/material.dart';

Widget casesTile(Color color, String imageUrl, String count, String category) {
  return Expanded(
    child: Container(
      height: 70,
      child: Card(
        elevation: 3,
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
