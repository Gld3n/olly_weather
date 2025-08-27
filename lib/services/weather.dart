import 'dart:convert';

import 'package:olly_weather/helpers/location.dart';
import 'package:olly_weather/models/weather.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather() async {
    if (apiKey.isEmpty) {
      throw Exception('weather_service: API key is missing');
    }

    final baseUrl = 'http://api.weatherapi.com/v1/current.json';

    final (lat, lon) = await _getLocation();

    final uri = Uri.parse('$baseUrl?key=$apiKey&q=$lat,$lon');
    try {
      final response = await http.get(uri);
      if (response.statusCode != 200) {
        throw Exception(
          'weather_service: HTTP ${response.statusCode} - ${response.reasonPhrase}',
        );
      }

      final Map<String, dynamic> data = jsonDecode(response.body);
      return Weather.fromJson(data);
    } on FormatException catch (e) {
      throw Exception('weather_service: Invalid JSON format | ${e.message}');
    } on http.ClientException catch (e) {
      throw Exception('weather_service: Network error | ${e.message}');
    } catch (e) {
      throw Exception('weather_service: Unexpected error | $e');
    }
  }

  Future<(double, double)> _getLocation() async {
    final locationData = await LocationHelper.getCurrentLocation();
    if (locationData?.latitude == null || locationData?.longitude == null) {
      throw Exception('location_service: Unable to retrieve location data');
    }
    return (
      locationData!.latitude!.toDouble(),
      locationData.longitude!.toDouble(),
    );
  }
}
