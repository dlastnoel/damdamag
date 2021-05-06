import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../models/covid_cases.dart';

import './dashboard_components.dart';

class CovidUpdates extends StatefulWidget {
  final int index;

  CovidUpdates({this.index});
  @override
  _CovidUpdatesState createState() => _CovidUpdatesState();
}

class _CovidUpdatesState extends State<CovidUpdates> {
  List<CovidCases> caseOne = [];
  List<CovidCases> caseTwo = [];

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

    var results = jsonDecode(response.body);
    setState(() {
      caseOne.clear();
      caseTwo.clear();
      for (int i = 1; i <= 4; i++) {
        Color _color;
        String _count;
        String _imageUrl;
        String _category;
        switch (i) {
          case 1:
            _color = Colors.orange[400];
            _imageUrl = 'assets/images/virus.png';
            _count = results['data']['confirmed'].toString();
            _category = 'Confirmed Cases';
            caseOne.add(new CovidCases(
                color: _color,
                imageUrl: _imageUrl,
                count: _count,
                category: _category));
            break;
          case 2:
            _color = Colors.redAccent;
            _imageUrl = 'assets/images/active.png';
            _count = results['data']['active'].toString();
            _category = 'Active Cases';
            caseOne.add(new CovidCases(
                color: _color,
                imageUrl: _imageUrl,
                count: _count,
                category: _category));
            break;
          case 3:
            _color = Colors.indigo[400];
            _count = results['data']['recovered'].toString();
            _imageUrl = 'assets/images/recovered.png';
            _category = 'Recovered';
            caseTwo.add(new CovidCases(
                color: _color,
                imageUrl: _imageUrl,
                count: _count,
                category: _category));
            break;
          case 4:
            _color = Colors.grey[700];
            _count = results['data']['deaths'].toString();
            _imageUrl = 'assets/images/deaths.png';
            _category = 'Deaths';
            caseTwo.add(new CovidCases(
                color: _color,
                imageUrl: _imageUrl,
                count: _count,
                category: _category));
            break;
        }
      }
    });
  }

  @override
  void initState() {
    setState(() {
      getCovidCases(widget.index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: caseOne
              .map((caseData) => covidTile(caseData.color, caseData.imageUrl,
                  caseData.count, caseData.category))
              .toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: caseTwo
              .map((caseData) => covidTile(caseData.color, caseData.imageUrl,
                  caseData.count, caseData.category))
              .toList(),
        ),
      ],
    );
  }
}
