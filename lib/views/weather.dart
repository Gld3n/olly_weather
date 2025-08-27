import 'package:flutter/material.dart';
import 'package:olly_weather/viewmodels/weather.dart';
import 'package:olly_weather/constants.dart';
import 'package:olly_weather/widgets/action_button.dart';
import 'package:olly_weather/widgets/weather_scaffold.dart';

class WeatherView extends StatelessWidget {
  final WeatherViewModel weatherViewModel;
  final String title;

  const WeatherView({
    super.key,
    required this.title,
    required this.weatherViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return WeatherScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListenableBuilder(
              listenable: weatherViewModel,
              builder: (context, child) {
                final weatherData = weatherViewModel.weather;

                final conditionText = weatherData?.conditionText ?? '';
                final tempC = weatherData?.tempC ?? 20.0;
                final weekday = _getCurrentWeekday(DateTime.now());
                final (primaryColor, containerColor, gradient) =
                    _pickColorTheme(conditionText, tempC);

                if (weatherViewModel.loading) {
                  return const CircularProgressIndicator(
                    color: WeatherColors.kDefaultPrimaryColor,
                  );
                }

                return ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 300,
                    maxWidth: 600,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: gradient,
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 225, 225, 225),
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildMainWeatherInfoCard(
                          primaryColor: primaryColor,
                          containerColor: containerColor,
                          weekday: weekday,
                          context: context,
                        ),
                        SizedBox(height: 12),
                        buildExtraWeatherInfoCard(
                          primaryColor: primaryColor,
                          containerColor: containerColor,
                          weatherViewModel: weatherViewModel,
                          context: context,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16,
              children: [
                ActionButton(
                  label: 'Update Weather',
                  onPressed: () {
                    weatherViewModel.getWeather();
                  },
                ),
                ActionButton(
                  label: 'Log out',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMainWeatherInfoCard({
    required Color primaryColor,
    required Color containerColor,
    required String weekday,
    required BuildContext context,
  }) {
    return SizedBox(
      height: 150,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Card(
        color: containerColor,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.thermostat, color: primaryColor, size: 36),
                  Text(
                    '${weatherViewModel.weather?.tempC ?? '--'} °C / ${weatherViewModel.weather?.tempF ?? '--'} °F',
                    style: TextStyle(fontSize: 36, color: primaryColor),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on, color: primaryColor, size: 18),
                      Text(
                        weatherViewModel.weather?.country ?? 'Wakanda',
                        style: TextStyle(fontSize: 16, color: primaryColor),
                      ),
                    ],
                  ),
                  Text(
                    weekday,
                    style: TextStyle(fontSize: 16, color: primaryColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildExtraWeatherInfoCard({
    required Color primaryColor,
    required Color containerColor,
    required WeatherViewModel weatherViewModel,
    required BuildContext context,
  }) {
    String conditionIcon = weatherViewModel.weather?.conditionIcon ?? '';
    Image weatherImage = conditionIcon.isNotEmpty
        ? Image.network(
            'https:$conditionIcon',
            width: 64,
            height: 64,
            fit: BoxFit.contain,
          )
        : const Image(
            image: AssetImage('assets/default_weather_icon.png'),
            height: 48,
            width: 48,
            fit: BoxFit.contain,
          );

    return SizedBox(
      height: 300,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Card(
        color: containerColor,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      weatherImage,
                      const SizedBox(height: 16),
                      Text(
                        weatherViewModel.weather?.conditionText ??
                            'Cloudy with a 99.9% chance of getting hired.', //* Yeah, I did in fact hardcode this.
                        style: TextStyle(
                          fontSize: 18,
                          color: primaryColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: WeatherExtraInfoContent(
                  primaryColor: primaryColor,
                  weatherViewModel: weatherViewModel,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

(Color, Color, LinearGradient) _pickColorTheme(
  String conditionText,
  double tempC,
) {
  if (conditionText.toLowerCase().contains('rain') ||
      conditionText.toLowerCase().contains('cloud')) {
    return (
      WeatherColors.kRainyPrimaryColor,
      WeatherColors.kRainyContainerColor,
      WeatherGradients.kRainyWeatherGradient,
    );
  } else if (tempC > 25) {
    return (
      WeatherColors.kWarmPrimaryColor,
      WeatherColors.kWarmContainerColor,
      WeatherGradients.kWarmWeatherGradient,
    );
  } else if (tempC < 15) {
    return (
      WeatherColors.kColdPrimaryColor,
      WeatherColors.kColdContainerColor,
      WeatherGradients.kColdWeatherGradient,
    );
  } else {
    return (
      WeatherColors.kDefaultPrimaryColor,
      WeatherColors.kDefaultContainerColor,
      WeatherGradients.kDefaultWeatherGradient,
    );
  }
}

String _getCurrentWeekday(DateTime date) {
  const weekdays = {
    1: 'Monday',
    2: 'Tuesday',
    3: 'Wednesday',
    4: 'Thursday',
    5: 'Friday',
    6: 'Saturday',
    7: 'Sunday',
  };
  return weekdays[date.weekday] ?? '';
}

class WeatherExtraInfoContent extends StatelessWidget {
  final Color primaryColor;
  final WeatherViewModel weatherViewModel;

  const WeatherExtraInfoContent({
    super.key,
    required this.primaryColor,
    required this.weatherViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 400;
        final weatherData = weatherViewModel.weather;

        final feelsLikeC = weatherData?.feelsLikeC ?? '--';
        final feelsLikeF = weatherData?.feelsLikeF ?? '--';
        final windDegree = weatherData?.windDegree ?? '--';
        final windMph = weatherData?.windMph ?? '--';
        final humidity = weatherData?.humidityPercentage ?? '--';

        final children = [
          _buildWeatherInfoText('Feels like: $feelsLikeC°C / $feelsLikeF°F'),
          _buildWeatherInfoText('Wind degree: $windDegree°'),
          _buildWeatherInfoText('Wind: $windMph mph'),
          _buildWeatherInfoText('Humidity: $humidity%'),
        ];

        return isWide
            ? GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
                childAspectRatio: 3.5,
                shrinkWrap: true,
                children: children,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: children,
              );
      },
    );
  }

  Widget _buildWeatherInfoText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: primaryColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
