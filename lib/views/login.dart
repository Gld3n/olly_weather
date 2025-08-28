import 'package:flutter/material.dart';
import 'package:olly_weather/constants.dart';
import 'package:olly_weather/viewmodels/weather.dart';
import 'package:olly_weather/services/weather.dart';
import 'package:olly_weather/views/weather.dart';
import 'package:olly_weather/widgets/action_button.dart';
import 'package:olly_weather/widgets/weather_scaffold.dart';

class LoginView extends StatefulWidget {
  final String title;
  final String apiKey;

  const LoginView({super.key, required this.title, required this.apiKey});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _error;

  void _login() {
    if (_usernameController.text != 'olly' ||
        _passwordController.text != 'weather123') {
      setState(() => _error = 'Thou shalt not pass.');
      return;
    }

    setState(() => _error = null);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WeatherView(
          title: widget.title,
          weatherViewModel: WeatherViewModel(WeatherService(widget.apiKey)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WeatherScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 400,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: WeatherGradients.kDefaultWeatherGradient,
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 225, 225, 225),
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: SizedBox(
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        hint: Text(
                          'ex: DarthV_42',
                          style: TextStyle(
                            color: WeatherColors.kDefaultPrimaryColor,
                          ),
                        ),
                        labelText: 'Username',
                        labelStyle: TextStyle(
                          color: WeatherColors.kDefaultPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        contentPadding: const EdgeInsets.all(16.0),
                        filled: true,
                        fillColor: WeatherColors.kDefaultContainerColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide.none, // Removes the border line
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hint: Text(
                          'ex: Padme123',
                          style: TextStyle(
                            color: WeatherColors.kDefaultPrimaryColor,
                          ),
                        ),
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: WeatherColors.kDefaultPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        contentPadding: const EdgeInsets.all(16.0),
                        filled: true,
                        fillColor: WeatherColors.kDefaultContainerColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide.none, // Removes the border line
                        ),
                      ),
                    ),
                    if (_error != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ActionButton(label: 'Login', onPressed: _login),
          ],
        ),
      ),
    );
  }
}
