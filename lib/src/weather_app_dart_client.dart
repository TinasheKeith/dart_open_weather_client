import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:weather_app_dart_client/src/models/exceptions/open_weather_api_unauthorized_exception.dart';
import 'package:weather_app_dart_client/src/models/forecase_model.dart';

/// Enumeration of temperature scales.
enum TemperatureScale {
  /// Metric temperature scale.
  celcius,

  /// Imperial temperature scale.
  fahrenheit,
}

/// Dart API Client for [https://openweathermap.org]
class WeatherAppDartClient {
  /// Creates a new instance of [WeatherAppDartClient]
  WeatherAppDartClient({required String apiKey}) {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.queryParameters = {'appid': apiKey};
    // TODO: [Tinashe] look up what a reasonable timeouts.
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
  }

  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5/';

  final Dio _dio = Dio();
  final _logger = Logger();

  Future<Map<String, dynamic>> _get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response =
          // ignore: inference_failure_on_function_invocation
          await _dio.get(endpoint, queryParameters: queryParameters);

      if (response.statusCode == HttpStatus.ok) {
        final data = response.data;

        if (data is String) jsonDecode(data);

        return data as Map<String, dynamic>;
      } else {
        throw DioError(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Error occurred while fetching weather data.',
        );
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout) {
        _logger.e(e.message, [
          e.error,
          e.stackTrace,
        ]);
        throw Exception('Connection timeout');
      } else if (e.type == DioErrorType.receiveTimeout) {
        _logger.e(e.message, [
          e.error,
          e.stackTrace,
        ]);
        throw Exception('Receive timeout in connection');
      } else if (e.type == DioErrorType.badResponse) {
        if (e.response != null) {
          if (e.response!.statusCode == HttpStatus.unauthorized) {
            final data = e.response!.data as Map<String, dynamic>;

            throw OpenWeatherApiUnauthorizedException.fromJson(data);
          }
        }

        throw Exception(
          'Error ${e.response!.statusCode}: ${e.response!.statusMessage}',
        );
      } else if (e.response != null) {
        _logger.e(
          e.message,
          [
            e.error,
          ],
        );

        throw Exception(
          'Error ${e.response!.statusCode}: ${e.response!.statusMessage}',
        );
      } else {
        inspect(e);
        throw Exception('Unknown error occurred');
      }
    } catch (e) {
      inspect(e);

      _logger.wtf(
        e,
        [e],
      );

      throw Exception('Unknown error occurred');
    }
  }

  String _getTemperatureUnit(TemperatureScale? unit) {
    if (unit == TemperatureScale.fahrenheit) {
      return 'imperial';
    } else {
      return 'metric';
    }
  }

  /// Retrieves weather data from an API based on the provided latitude and
  /// longitude coordinates.
  ///
  /// The [latitude] and [longitude] parameters are required and specify the
  /// location for which to retrieve weather data.
  ///
  /// The optional [units] parameter can be used to specify the units in which
  /// to retrieve the weather data. If not provided, the default value is
  /// 'metric'.
  Future<CurrentWeather> getWeatherData(
    double latitude,
    double longitude, {
    TemperatureScale? units,
  }) async {
    final queryParameters = {
      'lat': latitude,
      'lon': longitude,
    };

    final response = await _get('weather', queryParameters: queryParameters);

    return CurrentWeather.fromJson(response);
  }

  /// Retrieves forecast data from an API based on the provided latitude and
  /// longitude coordinates.
  ///
  /// The [latitude] and [longitude] parameters are required and specify the
  /// location for which to retrieve weather forecast data.
  ///
  /// The optional [units] parameter can be used to specify the temperature
  /// scale in which to retrieve the forecast data. If not provided,
  // ignore: comment_references
  /// the default value is [TemperatureScale.celsius].
  ///
  /// The optional [days] parameter can be used to specify the number of days
  /// for which to retrieve the forecast data. If not provided, the default
  /// value is 5.
  Future<WeatherForecast> getForecastData(
    double latitude,
    double longitude, {
    TemperatureScale? units,
    int days = 5,
  }) async {
    final queryParameters = {
      'lat': latitude,
      'lon': longitude,
      'units': _getTemperatureUnit(units),
      'cnt': days,
    };

    final result = await _get('forecast?', queryParameters: queryParameters);

    return WeatherForecast.fromJson(result);
  }
}
