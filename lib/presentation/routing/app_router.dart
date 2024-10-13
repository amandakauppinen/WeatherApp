import 'package:flutter/material.dart';
import 'package:weather_app/presentation/screens/app_setup.dart';
import 'package:weather_app/presentation/screens/home_screen.dart';
import 'package:weather_app/presentation/screens/five_day_weather_screen.dart';
import 'package:weather_app/presentation/screens/splash_screen.dart';

/// Manages routing between pages
class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    Widget page;

    switch (routeSettings.name) {
      case AppSetup.routeName:
        page = const AppSetup();
        break;
      case FiveDayWeatherScreen.routeName:
        page = const FiveDayWeatherScreen();
        break;
      case SplashScreen.routeName:
        page = const SplashScreen();
        break;
      default:
        page = const HomeScreen();
        break;
    }
    return MaterialPageRoute(builder: (context) => page, settings: routeSettings);
  }
}
