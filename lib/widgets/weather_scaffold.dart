import 'package:flutter/material.dart';
import 'package:olly_weather/constants.dart';

class WeatherScaffold extends StatelessWidget {
  final Widget child;
  final Widget? leading;

  const WeatherScaffold({super.key, required this.child, this.leading});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: WeatherColors.kDefaultContainerColor,
        centerTitle: true,
        toolbarHeight: 75,
        leading: leading ?? Container(),
        title: Text(
          'Olly Weather',
          style: TextStyle(
            color: WeatherColors.kDefaultPrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
      ),
      body: child,
    );
  }
}
