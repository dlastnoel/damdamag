import 'package:flutter/material.dart';
import '../../config/routes/routing_constants.dart';

class RequestStatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Status'),
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
                    image: AssetImage('assets/images/ready.png'),
                    height: 80,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Text(
                    'Your barangay clearance is ready to release. Claim it during office hours at the Barangay Hall. Thank you!',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () =>
                      Navigator.popAndPushNamed(context, HomeScreenRoute),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(15),
                    primary: Theme.of(context).accentColor,
                  ),
                  child: Text('Back to Home'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
