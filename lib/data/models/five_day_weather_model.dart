import 'package:weather_app/constants/strings.dart';
import 'package:weather_app/data/models/weather_model.dart';

/// Handles parsing of received 5-day weather data
///   Takes a [city] and a list of [weather] items for the 5 days
class FiveDayWeatherModel {
  String? city;
  List<List<WeatherModel>>? weather;

  FiveDayWeatherModel({this.city, this.weather});

  FiveDayWeatherModel.fromJson(Map<String, Object?> json) {
    List<dynamic>? fullItems = json[Strings.listKey] as List<dynamic>?;

    Map<String, dynamic>? cityMap = json[Strings.cityKey] as Map<String, dynamic>?;
    if (cityMap != null) city = cityMap[Strings.nameKey] as String?;

    int? previousDay;
    List<List<WeatherModel>> fiveDayWeather = [];
    if (fullItems != null && fullItems.isNotEmpty) {
      List<WeatherModel> dayWeather = [];
      for (Map<String, dynamic> item in fullItems) {
        int currentDay = (DateTime.fromMillisecondsSinceEpoch(item[Strings.dtKey] * 1000)).day;
        previousDay ??= currentDay;
        if (currentDay != previousDay) {
          fiveDayWeather.add(List.from(dayWeather));
          previousDay = currentDay;
          dayWeather.clear();
        }
        dayWeather.add(WeatherModel.fromJson(item));
      }
    }
    weather = fiveDayWeather;
  }
}
