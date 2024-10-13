import 'package:flutter/material.dart';
import 'package:weather_app/constants/strings.dart';

/// Provides stylised scaffolding throughout app
class CustomScaffold extends StatelessWidget {
  final Color color;
  final Widget body;
  final String? category;

  const CustomScaffold({super.key, required this.body, this.color = Colors.blue, this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: _getBackground(category),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: body)));
  }

  /// Sets custom background depending on current weather
  AssetImage _getBackground(String? category) {
    if (category != null) category = category.toUpperCase();
    String assetName = Strings.assetPath;

    switch (category) {
      case 'CLOUDS':
        assetName += 'background_clouds.png';
        break;
      case 'SNOW':
        assetName += 'background_snow.png';
        break;
      case 'RAIN':
        assetName += 'background_rain.png';
        break;
      default:
        assetName += 'background_sun.png';
        break;
    }
    return AssetImage(assetName);
  }
}
