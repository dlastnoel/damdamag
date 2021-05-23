import 'package:damdamag/screens/request_status/request_status_screen.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:delayed_display/delayed_display.dart';

import '../../config/routes/routing_constants.dart';

class InputCodeScreen extends StatefulWidget {
  @override
  _InputCodeScreenState createState() => _InputCodeScreenState();
}

class _InputCodeScreenState extends State<InputCodeScreen> {
  final TextEditingController codeController = TextEditingController();
  bool _isLoading;

  Future checkinternetConnection() async {
    var connection = await (Connectivity().checkConnectivity());
    setState(() {
      if (connection != ConnectivityResult.none) {
        _isLoading = true;
      } else {
        _isLoading = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      this.checkinternetConnection();
    });
  }

  Widget loadData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Image(
            image: AssetImage('assets/images/code.png'),
            height: 100,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        TextField(
          controller: codeController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            labelText: 'Input your code here',
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        ElevatedButton(
          onPressed: () {
            if (codeController.text.isNotEmpty) {
              Navigator.pushNamed(context, RequestStatusScreenRoute,
                  arguments: RequestStatusScreen(
                    code: codeController.text,
                  ));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Code cannot be empty')));
            }
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(15),
            primary: Theme.of(context).accentColor,
          ),
          child: Text('Check Request'),
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Code'),
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          elevation: 5,
          color: Theme.of(context).primaryColor,
          child: Container(
            padding: const EdgeInsets.all(30),
            height: 300,
            child: _isLoading ? loadData() : loadBlank(),
          ),
        ),
      ),
    );
  }
}
