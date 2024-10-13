import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/constants/strings.dart';
import 'package:weather_app/logic/bloc/weather_bloc.dart';
import 'package:weather_app/presentation/screens/home_screen.dart';
import 'package:weather_app/presentation/widgets/custom_scaffold.dart';

/// Called when app setup has not been done previously
///
/// Sets the selected city to show weather for on app startup
class AppSetup extends StatefulWidget {
  static const String routeName = 'AppSetup';

  const AppSetup({super.key});

  @override
  State<AppSetup> createState() => _AppSetupState();
}

class _AppSetupState extends State<AppSetup> {
  String? selectedCity;
  List<String> availableCities = Strings.availableCities.keys.toList();

  @override
  Widget build(BuildContext context) {
    selectedCity ??= availableCities.first;

    return CustomScaffold(
        body: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(Strings.selectCity),

      /// City selection dropdown
      DropdownButton<String>(
          value: selectedCity,
          onChanged: (value) => setState(() => selectedCity = value),
          items: availableCities.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList()),

      /// Submit button
      ElevatedButton(
          onPressed: () async => _setSharedPref().then((value) {
                final WeatherBloc bloc = BlocProvider.of<WeatherBloc>(context);
                bloc.add(GetWeather(city: selectedCity));
                Navigator.of(context).pushNamed(HomeScreen.routeName);
              }),
          child: Text(Strings.submit))
    ])));
  }

  /// Sets values in shared preferences
  Future<void> _setSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(Strings.selectedCityKey, selectedCity!);
    await prefs.setString(Strings.selectedCityKey, selectedCity!);
    await prefs.setBool(Strings.appSetupKey, false);
  }
}
