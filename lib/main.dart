import 'package:flutter/material.dart';
import 'package:olly_weather/views/login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final String apiKey = dotenv.env['API_KEY'] ?? '';

  @override
  Widget build(BuildContext context) {
    final String title = 'Olly Weather';

    if (apiKey.isEmpty) {
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text(
              'API key is missing. Please provide it via a .env file.',
            ),
          ),
        ),
      );
    }

    return MaterialApp(
      title: title,
      home: LoginView(title: title, apiKey: apiKey),
    );
  }
}
