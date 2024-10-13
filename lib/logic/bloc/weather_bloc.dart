import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/models/five_day_weather_model.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/data/respositories/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

/// BLoC for handling weather events and state
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({
    required this.weatherRepository,
  }) : super(const WeatherState()) {
    on<GetWeather>(_mapGetWeatherEventToState);
  }

  // Checks
  void _mapGetWeatherEventToState(GetWeather event, Emitter<WeatherState> emit) async {
    emit(state.copyWith(status: WeatherStatusEnum.loading));
    if (event.city != null) {
      bool currentWeather = event.currentWeather;
      try {
        // Get current or 5-day weather data model
        final weather = currentWeather
            ? await weatherRepository.getWeatherForCity(event.city!)
            : await weatherRepository.getFiveDayWeatherForCity(event.city!);
        // Update weather status and values
        emit(
          state.copyWith(
              status: WeatherStatusEnum.success,
              fiveDayWeather: currentWeather ? null : weather as FiveDayWeatherModel,
              weather: currentWeather ? weather as WeatherModel : null),
        );
      } catch (error) {
        if (kDebugMode) {
          print(error);
        }
        emit(state.copyWith(status: WeatherStatusEnum.error));
      }
    } else {
      if (kDebugMode) {
        log('City is null', name: 'WeatherBloc._mapGetWeatherEventToState');
      }
      emit(state.copyWith(status: WeatherStatusEnum.error));
    }
  }

  /// Add weather event  to block given [city] and optional [currentWeather] indicator
  void addEvent(String? city, {bool currentWeather = true}) {
    add(GetWeather(city: city, currentWeather: currentWeather));
  }
}
