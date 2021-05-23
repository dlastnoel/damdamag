import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import '../../config/routes/routing_constants.dart';
import 'package:http/http.dart' as http;
import '../../helpers/helpers.dart';

import '../../models/request.dart';

import '../output_code/output_code_screen.dart';

class ServicesFormScreen extends StatefulWidget {
  final String title;
  final String formType;
  final String imageUrl;

  ServicesFormScreen({this.title, this.formType, this.imageUrl});

  @override
  _ServicesFormScreenState createState() => _ServicesFormScreenState();
}

Future<Request> createRequest(
    type, fullname, purok, dateOfBirth, description) async {
  final response = await http
      .post(Uri.parse('http://192.168.1.80:8000/api/request-create/'), body: {
    'type': type,
    'full_name': fullname,
    'date_of_birth': dateOfBirth,
    'description': description,
    'code': getRandomString(10),
  });

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return requestFromJson(responseString);
  } else {
    return null;
  }
}

class _ServicesFormScreenState extends State<ServicesFormScreen> {
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController purokController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String _othersLabel;
    switch (widget.formType) {
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
        title: Text(widget.title),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image(
                    image: AssetImage(widget.imageUrl),
                    height: 100,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Text(
                    'Fill up the form below',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextFormField(
                  controller: fullnameController,
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
                TextFormField(
                  controller: purokController,
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
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Date of Birth',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                DateTimeField(
                  controller: dateOfBirthController,
                  format: DateFormat("MMMM dd, yyyy"),
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                  },
                ),
                TextFormField(
                  controller: descriptionController,
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
                    onPressed: () async {
                      if (fullnameController.text.isNotEmpty &&
                          purokController.text.isNotEmpty &&
                          dateOfBirthController.text.isNotEmpty &&
                          descriptionController.text.isNotEmpty) {
                        final String fullname = fullnameController.text;
                        final String purok = purokController.text;
                        final String dateOfBirth = dateOfBirthController.text;
                        final String description = descriptionController.text;
                        var request;

                        try {
                          request = await createRequest(widget.formType,
                              fullname, purok, dateOfBirth, description);
                        } catch (error) {
                          request = false;
                        }

                        if (request != false) {
                          Navigator.pushNamed(
                            context,
                            OutputCodeScreenRoute,
                            arguments: OutputCodeScreen(
                              code: request.code,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('No internet connection')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Pleae fill the form correctly.')));
                      }
                    },
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
