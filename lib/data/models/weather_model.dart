import 'dart:developer';

import 'package:weather_app/constants/strings.dart';

/// Handles parsing of received weather data
class WeatherModel {
  String? city;
  String? category;
  String? description;
  double? temp;
  double? tempFeelsLike;
  double? tempMin;
  double? tempMax;
  double? windSpeed;
  double? windGust;
  DateTime? sunrise;
  DateTime? sunset;
  DateTime? forecastTime;

  WeatherModel(
      {this.city,
      this.category,
      this.description,
      this.temp,
      this.tempFeelsLike,
      this.tempMin,
      this.tempMax,
      this.windSpeed,
      this.windGust,
      this.sunrise,
      this.sunset,
      this.forecastTime});

  WeatherModel.fromJson(Map<String, Object?> json) {
    city = json['name'] as String?;

    if (json['dt'] != null) {
      forecastTime = DateTime.fromMillisecondsSinceEpoch((json['dt'] as int) * 1000);
    }

    List<dynamic>? weather = json[Strings.weatherKey] as List<dynamic>?;
    if (weather != null && weather.isNotEmpty) {
      category = weather.first['main'] as String?;
      description = weather.first['description'] as String?;
    }

    Map<String, dynamic>? main = json['main'] as Map<String, dynamic>?;
    if (main != null && main.isNotEmpty) {
      try {
        temp = main['temp'] as double?;
        tempFeelsLike = main['feels_like'] as double?;
        tempMin = main['temp_min'] as double?;
        tempMax = main['feels_like'] as double?;
      } catch (error) {
        log('Error parsing data [main]', error: error, name: 'WeatherModel.fromJson');
      }
    }

    Map<String, dynamic>? wind = json['wind'] as Map<String, dynamic>?;
    if (wind != null && wind.isNotEmpty) {
      try {
        windSpeed = wind['speed'] as double?;
        windGust = wind['gust'] as double?;
      } catch (error) {
        log('Error parsing data [wind]', error: error, name: 'WeatherModel.fromJson');
      }
    }

    Map<String, dynamic>? sys = json['sys'] as Map<String, dynamic>?;
    if (sys != null && sys.isNotEmpty) {
      try {
        int? sunriseInt = sys['sunrise'] as int?;
        if (sunriseInt != null) sunrise = DateTime.fromMillisecondsSinceEpoch(sunriseInt * 1000);

        int? sunsetInt = sys['sunset'] as int?;
        if (sunsetInt != null) sunset = DateTime.fromMillisecondsSinceEpoch(sunsetInt * 1000);
      } catch (error) {
        log('Error parsing data [sys]', error: error, name: 'WeatherModel.fromJson');
      }
    }
  }
}
