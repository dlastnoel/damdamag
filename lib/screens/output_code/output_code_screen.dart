import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OutputCodeScreen extends StatelessWidget {
  final String code;

  OutputCodeScreen({this.code});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Output Code'),
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          elevation: 5,
          color: Theme.of(context).primaryColor,
          child: Container(
            padding: const EdgeInsets.all(30),
            height: 300,
            child: Column(
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
                InkWell(
                  onTap: () {
                    Clipboard.setData(new ClipboardData(text: code));
                    final snackBar = SnackBar(
                      content: Text('Text copied to clipboard!'),
                      action: SnackBarAction(
                        label: 'Dismiss',
                        onPressed: () =>
                            ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Card(
                      elevation: 5,
                      color: Theme.of(context).accentColor,
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          code,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () => print('Hello World'),
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(15),
                      primary: Theme.of(context).accentColor,
                      elevation: 5),
                  child: Text('Check Request'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
