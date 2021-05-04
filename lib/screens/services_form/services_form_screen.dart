import 'package:flutter/material.dart';

import '../../config/routes/routing_constants.dart';
import '../../helpers/helpers.dart';

import '../output_code/output_code_screen.dart';

class ServicesFormScreen extends StatelessWidget {
  final String title;
  final String formType;
  final String imageUrl;

  ServicesFormScreen({this.title, this.formType, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    String _othersLabel;
    switch (formType) {
      case 'clearance':
        _othersLabel = 'Purpose in getting brgy. clearance';
        break;
      case 'indigency':
        _othersLabel = 'Purpose in getting cert. of indigency';
        break;
      case 'blotter':
        _othersLabel = 'Person to be blotterd / Other info';
        break;
      case 'lsi':
        _othersLabel = 'Travel history / etc';
        break;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Card(
          margin: EdgeInsets.all(20),
          elevation: 5,
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image(
                    image: AssetImage(imageUrl),
                    height: 100,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Fill up the form below',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelText: 'Full Name',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
                TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelText: 'Purok No.',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelText: 'Date of Birth',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.multiline,
                  minLines: 5,
                  maxLines: 5,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelText: _othersLabel,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, OutputCodeScreenRoute,
                            arguments: OutputCodeScreen(
                              code: getRandomString(8),
                            )),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(15),
                      primary: Theme.of(context).accentColor,
                    ),
                    child: Text('SUBMIT'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
