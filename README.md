# OllyWeather

Simple weather app built with Flutter using the MVVM architecture.  

## Usage

- Get an API key from [WeatherAPI](https://www.weatherapi.com/)
- Run the project with `flutter run --dart-define="API_KEY=your_api_key"` (or set the `API_KEY` environment variable)
- Login with `user: olly` and `password: weather123` for demo purposes

---

> **TL;DR**: Tried challenging myself with some intermediate Flutter concepts and best practices  
> and left some things on the table for the sake of simplicity and time constraints.

## Implemented practices

- Used const constructors for optimization, as widgets with fixed data can just be compiled once and reused.
- Even though the project scope doesn't demand it, I thought applying the MVVM pattern would be a nice addition for  
better separation of concerns and readability, and I also wanted to challenge myself giving it a try.
- Implemented [pattern matching](https://docs.flutter.dev/cookbook/networking/fetch-data#3-convert-the-response-into-a-custom-dart-object) for the API response, making parsing straightforward.
- Polymorphic widgets (WeatherScaffold, ActionButton) for better code organization and reusability.
- Designed mobile-first and responsive UI using LayoutBuilder and MediaQueries.

## Potential improvements

These are some potential improvements left on the table considering both the scope of the project and the deadline:

- Implement multi-provider support for weather data and apply short-circuiting and fallback mechanisms for better resilience.
- Move Location to its own service, but due to its simplicity, it might be over-engineering for this app.
- Better UI/UX design for a more intuitive user experience and _flashiness_.
- Make a more comprehensive usage of the weather data and improve the overall data presentation.
- Better handle data integrity and default values.
- More comprehensive widget separation and reusability (for example the degree display, location display, login form, etc.). Readability would also improve.
- Currently, the AppBar and Footer pop out when navigating. A better approach would be to have a single Scaffold and change only the body.
- Variables usage and passing through widgets could be improved for better maintainability and reactivity. Decided to keep it working as it was for the sake of time.
- Implement unit and widget tests to ensure reliability.
- Overall adaptability and responsiveness is improvable.

## Useful resources consulted

- [WeatherAPI documentation](https://www.weatherapi.com/docs/)
- [http package documentation](https://pub.dev/packages/http)
- [location package documentation](https://pub.dev/packages/location)
- [Official Flutter approach to MVVM](https://docs.flutter.dev/get-started/fundamentals/state-management#using-mvvm-for-your-applications-architecture)
- [Multiple returns with Records](https://dart.dev/language/records)
- [Flutter naming conventions](https://docs.flutterflow.io/resources/style-guide/#constants)
- [Local image assets](https://docs.flutter.dev/ui/assets/assets-and-images)
- [Date and time manipulation](https://api.flutter.dev/flutter/dart-core/DateTime-class.html)
- [Navigation basics](https://docs.flutter.dev/cookbook/navigation/navigation-basics)
- [Workaround to Location package issue](https://github.com/Lyokone/flutterlocation/issues/987#issuecomment-2441437378)
