import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/constants/strings.dart';
import 'package:weather_app/data/models/five_day_weather_model.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/logic/bloc/weather_bloc.dart';
import 'package:weather_app/presentation/widgets/custom_scaffold.dart';
import 'package:weather_app/presentation/widgets/padded_widget.dart';
import 'package:weather_app/presentation/widgets/weather_box.dart';
import 'package:weather_app/utils.dart';

/// Builds UI for showing a 5-day weather forecast for a retrieved city
class FiveDayWeatherScreen extends StatefulWidget {
  static const String routeName = 'FiveDayWeatherScreen';

  const FiveDayWeatherScreen({super.key});

  @override
  State<FiveDayWeatherScreen> createState() => _FiveDayWeatherScreenState();
}

class _FiveDayWeatherScreenState extends State<FiveDayWeatherScreen> {
  String? city;

  @override
  Widget build(BuildContext context) {
    final WeatherModel? currentWeather =
        ModalRoute.of(context)!.settings.arguments as WeatherModel?;
    if (currentWeather == null && kDebugMode) {
      log('Weather is null', name: '_FiveDayWeatherScreenState.build');
    }

    return currentWeather == null
        ? Center(child: Text(Strings.dataError))
        : FutureBuilder(
            future: Utils.getSharedPrefs(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                city ??= snapshot.data!.getString(Strings.selectedCityKey);
                return city == null
                    ? Center(child: Text(Strings.cityError))
                    : BlocBuilder<WeatherBloc, WeatherState>(
                        buildWhen: (previous, current) => current.status.isSuccess,
                        builder: (blocContext, state) {
                          FiveDayWeatherModel? fiveDayWeather = state.fiveDayWeather;
                          if (fiveDayWeather?.weather != null && fiveDayWeather!.weather != null) {
                            switch (state.status) {
                              case WeatherStatusEnum.error:
                                return Center(child: Text(Strings.dataError));
                              case WeatherStatusEnum.loading:
                                return const Center(child: CircularProgressIndicator());
                              case WeatherStatusEnum.success:
                                return CustomScaffold(
                                    category: currentWeather.category,
                                    body: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 16),
                                              child: Padding(
                                                  padding: const EdgeInsets.all(8),
                                                  child: Column(children: [
                                                    PaddedWidget(
                                                        Text('${Strings.currentTemp}:',
                                                            style: const TextStyle(fontSize: 20)),
                                                        bottom: 8),
                                                    VerticalPaddedWidget(
                                                        Text('${currentWeather.temp}°C',
                                                            style: const TextStyle(fontSize: 40)),
                                                        8),
                                                    Utils.getWeatherIcon(currentWeather.category,
                                                        iconSize: 48)
                                                  ]))),
                                          for (List<WeatherModel> dayWeather
                                              in fiveDayWeather.weather!)
                                            Expanded(
                                                child: VerticalPaddedWidget(
                                                    Row(children: [
                                                      PaddedWidget(
                                                          SizedBox(
                                                              width: 80,
                                                              child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment.center,
                                                                  children: [
                                                                    PaddedWidget(
                                                                        Text(Strings.getWeekday(
                                                                            dayWeather
                                                                                .first
                                                                                .forecastTime
                                                                                ?.weekday)),
                                                                        bottom: 4),
                                                                    Text(
                                                                        '${dayWeather.first.forecastTime?.day}.${dayWeather.first.forecastTime?.month}',
                                                                        style: const TextStyle(
                                                                            fontSize: 16))
                                                                  ])),
                                                          right: 6),
                                                      Expanded(
                                                          child: ListView(
                                                              scrollDirection: Axis.horizontal,
                                                              shrinkWrap: true,
                                                              children: [
                                                            for (WeatherModel weather in dayWeather)
                                                              InkWell(
                                                                  onTap: () => {},
                                                                  child: HorizontalPaddedWidget(
                                                                      WeatherBox(weather: weather),
                                                                      4))
                                                          ]))
                                                    ]),
                                                    8))
                                        ]));
                            }
                          } else {
                            return Center(child: Text(Strings.dataError));
                          }
                        });
              } else {
                return Text(Strings.cityError);
              }
            });
  }
}
