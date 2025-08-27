import 'package:flutter/material.dart';

class WeatherColors {
  static const kWarmPrimaryColor = Color.fromARGB(255, 255, 133, 57);
  static const kWarmContainerColor = Color.fromARGB(255, 255, 236, 219);

  static const kColdPrimaryColor = Color.fromARGB(255, 26, 182, 255);
  static const kColdContainerColor = Color.fromARGB(255, 213, 242, 255);

  static const kRainyPrimaryColor = Color.fromARGB(255, 102, 112, 121);
  static const kRainyContainerColor = Color.fromARGB(255, 229, 234, 237);

  static const kDefaultPrimaryColor = Color.fromARGB(255, 127, 212, 255);
  static const kDefaultContainerColor = Color.fromARGB(255, 228, 245, 255);
}

class WeatherGradients {
  static const kWarmWeatherGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 255, 199, 114),
      WeatherColors.kWarmPrimaryColor,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const kColdWeatherGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 212, 242, 255),
      WeatherColors.kColdPrimaryColor,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const kRainyWeatherGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 194, 205, 213),
      WeatherColors.kRainyPrimaryColor,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const kDefaultWeatherGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 213, 241, 255),
      WeatherColors.kDefaultPrimaryColor,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
