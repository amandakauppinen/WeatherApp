import 'package:weather_app/constants/strings.dart';
import 'package:http/http.dart' as http;

/// Handles sending the HTTP request to the OpenWeatherMap API and receiving the raw data
class WeatherAPI {
  Future<String?> getRawWeatherForCity(String city) async {
    return await _sendHttpRequest(city, Strings.weatherKey);
  }

  Future<String?> getRawFiveDayWeatherForCity(String city) async {
    return await _sendHttpRequest(city, Strings.queryForecast);
  }

  Future<String?> _sendHttpRequest(String city, String endpoint) async {
    final String weatherAPIKey = Strings.weatherAPIKey;

    Uri uri = Uri(
      scheme: Strings.uriScheme,
      host: Strings.apiBaseUrl,
      path: "${Strings.apiPath}$endpoint",
      queryParameters: {
        Strings.queryParam: city,
        Strings.queryAppKey: weatherAPIKey,
        Strings.queryUnitsKey: Strings.metric,
      },
    );

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }
}
