import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/constants/strings.dart';
import 'package:weather_app/utils.dart';

/// Builds dialog used to change city
class ChangeCityDialog extends StatefulWidget {
  const ChangeCityDialog({super.key});

  @override
  State<ChangeCityDialog> createState() => _ChangeCityDialogState();
}

class _ChangeCityDialogState extends State<ChangeCityDialog> {
  String? selectedCity;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(Strings.selectCity),
        content: FutureBuilder(
            future: Utils.getSharedPrefs(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                selectedCity ??= snapshot.data!.getString(Strings.selectedCityKey);
                if (selectedCity == null) {
                  return Text(Strings.cityError);
                } else {
                  return Column(children: [
                    DropdownButton<String>(
                        value: selectedCity,
                        onChanged: (value) => setState(() => selectedCity = value),
                        items: Strings.availableCities.keys
                            .toList()
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList()),
                    ElevatedButton(
                        onPressed: () async =>
                            _setSharedPref().then((value) => Navigator.pop(context, selectedCity)),
                        child: Text(Strings.submit))
                  ]);
                }
              } else {
                return Text(Strings.cityError);
              }
            }));
  }

  /// Sets city and app setup status in shared preferences
  Future<void> _setSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(Strings.selectedCityKey, selectedCity!);
    await prefs.setString(Strings.selectedCityKey, selectedCity!);
    await prefs.setBool(Strings.appSetupKey, false);
  }
}
