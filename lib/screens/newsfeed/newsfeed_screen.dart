import 'dart:convert';
import 'package:delayed_display/delayed_display.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import './components/newsfeed_components.dart';

class NewsfeedScreen extends StatefulWidget {
  @override
  _NewsfeedScreenState createState() => _NewsfeedScreenState();
}

class _NewsfeedScreenState extends State<NewsfeedScreen> {
  List _newsfeeds = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    this.fetchPosts();
  }

  fetchPosts() async {
    var response =
        await http.get(Uri.parse('http://192.168.1.80:8000/api/posts/all'));

    setState(() {
      if (response.statusCode == 200) {
        var results = json.decode(response.body);
        _newsfeeds = results;
        _isLoading = true;
      } else {
        _newsfeeds = [];
        _isLoading = false;
      }
    });
  }

  Widget posts(post) {
    Color _color;
    String _imageUrl;
    String _hashtag = '#' + post['hashtag'];
    String _author = post['position'] + ' ' + post['firstname'];
    String _content = post['content'];
    switch (_hashtag) {
      case ('#meeting'):
        _color = Colors.teal;
        _imageUrl = 'assets/images/meeting.png';
        break;
      case ('#announcement'):
        _color = Colors.lightBlue;
        _imageUrl = 'assets/images/announcement.png';
        break;
      case ('#ayuda'):
        _color = Colors.orange[400];
        _imageUrl = 'assets/images/support.png';
        break;
      case ('#events'):
        _color = Colors.deepPurple;
        _imageUrl = 'assets/images/event.png';
        break;
      case ('#lostandfound'):
        _color = Colors.redAccent;
        _imageUrl = 'assets/images/lostandfound.png';
    }
    return newsfeedCard(_color, _imageUrl, _hashtag, _author, _content);
  }

  Widget loadData() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: ListView.builder(
          itemCount: _newsfeeds.length,
          itemBuilder: (context, index) {
            return posts(_newsfeeds[index]);
          }),
    );
  }

  Widget loadBlank() {
    return DelayedDisplay(
      delay: Duration(seconds: 3),
      fadingDuration: Duration(milliseconds: 2),
      child: Center(
        child: Text(
          'No internet connection',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? loadData() : loadBlank();
  }
}
