import 'package:flutter/foundation.dart';
import 'package:olly_weather/models/weather.dart';
import 'package:olly_weather/services/weather.dart';

class WeatherViewModel extends ChangeNotifier {
  Weather? weather;
  String? errorMessage;
  bool loading = false;
  WeatherService _weatherService;

  WeatherViewModel(this._weatherService);

  Future<void> getWeather() async {
    loading = true;
    notifyListeners();

    try {
      weather = await _weatherService.getWeather();
    } catch (e) {
      errorMessage = e.toString();
    }

    loading = false;
    notifyListeners();
  }
}
