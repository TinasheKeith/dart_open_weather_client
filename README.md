# dart_open_weather_client

A Dart package for interacting with the OpenWeather API. 

## Features
- **Simple**: Use `OpenWeatherApiClient` to quickly and easily interact with the OpenWeather API.
- **Typed**: The response data is automatically converted to Dart classes, so you can easily work with them in your code.
- **Flexible**: You can use the provided `OpenWeatherApiClient` to make API requests or create your own instance of `OpenWeatherApi` and use it to build your own custom implementation.

## Usage

To use this package, add `dart_open_weather_client` as a [dependency in your `pubspec.yaml` file](https://flutter.dev/docs/development/packages-and-plugins/using-packages).

### Import the library
```dart
import 'package:dart_open_weather_client/dart_open_weather_client.dart';
```

### Then, use the client to make requests to the OpenWeather API. For example, to get the current weather for a city:
```dart
final weather = await client.getWeatherData(location.latitude, location.longitude);
```