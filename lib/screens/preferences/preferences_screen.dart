import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/themes/theme_provider.dart';

class PreferencesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Preferences"),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Consumer<ThemeNotifier>(
                  builder: (context, notifier, child) => SwitchListTile(
                    title: Text("Dark Mode"),
                    onChanged: (value) {
                      notifier.toggleTheme();
                    },
                    value: notifier.darkTheme,
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text(
                        "Damdamag Mobile App v1.0\n\nBarangay Management and Information System\n\nDeveloped by Noel Xavier M. Ulpindo (May 2021)"),
                  ),
                ),
              ]),
        ));
  }
}
