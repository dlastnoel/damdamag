import 'dart:ui';
import 'package:damdamag/screens/contact_details/contact_details_screen.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../config/routes/routing_constants.dart';

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List _officials = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    this.fetchOfficials();
  }

  fetchOfficials() async {
    var response =
        await http.get(Uri.parse('http://192.168.1.80:8000/api/officials/'));

    setState(() {
      if (response.statusCode == 200) {
        var results = json.decode(response.body);
        setState(() {
          _officials = results;
          _isLoading = true;
        });
      }
    });
  }

  Widget officialsTile(official) {
    int _id = official['id'];
    Color _tileColor;
    String _imageUrl;
    String _position = official['position'];
    String _firstname = official['firstname'];
    String _middlename =
        official['middlename'] != '' ? ' ' + official['middlename'] : '';
    String _lastname = official['lastname'];
    String _official =
        _position + ' ' + _firstname + _middlename + ' ' + _lastname;
    if (official['id'] % 2 != 0) {
      _tileColor = Colors.lightBlue;
    } else {
      _tileColor = Colors.teal;
    }

    switch (_position) {
      case ('Captain'):
        _imageUrl = 'assets/images/captain.png';
        break;
      case ('Secretary'):
        _imageUrl = 'assets/images/secretary.png';
        break;
      case ('Kagawad'):
        _imageUrl = 'assets/images/kagawad.png';
        break;
      case ('Tanod'):
        _imageUrl = 'assets/images/tanod.png';
        break;
      case ('Sk'):
        _imageUrl = 'assets/images/sk.png';
        break;
    }

    return InkWell(
      onTap: () => Navigator.pushNamed(context, ContactDetailsScreenRoute,
          arguments: ContactDetailsScreen(id: _id)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        tileColor: _tileColor,
        leading: Image(image: AssetImage(_imageUrl)),
        title: Text(_official),
      ),
    );
  }

  Widget loadData() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: ListView.builder(
          itemCount: _officials.length,
          itemBuilder: (context, index) {
            return officialsTile(_officials[index]);
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
