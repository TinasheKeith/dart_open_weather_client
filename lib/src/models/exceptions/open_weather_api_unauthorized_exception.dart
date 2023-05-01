/// Exception thrown when the OpenWeather API returns a 401 Unauthorized error.
///
/// This exception is thrown when the API key used to make a request to the
/// OpenWeather API is invalid or does not have access to the
/// requested resource.
class OpenWeatherApiUnauthorizedException implements Exception {
  /// Creates a new instance of [OpenWeatherApiUnauthorizedException]
  /// with the relevant message.
  OpenWeatherApiUnauthorizedException(this.message);

  /// Creates a new instance of [OpenWeatherApiUnauthorizedException] by
  /// decoding a JSON object from [json].
  factory OpenWeatherApiUnauthorizedException.fromJson(
    Map<String, dynamic> json,
  ) {
    final message = json['message'] as String;
    return OpenWeatherApiUnauthorizedException(message);
  }

  /// The error message associated with the exception.
  final String message;

  @override
  String toString() => 'OpenWeatherApiUnauthorizedException: $message';
}
