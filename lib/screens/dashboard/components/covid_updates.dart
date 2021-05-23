import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:delayed_display/delayed_display.dart';

import '../../../models/covid_cases.dart';

import './dashboard_components.dart';

class CovidUpdates extends StatefulWidget {
  final int index;

  CovidUpdates({this.index});
  @override
  _CovidUpdatesState createState() => _CovidUpdatesState();
}

class _CovidUpdatesState extends State<CovidUpdates> {
  List<CovidCases> _caseOne = [];
  List<CovidCases> _caseTwo = [];
  bool _isLoading = false;

  final formatter = NumberFormat('###,###,###,000');

  Future getCovidCases(index) async {
    http.Response response;

    switch (index) {
      case 0:
        response = await http
            .get(Uri.parse('https://covid-api.com/api/reports/total'));
        break;

      case 1:
        response = await http
            .get(Uri.parse('https://covid-api.com/api/reports/total?iso=PHL'));
        break;
    }

    if (response.statusCode == 200) {}

    var results = jsonDecode(response.body);
    setState(() {
      _caseOne.clear();
      _caseTwo.clear();
      for (int i = 1; i <= 4; i++) {
        Color _color;
        String _count;
        String _imageUrl;
        String _category;
        switch (i) {
          case 1:
            _color = Colors.orange[400];
            _imageUrl = 'assets/images/virus.png';
            _count = formatter.format(results['data']['confirmed']);
            _category = 'Confirmed Cases';
            _caseOne.add(new CovidCases(
                color: _color,
                imageUrl: _imageUrl,
                count: _count,
                category: _category));
            break;
          case 2:
            _color = Colors.blueGrey;
            _imageUrl = 'assets/images/active.png';
            _count = formatter.format(results['data']['active']);
            _category = 'Active Cases';
            _caseOne.add(new CovidCases(
                color: _color,
                imageUrl: _imageUrl,
                count: _count,
                category: _category));
            break;
          case 3:
            _color = Colors.indigo[400];
            _count = formatter.format(results['data']['recovered']);
            _imageUrl = 'assets/images/recovered.png';
            _category = 'Recovered';
            _caseTwo.add(new CovidCases(
                color: _color,
                imageUrl: _imageUrl,
                count: _count,
                category: _category));
            break;
          case 4:
            _color = Colors.grey[700];
            _count = formatter.format(results['data']['deaths']);
            _imageUrl = 'assets/images/deaths.png';
            _category = 'Deaths';
            _caseTwo.add(new CovidCases(
                color: _color,
                imageUrl: _imageUrl,
                count: _count,
                category: _category));
            break;
        }
      }
      _isLoading = true;
    });
  }

  @override
  void initState() {
    setState(() {
      getCovidCases(widget.index);
    });
    super.initState();
  }

  Widget loadData() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _caseOne
              .map((caseData) => covidTile(caseData.color, caseData.imageUrl,
                  caseData.count, caseData.category))
              .toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _caseTwo
              .map((caseData) => covidTile(caseData.color, caseData.imageUrl,
                  caseData.count, caseData.category))
              .toList(),
        ),
      ],
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
