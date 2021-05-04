import 'package:flutter/material.dart';

import '../../config/routes/routing_constants.dart';

import './components/services_components.dart';

class ServicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        mainTitle(context, 'Barangay Poblacion West at your service!'),
        mainTitle(context, 'How may we help you?'),
        Container(
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, InputCodeScreenRoute),
                child: Text(
                  'I HAVE A CODE',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: 300,
          child: Column(
            children: [
              servicesTile(
                Icons.library_books_outlined,
                'Brgy. Clearance',
                context,
                'clearance',
                'assets/images/clearance.png',
              ),
              servicesTile(
                Icons.bookmarks_outlined,
                'Certificate of Indigency',
                context,
                'indigency',
                'assets/images/indigency.png',
              ),
              servicesTile(
                Icons.cancel_outlined,
                'Blotter Report',
                context,
                'blotter',
                'assets/images/blotter.png',
              ),
              servicesTile(
                  Icons.person_outline_sharp,
                  'Returning Resident / LSI',
                  context,
                  'lsi',
                  'assets/images/lsi.png'),
            ],
          ),
        ),
      ],
    );
  }
}
