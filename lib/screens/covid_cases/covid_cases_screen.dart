import 'package:flutter/material.dart';

class CovidCasesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barangay Covid Cases Update'),
      ),
      body: Column(
        children: [
          Container(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.teal,
                image: DecorationImage(
                  image: AssetImage('assets/images/covid.png'),
                  alignment: AlignmentDirectional.bottomCenter,
                ),
              ),
              padding: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height - 220,
            ),
          )
        ],
      ),
    );
  }
}
