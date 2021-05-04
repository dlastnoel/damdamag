import 'package:damdamag/screens/services_form/services_form_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/routes/routing_constants.dart';

Widget mainTitle(BuildContext context, String text) {
  return Container(
    color: Theme.of(context).primaryColor,
    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget servicesTile(IconData icon, String text, BuildContext context,
    String formType, String imageUrl) {
  return ConstrainedBox(
    constraints: const BoxConstraints(minWidth: double.infinity),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(15),
        ),
        onPressed: () => Navigator.pushNamed(
          context,
          ServicesFormScreenRoute,
          arguments: ServicesFormScreen(
            title: text,
            formType: formType,
            imageUrl: imageUrl,
          ),
        ),
        icon: Icon(
          icon,
          size: 35,
        ),
        label: Text(
          text,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    ),
  );
}
