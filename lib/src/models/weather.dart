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

class CurrentWeather {
  CurrentWeather({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.uvi,
    required this.clouds,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.weatherCondition,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      dt: json['dt'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
      temp: json['temp'],
      feelsLike: json['feels_like'],
      pressure: json['pressure'],
      humidity: json['humidity'],
      dewPoint: json['dew_point'],
      uvi: json['uvi'],
      clouds: json['clouds'],
      visibility: json['visibility'],
      windSpeed: json['wind_speed'],
      windDeg: json['wind_deg'],
      windGust: json['wind_gust'],
      weatherCondition:
          WeatherCondition.fromJson(json['weather'][0] as Map<String, dynamic>),
    );
  }
  final int dt;
  final int sunrise;
  final int sunset;
  final double temp;
  final double feelsLike;
  final int pressure;
  final int humidity;
  final double dewPoint;
  final double uvi;
  final int clouds;
  final int visibility;
  final double windSpeed;
  final int windDeg;
  final double windGust;
  final WeatherCondition weatherCondition;
}

class MinutelyWeather {
  MinutelyWeather({
    required this.dt,
    required this.precipitation,
  });

  factory MinutelyWeather.fromJson(Map<String, dynamic> json) {
    return MinutelyWeather(
      dt: json['dt'],
      precipitation: json['precipitation'],
    );
  }
  final int dt;
  final int precipitation;
}

class HourlyWeather {
  HourlyWeather({
    this.dt,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.uvi,
    this.clouds,
    this.visibility,
    this.windSpeed,
    this.windDeg,
    this.windGust,
    this.weather,
    this.pop,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) => HourlyWeather(
        dt: json["dt"],
        temp: json["temp"].toDouble(),
        feelsLike: json["feels_like"].toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
        dewPoint: json["dew_point"].toDouble(),
        uvi: json["uvi"].toDouble(),
        clouds: json["clouds"],
        visibility: json["visibility"],
        windSpeed: json["wind_speed"].toDouble(),
        windDeg: json["wind_deg"],
        windGust: json["wind_gust"].toDouble(),
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        pop: json["pop"].toDouble(),
      );
  int dt;
  double temp;
  double feelsLike;
  int pressure;
  int humidity;
  double dewPoint;
  double uvi;
  int clouds;
  int visibility;
  double windSpeed;
  int windDeg;
  double windGust;
  List<Weather> weather;
  double pop;

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "temp": temp,
        "feels_like": feelsLike,
        "pressure": pressure,
        "humidity": humidity,
        "dew_point": dewPoint,
        "uvi": uvi,
        "clouds": clouds,
        "visibility": visibility,
        "wind_speed": windSpeed,
        "wind_deg": windDeg,
        "wind_gust": windGust,
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "pop": pop,
      };
}

class Weather {
  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );
  int id;
  String main;
  String description;
  String icon;

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };
}

class DailyWeather {
  DailyWeather({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.temperature,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.weather,
    required this.clouds,
    required this.pop,
    required this.rain,
    required this.uvi,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    return DailyWeather(
      dt: json['dt'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
      moonrise: json['moonrise'],
      moonset: json['moonset'],
      moonPhase: json['moon_phase'],
      temperature: Temperature.fromJson(json['temp']),
      feelsLike: FeelsLike.fromJson(json['feels_like']),
      pressure: json['pressure'],
      humidity: json['humidity'],
      dewPoint: json['dew_point'],
      windSpeed: json['wind_speed'],
      windDeg: json['wind_deg'],
      windGust: json['wind_gust'],
      weather:
          List<Weather>.from(json['weather'].map((x) => Weather.fromJson(x))),
      clouds: json['clouds'],
      pop: json['pop'],
      rain: json['rain'] != null ? json['rain']['1h'] : 0,
      uvi: json['uvi'],
    );
  }
  int dt;
  int sunrise;
  int sunset;
  double moonrise;
  double moonset;
  double moonPhase;
  Temperature temperature;
  FeelsLike feelsLike;
  int pressure;
  int humidity;
  double dewPoint;
  double windSpeed;
  int windDeg;
  double windGust;
  List<Weather> weather;
  int clouds;
  double pop;
  double rain;
  double uvi;
}

class Temperature {
  Temperature({
    required this.day,
    required this.min,
    required this.max,
    required this.night,
    required this.eve,
    required this.morn,
  });

  factory Temperature.fromJson(Map<String, dynamic> json) {
    return Temperature(
      day: json['day'],
      min: json['min'],
      max: json['max'],
      night: json['night'],
      eve: json['eve'],
      morn: json['morn'],
    );
  }
  double day;
  double min;
  double max;
  double night;
  double eve;
  double morn;
}

class FeelsLike {
  FeelsLike({
    required this.day,
    required this.night,
    required this.eve,
    required this.morn,
  });

  factory FeelsLike.fromJson(Map<String, dynamic> json) {
    return FeelsLike(
      day: json['day'],
      night: json['night'],
      eve: json['eve'],
      morn: json['morn'],
    );
  }
  double day;
  double night;
  double eve;
  double morn;
}

class Alert {
  Alert({
    required this.senderName,
    required this.event,
    required this.start,
    required this.end,
    required this.description,
    required this.tags,
  });

  factory Alert.fromJson(Map<String, dynamic> json) {
    return Alert(
      senderName: json['sender_name'],
      event: json['event'],
      start: json['start'],
      end: json['end'],
      description: json['description'],
      tags: List<String>.from(json['tags']),
    );
  }
  String senderName;
  String event;
  int start;
  int end;
  String description;
  List<String> tags;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sender_name'] = this.senderName;
    data['event'] = this.event;
    data['start'] = this.start;
    data['end'] = this.end;
    data['description'] = this.description;
    data['tags'] = this.tags;
    return data;
  }
}
