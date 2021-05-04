import 'package:flutter/material.dart';

class CovidCasesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barangay Covid Cases Update'),
      ),
      body: Center(
        child: Text(
          'Hello World',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
