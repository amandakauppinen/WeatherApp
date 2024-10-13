import 'dart:convert';

import 'package:weather_app/data/models/five_day_weather_model.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/data/providers/weather_api.dart';

/// Handles converting received raw weather data as parsed data models
class WeatherRepository {
  final WeatherAPI weatherAPI = WeatherAPI();

  WeatherRepository();

  /// Returns current weather given [city]
  Future<WeatherModel?> getWeatherForCity(String city) async {
    String? rawWeather = await weatherAPI.getRawWeatherForCity(city);
    if (rawWeather != null) return WeatherModel.fromJson(jsonDecode(rawWeather));
    return null;
  }

  /// Returns 5-day weather given [city]
  Future<FiveDayWeatherModel?> getFiveDayWeatherForCity(String city) async {
    String? rawWeather = await weatherAPI.getRawFiveDayWeatherForCity(city);
    if (rawWeather != null) return FiveDayWeatherModel.fromJson(jsonDecode(rawWeather));
    return null;
  }
}
