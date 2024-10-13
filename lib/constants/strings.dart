import 'package:weather_app/utils.dart';

/// Class to hold all constant/widely used strings
abstract class Strings {
  // Query strings
  static String weatherAPIKey = ''; // TODO: plugin api key
  static String uriScheme = 'https';
  static String apiBaseUrl = "api.openweathermap.org";
  static String apiPath = "/data/2.5/";
  static String queryParam = 'q';
  static String queryAppKey = 'appId';
  static String queryUnitsKey = 'units';
  static String metric = 'metric';
  static String queryForecast = 'forecast';

  // UI strings
  static String selectCity = 'Select City';
  static String submit = 'Submit';
  static String cityError = 'Error retrieving city';
  static String dataError = 'Error retrieving data';
  static String weather = 'Weather';
  static String fiveDayWeatherButton = 'View 5-day forecast';
  static String changeCityButton = 'Change city';
  static String currentTemp = 'Current temperature';
  static String currentWeather = 'Currently the weather is';
  static String daylightHours = 'Daylight hours';
  static String windSpeed = 'Wind speed';
  static String windGust = 'Wind gust';

  // Shared prefs keys
  static String appSetupKey = 'appSetup';
  static String selectedCityKey = 'selectedCity';

  // Data keys
  static String assetPath = 'assets/images/';
  static String weatherKey = 'weather';
  static String listKey = 'list';
  static String cityKey = 'city';
  static String nameKey = 'name';
  static String dtKey = 'dt';
  static String mainKey = 'main';
  static String tempKey = 'tempKey';
  static String feelsLikeKey = 'feels_like';

  // Follows format of city:country
  static Map<String, String> availableCities = {
    'Helsinki': 'FI',
    'New York': 'US',
    'Osaka': 'JP',
    'Sydney': 'AU'
  };

  /// Returns greeting based on local time
  static String getGreeting() {
    CurrentTimeOfDay timeOfDay = Utils.getTime();
    switch (timeOfDay) {
      case CurrentTimeOfDay.morning:
        return 'Good Morning!';
      case CurrentTimeOfDay.afternoon:
        return 'Good Afternoon!';
      case CurrentTimeOfDay.evening:
        return 'Good Evening!';
      case CurrentTimeOfDay.defaultTime:
        return 'Welcome!';
    }
  }

  /// Returns weekday string - not localised
  static String getWeekday(int? weekDay) {
    switch (weekDay) {
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return 'Monday';
    }
  }

  /// Returns formatted hour/minute string
  static String getTime(DateTime dateTime) {
    return '${dateTime.hour}.${dateTime.minute}';
  }
}
