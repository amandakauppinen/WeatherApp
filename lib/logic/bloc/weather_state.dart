part of 'weather_bloc.dart';

enum WeatherStatusEnum { success, loading, error }

extension WeatherStatus on WeatherStatusEnum {
  bool get isSuccess => this == WeatherStatusEnum.success;
  bool get isError => this == WeatherStatusEnum.error;
  bool get isLoading => this == WeatherStatusEnum.loading;
}

/// Handles weather state
class WeatherState extends Equatable {
  final FiveDayWeatherModel? fiveDayWeather;
  final WeatherModel? weather;
  final WeatherStatusEnum status;
  final String? city;

  const WeatherState({
    this.status = WeatherStatusEnum.loading,
    this.fiveDayWeather,
    this.weather,
    this.city,
  });

  @override
  List<Object?> get props => [status, city];

  WeatherState copyWith(
      {WeatherStatusEnum? status,
      String? city,
      FiveDayWeatherModel? fiveDayWeather,
      WeatherModel? weather}) {
    return WeatherState(
        status: status ?? this.status,
        city: city ?? this.city,
        fiveDayWeather: fiveDayWeather ?? this.fiveDayWeather,
        weather: weather ?? this.weather);
  }
}
