import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/themes/theme_provider.dart';

import 'config/routes/router.dart' as router;
import 'config/routes/routing_constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            title: 'Damdamg',
            theme: notifier.darkTheme ? dark : light,
            onGenerateRoute: router.generateRoute,
            initialRoute: HomeScreenRoute,
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Damdamag'),
      ),
      body: Container(
        child: Center(
          child: Text('Damdamag Home Page'),
        ),
      ),
    );
  }
}
