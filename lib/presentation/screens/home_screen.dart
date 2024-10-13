import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/constants/strings.dart';
import 'package:weather_app/logic/bloc/weather_bloc.dart';
import 'package:weather_app/presentation/screens/five_day_weather_screen.dart';
import 'package:weather_app/presentation/widgets/change_city_dialog.dart';
import 'package:weather_app/presentation/widgets/padded_widget.dart';
import 'package:weather_app/presentation/widgets/weather_widget.dart';
import 'package:weather_app/utils.dart';

/// Builds default home screen with customised message and current weather for
/// chosen city
class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    String? city;
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return FutureBuilder(
        future: Utils.getSharedPrefs(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            city ??= snapshot.data!.getString(Strings.selectedCityKey);
            if (city == null) {
              return Text(Strings.cityError);
            } else {
              // Add new weather event
              weatherBloc.addEvent(city);
              return CurrentWeatherWidget(
                widgets: [
                  PaddedWidget(
                      Row(children: [
                        Expanded(
                            child: ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.black)),
                                onPressed: () {
                                  weatherBloc.addEvent(city, currentWeather: false);
                                  Navigator.pushNamed(context, FiveDayWeatherScreen.routeName,
                                      arguments: weatherBloc.state.weather);
                                },
                                child: Text(Strings.fiveDayWeatherButton))),
                        const Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                        Expanded(
                            child: ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.black)),
                                onPressed: () async {
                                  final result = await showDialog(
                                      context: context,
                                      builder: (dialogContext) => const ChangeCityDialog());
                                  if (result != null) {
                                    weatherBloc.addEvent(result as String);
                                  }
                                },
                                child: Text(Strings.changeCityButton)))
                      ]),
                      top: 16)
                ],
              );
            }
          } else {
            return Text(Strings.cityError);
          }
        });
  }
}
