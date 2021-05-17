import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import './components/covid_cases_components.dart';

class CovidCasesScreen extends StatefulWidget {
  @override
  _CovidCasesScreenState createState() => _CovidCasesScreenState();
}

class _CovidCasesScreenState extends State<CovidCasesScreen> {
  String _total = '';
  String _active = '';
  String _recovered = '';
  String _deaths = '';
  String _author = '';
  String _hashtag = '';
  String _content = '';

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      this.fetchCases();
      this.fetchPost();
    });
  }

  Future fetchCases() async {
    setState(() {
      isLoading = true;
    });
    var response =
        await http.get(Uri.parse('http://192.168.1.80:8000/api/cases/count/'));

    if (response.statusCode == 200) {
      var results = json.decode(response.body);
      setState(() {
        _total = results['total'].toString();
        _active = results['active'].toString();
        _recovered = results['recovered'].toString();
        _deaths = results['deaths'].toString();
        isLoading = false;
      });
    } else {
      isLoading = false;
    }
  }

  Future fetchPost() async {
    setState(() {
      isLoading = true;
    });
    var response =
        await http.get(Uri.parse('http://192.168.1.80:8000/api/posts/cases/'));

    if (response.statusCode == 200) {
      var results = json.decode(response.body);
      setState(() {
        isLoading = false;
        _hashtag = '#' + results[0]['hashtag'];
        _author = 'Pinned Post by ' +
            results[0]['position'] +
            ' ' +
            results[0]['firstname'];
        _content = results[0]['content'];
      });
    } else {
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barangay Covid Cases Update'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  image: DecorationImage(
                    image: AssetImage('assets/images/covid.png'),
                    alignment: AlignmentDirectional.bottomCenter,
                  ),
                ),
                padding: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            (_total != '') ? _total : '',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Divider(
                            color: Colors.white,
                            height: 20,
                            thickness: 2,
                            indent: 20,
                            endIndent: 20,
                          ),
                          Text(
                            'Brgy. Poblacion West Total Cases',
                            style: TextStyle(
                              fontSize: 21,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        casesTile(Colors.redAccent, 'assets/images/active.png',
                            (_active != null) ? _active : '', 'Active Cases'),
                        casesTile(
                            Colors.indigo[400],
                            'assets/images/recovered.png',
                            (_recovered != null) ? _recovered : '',
                            'Recovered'),
                        casesTile(Colors.grey[700], 'assets/images/deaths.png',
                            (_deaths != null) ? _deaths : '', 'Deaths')
                      ],
                    ),
                    Row(
                      children: [
                        casesTile(Colors.lightBlue,
                            'assets/images/investigation.png', '15', 'PUI(s)'),
                        casesTile(Colors.lightBlue,
                            'assets/images/monitoring.png', '25', 'PUM(s)'),
                      ],
                    ),
                    Container(
                      child: Card(
                        color: Colors.amber[800],
                        elevation: 3,
                        child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/announcement.png'),
                                alignment: AlignmentDirectional.bottomCenter,
                              ),
                            ),
                            padding: EdgeInsets.all(10),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Text(
                                    ((_hashtag != null) ? _hashtag : ''),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text((_author != null) ? _author : ''),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text((_content != null) ? _content : ''),
                                ],
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
