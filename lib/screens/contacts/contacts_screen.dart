import 'dart:ui';
import 'package:damdamag/screens/contact_details/contact_details_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../config/routes/routing_constants.dart';

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List officials = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    this.fetchOfficials();
  }

  fetchOfficials() async {
    setState(() {
      isLoading = true;
    });
    var response =
        await http.get(Uri.parse('http://192.168.1.80:8000/api/officials/'));

    if (response.statusCode == 200) {
      var results = json.decode(response.body);
      setState(() {
        officials = results;
        isLoading = false;
      });
    } else {
      officials = [];
      isLoading = false;
    }
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: ListView.builder(
          itemCount: officials.length,
          itemBuilder: (context, index) {
            return officialsTile(officials[index]);
          }),
    );
  }
}
