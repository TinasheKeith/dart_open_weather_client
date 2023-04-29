// ignore_for_file: prefer_const_constructors
import 'package:test/test.dart';
import 'package:weather_app_dart_client/weather_app_dart_client.dart';

void main() {
  group('WeatherAppDartClient', () {
    test('can be instantiated', () {
      expect(WeatherAppDartClient(), isNotNull);
    });
  });
}
