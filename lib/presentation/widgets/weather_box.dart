import 'package:flutter/material.dart';
import 'package:weather_app/constants/strings.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/presentation/widgets/padded_widget.dart';
import 'package:weather_app/utils.dart';

/// Provides stylised box to hold weather info
class WeatherBox extends StatelessWidget {
  final WeatherModel weather;
  final String? title;

  const WeatherBox({super.key, required this.weather, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2.0, color: const Color.fromARGB(255, 116, 116, 116)),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        child: AllPaddedWidget(
            Column(children: [
              Expanded(
                  child: Text(title ?? weather.forecastTime?.hour.toString() ?? Strings.dataError)),
              VerticalPaddedWidget(Utils.getWeatherIcon(weather.category), 4),
              PaddedWidget(Text('${(weather.temp)?.toStringAsFixed(1)}°C'), top: 4)
            ]),
            8));
  }
}
