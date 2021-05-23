import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../config/routes/routing_constants.dart';

class RequestStatusScreen extends StatefulWidget {
  final String code;

  RequestStatusScreen({this.code});

  @override
  _RequestStatusScreenState createState() => _RequestStatusScreenState();
}

class _RequestStatusScreenState extends State<RequestStatusScreen> {
  String _type = '';
  String _status = '';
  String _imageUrl = '';
  String _content = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      this.fetchRequest();
    });
  }

  Future fetchRequest() async {
    setState(() {
      isLoading = true;
    });
    String url =
        'http://192.168.1.80:8000/api/requests/' + widget.code.toString();
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var results = json.decode(response.body);
      setState(() {
        switch (results['type']) {
          case 'clearance':
            _type = 'barangay clearance';
            break;
          case 'indigency':
            _type = 'certificate of indigency';
            break;
          case 'blotter':
            _type = 'request for blotter';
            break;
          case 'lsi':
            _type = 'lsi';
            break;
        }
        _type = results['type'];
        _status = results['status'];
        if (_type != 'lsi') {
          switch (_status) {
            case 'pending':
              _content = 'Your ' +
                  _type +
                  ' is still on process. Kindly wait for some time and check your status again. Thank you!';
              _imageUrl = 'assets/images/pending.png';
              break;
            case 'ready':
              _content = 'Your ' +
                  _type +
                  ' is ready to release. Claim it during office hours at the Barangay Hall. Thank you!';
              break;
            case 'completed':
              _content = 'This request was already completed.';
              _imageUrl = 'assets/images/ready.png';
              break;
            default:
              _content =
                  'Request not found. Double check your code and try to re enter again. Thank you!';
              _imageUrl = 'assets/images/error.png';
              break;
          }
        } else {
          switch (_status) {
            case 'pending':
              _content = results['full_name'] +
                  ', please wait for some time regarding your concern of returning to the town of Rosario, La Union. Check your request again some other time. Thank you!';
              _imageUrl = 'assets/images/pending.png';
              break;
            case 'ready':
              _content = results['full_name'] +
                  ' may now enter the vicinity of Rosario La Union. However, you are obliged to stay under home quarantine for a week or 2. Present this screenshot to barangay officials if necessary. Thank you!';
              _imageUrl = 'assets/images/ready.png';
              break;
            case 'completed':
              _content = 'This request was already completed.';
              _imageUrl = 'assets/images/ready.png';
              break;
            default:
              _content =
                  'Request not found. Double check your code and try to re enter again. Thank you!';
              _imageUrl = 'assets/images/error.png';
              break;
          }
          isLoading = false;
        }
      });
    } else {
      isLoading = false;
    }
  }

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
                    image: AssetImage(_imageUrl),
                    height: 80,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Text(
                    _content != null ? _content : '',
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
