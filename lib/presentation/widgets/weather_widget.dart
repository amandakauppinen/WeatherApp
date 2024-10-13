import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/constants/strings.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/logic/bloc/weather_bloc.dart';
import 'package:weather_app/presentation/widgets/custom_scaffold.dart';
import 'package:weather_app/presentation/widgets/padded_widget.dart';

/// Builds main widget to show the current weather with optional [title]
/// and [widgets] to appear below
class CurrentWeatherWidget extends StatelessWidget {
  final String? title;
  final List<Widget>? widgets;

  const CurrentWeatherWidget({super.key, this.title, this.widgets});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
        buildWhen: (previous, current) => current.status.isSuccess,
        builder: (blocContext, state) {
          WeatherModel? weather = state.weather;
          if (weather != null) {
            /// Check loading status
            switch (state.status) {
              case WeatherStatusEnum.error:
                return Center(child: Text(Strings.dataError));
              case WeatherStatusEnum.loading:
                return const Center(child: CircularProgressIndicator());
              case WeatherStatusEnum.success:
                return CustomScaffold(
                    category: weather.category,
                    body: Center(
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      if (title == null)
                        VerticalPaddedWidget(
                            Text(Strings.getGreeting(), style: const TextStyle(fontSize: 48)), 12),
                      if (title != null || weather.city != null)
                        VerticalPaddedWidget(
                            Text(title ?? weather.city!, style: const TextStyle(fontSize: 24)), 12),
                      VerticalPaddedWidget(
                          Text(title ?? '${Strings.currentWeather}:',
                              style: const TextStyle(fontSize: 20)),
                          12),
                      VerticalPaddedWidget(
                          Text(
                            weather.temp != null ? '${weather.temp.toString()}°C' : '',
                            style: const TextStyle(fontSize: 40),
                          ),
                          12),
                      if (weather.sunrise != null && weather.sunset != null)
                        _getWeatherRow(
                            Text('${Strings.daylightHours}:'),
                            Text(
                                '${Strings.getTime(weather.sunrise!)} - ${Strings.getTime(weather.sunset!)}')),
                      if (weather.windSpeed != null)
                        _getWeatherRow(
                            Text('${Strings.windSpeed}:'), Text('${weather.windSpeed} m/s')),
                      if (weather.windGust != null)
                        _getWeatherRow(
                            Text('${Strings.windGust}:'), Text('${weather.windGust} m/s')),
                      if (widgets != null) ...widgets!
                    ])));
            }
          } else {
            return Center(child: Text(Strings.dataError));
          }
        });
  }

  /// Returns formatter row with leading/following widgets for consistency
  Widget _getWeatherRow(Widget leadingWidget, Widget followingWidget) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(width: 100, child: PaddedWidget(leadingWidget, right: 8)),
      followingWidget
    ]);
  }
}
