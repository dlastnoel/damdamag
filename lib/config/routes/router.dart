import 'package:damdamag/screens/contact_details/contact_details_screen.dart';
import 'package:flutter/material.dart';

import 'routing_constants.dart';

import '../../screens/tabscreen/tab_screen.dart';
import '../../screens/preferences/preferences_screen.dart';
import '../../screens/weather_forecast/weather_forecast_screen.dart';
import '../../screens/covid_cases/covid_cases_screen.dart';
import '../../screens/services_form/services_form_screen.dart';
import '../../screens/input_code/input_code_screen.dart';
import '../../screens/output_code/output_code_screen.dart';
import '../../screens/request_status/request_status_screen.dart';
import '../../screens/contact_details/contact_details_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => TabScreen());
    case PreferencesScreenRoute:
      return MaterialPageRoute(builder: (context) => PreferencesScreen());
    case WeatherForecastScreenRoute:
      return MaterialPageRoute(builder: (context) => WeatherForecastScreen());
    case CovidCasesScreenRoute:
      return MaterialPageRoute(builder: (context) => CovidCasesScreen());
    case ServicesFormScreenRoute:
      final ServicesFormScreen serviceFormArgs = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => ServicesFormScreen(
          title: serviceFormArgs.title,
          formType: serviceFormArgs.formType,
          imageUrl: serviceFormArgs.imageUrl,
        ),
      );
    case InputCodeScreenRoute:
      return MaterialPageRoute(builder: (context) => InputCodeScreen());
    case OutputCodeScreenRoute:
      final OutputCodeScreen outputCodeArgs = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => OutputCodeScreen(
          code: outputCodeArgs.code,
        ),
      );
    case RequestStatusScreenRoute:
      final RequestStatusScreen requestStatusArgs = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => RequestStatusScreen(
                code: requestStatusArgs.code,
              ));
    case ContactDetailsScreenRoute:
      final ContactDetailsScreen contactDetailsArgs = settings.arguments;
      return MaterialPageRoute(
          builder: (context) =>
              ContactDetailsScreen(id: contactDetailsArgs.id));
    default:
      return MaterialPageRoute(builder: (context) => TabScreen());
  }
}
