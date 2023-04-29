/// Represents the weather data returned from the OpenWeatherMap API.
class WeatherData {
  /// Creates a new instance of the [WeatherData] class with the specified
  /// values for its properties.
  /// All properties are required.
  WeatherData({
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.timezoneOffset,
    required this.current,
    required this.minutely,
    required this.hourly,
    required this.daily,
    required this.alerts,
  });

  /// Creates a new instance of the [WeatherData] class from the specified
  /// JSON data.
  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      latitude: double.parse(json['lat'].toString()),
      longitude: double.parse(json['lon'].toString()),
      timezone: json['timezone'] as String,
      timezoneOffset: int.parse(json['timezone_offset'].toString()),
      current: CurrentWeather.fromJson(json['current'] as Map<String, dynamic>),
      minutely: (json['minutely'] as List)
          .map(
            (e) => MinutelyWeather.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      hourly: (json['hourly'] as List)
          .map(
            (e) => HourlyWeather.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      daily: (json['daily'] as List)
          .map(
            (e) => DailyWeather.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      alerts: (json['alerts'] as List)
          .map(
            (e) => Alert.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  /// The latitude of the location for which the weather data is being queried.
  final double latitude;

  /// The longitude of the location for which the weather data is being queried.
  final double longitude;

  /// The timezone of the location for which the weather data is being queried.
  final String timezone;

  /// The time offset from UTC for the timezone of the location for which the
  /// weather data is being queried.
  final int timezoneOffset;

  /// The current weather conditions at the location.
  final CurrentWeather current;

  /// Minute-by-minute weather conditions for the next hour at the location
  final List<MinutelyWeather> minutely;

  /// The hour-by-hour weather conditions for the next 48 hours at the location.
  final List<HourlyWeather> hourly;

  /// The day-by-day weather conditions for the next 7 days at the location.
  final List<DailyWeather> daily;

  /// Any weather alerts in effect for the location.
  final List<Alert> alerts;
}

/// A class representing the current weather data from the API response.
class CurrentWeather {
  /// Constructs a [CurrentWeather] instance.
  ///
  /// All parameters are required.
  CurrentWeather({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.clouds,
    required this.visibility,
    required this.windSpeed,
    required this.weatherCondition,
  });

  /// Creates a [CurrentWeather] instance from a JSON object.
  ///
  /// The [json] parameter must not be null.
  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      dt: int.parse(json['dt'].toString()),
      sunrise: int.parse(json['sunrise'].toString()),
      sunset: int.parse(json['sunset'].toString()),
      temp: double.parse(json['temp'].toString()),
      feelsLike: double.parse(json['feels_like'].toString()),
      pressure: int.parse(json['pressure'].toString()),
      humidity: int.parse(json['humidity'].toString()),
      clouds: int.parse(json['clouds'].toString()),
      visibility: int.parse(json['visibility'].toString()),
      windSpeed: double.parse(json['clouds'].toString()),
      weatherCondition:
          WeatherCondition.fromJson(json['weather'][0] as Map<String, dynamic>),
    );
  }

  /// The time of the measurement, Unix timestamp, UTC.
  final int dt;

  /// The time of the sunrise, Unix timestamp, UTC.
  final int sunrise;

  /// The time of the sunset, Unix timestamp, UTC.
  final int sunset;

  /// The temperature.
  final double temp;

  /// The perceived (feels-like) temperature.
  final double feelsLike;

  /// The atmospheric pressure
  final int pressure;

  /// The humidity, %.
  final int humidity;

  /// The cloudiness, %.
  final int clouds;

  /// The average visibility, meters.
  final int visibility;

  /// The wind speed, m/s.
  final double windSpeed;

  final WeatherCondition weatherCondition;
}

/// A class representing the minutely weather forecast for a specific location.
class MinutelyWeather {
  /// Creates a new [MinutelyWeather] instance.
  ///
  /// All parameters are required.
  MinutelyWeather({
    required this.dt,
    required this.precipitation,
  });

  /// Creates a new [MinutelyWeather] instance from a JSON object.
  ///
  /// The [json] parameter must not be null.
  factory MinutelyWeather.fromJson(Map<String, dynamic> json) {
    return MinutelyWeather(
      dt: int.parse(json['dt'].toString()),
      precipitation: int.parse(
        json['precipitation'].toString(),
      ),
    );
  }

  /// The time of the forecasted data, represented as seconds since the Unix
  /// epoch.
  final int dt;

  /// The amount of precipitation expected in the next hour, in millimeters.
  final int precipitation;
}

/// A class that represents hourly weather information.
class HourlyWeather {
  /// Creates an instance of [HourlyWeather].
  HourlyWeather({
    required this.dt,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.clouds,
    required this.visibility,
    required this.windSpeed,
    required this.weather,
  });

  /// Creates an instance of [HourlyWeather] from a JSON object.
  factory HourlyWeather.fromJson(Map<String, dynamic> json) => HourlyWeather(
        dt: int.parse(json['dt'].toString()),
        temp: double.parse(json['temp'].toString()),
        feelsLike: double.parse(json['feels_like'].toString()),
        pressure: int.parse(json['pressure'].toString()),
        humidity: int.parse(json['humidity'].toString()),
        clouds: int.parse(json['clouds'].toString()),
        visibility: int.parse(json['visibility'].toString()),
        windSpeed: double.parse(json['clouds'].toString()),
        weather: List<Weather>.from(
          ((json['weather']) as List).map(
            (x) => Weather.fromJson(x as Map<String, dynamic>),
          ),
        ),
      );

  /// The time of the forecasted data in Unix timestamp format.
  int dt;

  /// The temperature at the time of the forecast.
  double temp;

  /// The perceived temperature (feels like) at the time of the forecast.
  double feelsLike;

  /// The atmospheric pressure at the time of the forecast.
  int pressure;

  /// The relative humidity at the time of the forecast.
  int humidity;

  /// The percentage of cloudiness at the time of the forecast.
  int clouds;

  /// The average visibility at the time of the forecast, measured in meters.
  int visibility;

  /// The wind speed at the time of the forecast, measured in meters per second.
  double windSpeed;

  /// The weather conditions at the time of the forecast.
  List<Weather> weather;
}

/// Represents weather information for a particular location at a given time.
class Weather {
  /// Creates a new instance of the [Weather] class.
  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  /// Creates a new instance of the [Weather] class from a JSON object.

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: int.parse(json['id'].toString()),
        main: json['main'] as String,
        description: json['description'] as String,
        icon: json['icon'] as String,
      );

  /// The weather condition ID.
  int id;

  /// The main weather parameter, such as "Rain".
  String main;

  /// A brief description of the weather.
  String description;

  /// The weather icon ID.
  String icon;

  /// Converts this [Weather] object to a JSON object.
  Map<String, dynamic> toJson() => {
        'id': id,
        'main': main,
        'description': description,
        'icon': icon,
      };
}

/// Represents weather information for a specific day.
class DailyWeather {
  /// Creates a new instance of the [DailyWeather] class.

