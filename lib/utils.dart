import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum CurrentTimeOfDay { morning, afternoon, evening, defaultTime }

/// Provides various utility functions
abstract class Utils {
  // Get's shared preferences instance
  static Future<SharedPreferences> getSharedPrefs() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    return sharedPref;
  }

  /// Returns [CurrentTimeOfDay] enum based on current time
  static CurrentTimeOfDay getTime() {
    int hour = DateTime.now().hour;
    if (hour <= 12) {
      return CurrentTimeOfDay.morning;
    } else if (hour <= 18) {
      return CurrentTimeOfDay.afternoon;
    } else if (hour <= 24) {
      return CurrentTimeOfDay.evening;
    } else {
      return CurrentTimeOfDay.defaultTime;
    }
  }

  /// Returns weather icon depending on weather [category]
  static Icon getWeatherIcon(String? category, {double? iconSize}) {
    if (category != null) category = category.toUpperCase();
    switch (category) {
      case 'CLOUDS':
        return Icon(Icons.wb_cloudy, size: iconSize);
      case 'SNOW':
        return Icon(Icons.cloudy_snowing, size: iconSize);
      case 'RAIN':
        return Icon(Icons.water_drop, size: iconSize);
      default:
        return Icon(Icons.sunny, size: iconSize);
    }
  }
}
