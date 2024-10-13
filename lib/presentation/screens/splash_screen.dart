import 'package:flutter/material.dart';
import 'package:weather_app/constants/strings.dart';
import 'package:weather_app/presentation/screens/app_setup.dart';
import 'package:weather_app/presentation/screens/home_screen.dart';
import 'package:weather_app/utils.dart';

/// Handles initial app launch - navigates to either home screen or app setup
class SplashScreen extends StatelessWidget {
  static const String routeName = 'SplashScreen';

  const SplashScreen({super.key});

  Future<void> _checkSignIn(BuildContext context) async {
    await Utils.getSharedPrefs().then((sharedPref) {
      if (sharedPref.getBool(Strings.appSetupKey) ?? true) {
        Navigator.pushNamed(context, AppSetup.routeName);
      } else {
        Navigator.pushNamed(context, HomeScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _checkSignIn(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const <Widget>[
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