  DailyWeather({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.weather,
    required this.clouds,
    required this.rain,
  });

  /// Creates a new instance of [DailyWeather] from a JSON object.
  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    return DailyWeather(
      dt: int.parse(json['dt'].toString()),
      sunrise: int.parse(json['sunrise'].toString()),
      sunset: int.parse(json['sunset'].toString()),
      humidity: int.parse(json['humidity'].toString()),
      clouds: int.parse(json['clouds'].toString()),
      windSpeed: double.parse(json['clouds'].toString()),
      temperature: Temperature.fromJson(json['temp'] as Map<String, dynamic>),
      rain: double.parse(json['rain'].toString()),
      feelsLike: FeelsLike.fromJson(json['feels_like'] as Map<String, dynamic>),
      weather: List<Weather>.from(
        ((json['weather']) as List).map(
          (x) => Weather.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  /// The date and time of the weather data in Unix, UTC format.
  final int dt;

  /// The time of the sunrise in Unix, UTC format.
  final int sunrise;

  /// The time of the sunset in Unix, UTC format.
  final int sunset;

  /// The temperature information for the day.
  final Temperature temperature;

  /// The "feels like" temperature information for the day.
  final FeelsLike feelsLike;

  /// The relative humidity percentage.
  final int humidity;

  /// The wind speed in meters per second.
  final double windSpeed;

  /// The weather conditions for the day.
  final List<Weather> weather;

  /// The percentage of cloud cover.
  final int clouds;

  /// The amount of rain in millimeters that fell in the last hour, if any.
  final double rain;
}

/// Represents the temperature information for a particular weather forecast.It
/// contains the temperature for different times of the day.
class Temperature {
  /// Creates an instance of [Temperature].
  Temperature({
    required this.day,
    required this.min,
    required this.max,
    required this.night,
    required this.eve,
    required this.morn,
  });

  /// Creates an instance of [HourlyWeather] from a JSON object.
  factory Temperature.fromJson(Map<String, dynamic> json) {
    return Temperature(
      day: double.parse(json['day'].toString()),
      min: double.parse(json['min'].toString()),
      max: double.parse(json['max'].toString()),
      night: double.parse(json['night'].toString()),
      eve: double.parse(json['eve'].toString()),
      morn: double.parse(json['morn'].toString()),
    );
  }

  /// A double value representing the day temperature, in Celsius.
  double day;

  /// A double value representing the minimum temperature, in Celsius,
  /// during the day.
  double min;

  /// A double value representing the maximum temperature, in Celsius,
  /// during the day.
  double max;

  /// A double value representing the night temperature, in Celsius.
  double night;

  /// A double value representing the evening temperature, in Celsius.
  double eve;

  /// A double value representing morning temperature, in Celcius.
  double morn;
}

/// Represents the feels like temperature for a given time period in a weather
/// forecast.
class FeelsLike {
  /// Creates an instance of [FeelsLike].
  FeelsLike({
    required this.day,
    required this.night,
    required this.eve,
    required this.morn,
  });

  /// Creates a new instance of [DailyWeather] from a JSON object.
  factory FeelsLike.fromJson(Map<String, dynamic> json) {
    return FeelsLike(
      day: double.parse(json['day'].toString()),
      night: double.parse(json['night'].toString()),
      eve: double.parse(json['eve'].toString()),
      morn: double.parse(json['morn'].toString()),
    );
  }

  /// A double value representing the feels like temperature for
  /// the day time period.
  double day;

  /// A double value representing the feels like temperature for the night
  /// time period.
  double night;

  /// A double value representing the feels like temperature for the evening
  /// time period.
  double eve;

  /// A double value representing the feels like temperature for the morning
  /// time period.
  double morn;
}

/// An alert issued by a weather service or other source.
class Alert {
  /// Creates an instance of [Alert] with the given properties.
  Alert({
    required this.senderName,
    required this.event,
    required this.start,
    required this.end,
    required this.description,
    required this.tags,
  });

  /// Creates a new instance of [Alert] from a JSON object.
  factory Alert.fromJson(Map<String, dynamic> json) {
    return Alert(
      senderName: json['sender_name'] as String,
      event: json['event'] as String,
      start: int.parse(json['start'].toString()),
      end: int.parse(json['end'].toString()),
      description: json['description'] as String,
      tags: List<String>.from(json['tags'].toString() as Iterable).toList(),
    );
  }

  /// The name of the sender of the alert.
  String senderName;

  /// The event type of the alert.
  String event;

  /// The time at which the alert starts, in UNIX timestamp format.
  int start;

  /// The time at which the alert ends, in UNIX timestamp format.
  int end;

  /// A detailed description of the alert.
  String description;

  /// Tags associated with the alert.
  List<String> tags;

  /// Converts this [Alert] object to a JSON object.
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['sender_name'] = senderName;
    data['event'] = event;
    data['start'] = start;
    data['end'] = end;
    data['description'] = description;
    data['tags'] = tags;
    return data;
  }
}

/// A model class representing the weather condition.
class WeatherCondition {
  /// Creates an instance of [WeatherCondition].

  WeatherCondition({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  /// Creates a new instance of [WeatherCondition] from a JSON object.
  ///
  /// [json] must not be null.
  factory WeatherCondition.fromJson(Map<String, dynamic> json) {
    return WeatherCondition(
      id: int.parse(json['id'].toString()),
      main: json['main'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
    );
  }

  /// Weather condition ID.
  final int id;

  /// Group of weather parameters (Rain, Snow, Extreme etc.).
  final String main;

  /// Weather condition within the group.
  final String description;

  /// Weather icon ID.
  final String icon;
}
