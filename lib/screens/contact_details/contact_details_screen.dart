import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ContactDetailsScreen extends StatefulWidget {
  final int id;

  ContactDetailsScreen({this.id});
  @override
  _ContactDetailsScreenState createState() => _ContactDetailsScreenState();
}

class _ContactDetailsScreenState extends State<ContactDetailsScreen> {
  String _imageUrl = 'assets/images/captain.png';
  String _position = '';
  String _firstname = '';
  String _middlename = '';
  String _lastname = '';
  String _address = '';
  String _contact = '';
  String _email = '';
  String _official = '';

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      this.fetchOfficial();
    });
  }

  Future fetchOfficial() async {
    setState(() {
      _isLoading = true;
    });
    String url =
        'http://192.168.1.80:8000/api/officials/' + widget.id.toString() + '/';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var results = json.decode(response.body);
      _position = results['position'].toString();
      setState(() {
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

        _firstname = results['firstname'].toString();
        _middlename = (results['middlename'].toString() != '')
            ? ' ' + results['middlename'].toString()
            : '';
        _lastname = results['lastname'].toString();
        _address =
            'Purok ' + results['purok'] + ', Poblacion West, Rosario, La Union';
        _contact = results['contact'];
        _email = results['email'];
        _official =
            _position + ' ' + _firstname + _middlename + ' ' + _lastname;
      });
    }
  }

  Widget loadData() {
    return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.teal,
              child: Center(
                child: Text(
                  _official,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            ListTile(
              tileColor: Colors.teal,
              leading: Text('Address: '),
              title: Text(_address),
            ),
            ListTile(
              tileColor: Colors.teal,
              leading: Text('Contact: '),
              title: Text(_contact),
            ),
            ListTile(
              tileColor: Colors.teal,
              leading: Text('Email: '),
              title: Text(_email),
            ),
          ],
        ),
      ),
    );
  }

  Widget loadBlank() {
    return Center(
      child: Text(
        'No internet connection',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 23,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Details'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                image: DecorationImage(
                  image: AssetImage(
                      (Theme.of(context).primaryColor == Color(0xff212121))
                          ? 'assets/images/rosario_light.png'
                          : 'assets/images/rosario_dark.png'),
                  alignment: AlignmentDirectional.bottomCenter,
                ),
              ),
              height: MediaQuery.of(context).size.height / 3,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            color: Colors.teal,
            child: Center(
              child: Image(
                image: AssetImage(_imageUrl),
                height: 40,
              ),
            ),
          ),
          _isLoading ? loadData() : loadBlank(),
        ],
      ),
    );
  }
}
