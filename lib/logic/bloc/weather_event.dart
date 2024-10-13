part of 'weather_bloc.dart';

/// Handles weather event props
class WeatherEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetWeather extends WeatherEvent {
  final String? city;
  final bool currentWeather;

  GetWeather({this.city, this.currentWeather = true});
}
