import 'package:flutter/material.dart';

Widget newsfeedCard(Color color, String imageUrl, String hashtag, String author,
    String content) {
  return Card(
    margin: EdgeInsets.all(15),
    elevation: 5,
    child: Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        image: DecorationImage(
          image: AssetImage(imageUrl),
          alignment: AlignmentDirectional.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            hashtag,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(author),
          SizedBox(
            height: 5,
          ),
          Text(content),
        ],
      ),
    ),
  );
}
