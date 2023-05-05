/// A class representing a weather forecast.
class WeatherForecast {
  /// Creates a new [WeatherForecast] instance.
  ///
  /// All parameters are required.
  WeatherForecast({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
  });

  /// Creates a new [WeatherForecast] instance from the provided JSON data.
  ///
  /// Throws a [FormatException] if the JSON is not in the expected format.
  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      cod: json['cod'] as String,
      message: json['message'] as int,
      cnt: json['cnt'] as int,
      list: List<Weather>.from(
        (json['list'] as List).map(
          (x) => Weather.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  /// The status code returned by the API.
  final String cod;

  /// A human-readable message giving more information about the response.
  final int message;

  /// The number of forecast entries returned.
  final int cnt;

  /// A list of weather forecasts for different times.
  final List<Weather> list;

  /// Converts this [WeatherForecast] instance to a JSON-encodable [Map].
  Map<String, dynamic> toJson() {
    return {
      'cod': cod,
      'message': message,
      'cnt': cnt,
      'list': list.map((e) => e.toJson()).toList(),
    };
  }
}

/// A class representing a weather object, as returned by the OpenWeather API.
class Weather {
  /// Creates a new [Weather] instance from a JSON object.
  Weather({
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.dtTxt,
  });

  /// Creates a new [Weather] instance from a JSON object.
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      main: Main.fromJson(json['main'] as Map<String, dynamic>),
      weather: List<WeatherInfo>.from(
        (json['weather'] as List).map(
          (x) => WeatherInfo.fromJson(x as Map<String, dynamic>),
        ),
      ),
      clouds: Clouds.fromJson(json['clouds'] as Map<String, dynamic>),
      wind: Wind.fromJson(json['wind'] as Map<String, dynamic>),
      visibility: json['visibility'] as int,
      dtTxt: DateTime.parse(json['dt_txt'] as String),
    );
  }

  /// The main weather parameters for this forecast.
  final Main main;

  /// The weather conditions for this forecast.
  final List<WeatherInfo> weather;

  /// The cloudiness for this forecast.
  final Clouds clouds;

  /// The wind conditions for this forecast.
  final Wind wind;

  /// The visibility for this forecast.
  final int visibility;

  /// The date and time of the forecasted weather data, as [DateTime].
  final DateTime dtTxt;

  /// Converts this [Weather] instance to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'main': main.toJson(),
      'weather': List<dynamic>.from(weather.map((x) => x.toJson())),
      'clouds': clouds.toJson(),
      'wind': wind.toJson(),
      'visibility': visibility,
      'dt_txt': dtTxt.toIso8601String(),
    };
  }
}

/// Represents cloud data in a weather forecast.
class Clouds {
  /// Creates a new instance of [Clouds].
  const Clouds({required this.all});

  /// Creates a new instance of [Clouds] from a JSON object.
  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      all: json['all'] as int,
    );
  }

  /// Converts this [Clouds] instance to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'all': all,
    };
  }

  /// Cloudiness percentage, 0-100.
  final int all;
}

/// Represents the main weather parameters in a weather report.
class Main {
  /// Creates a new instance of [Main]
  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.groundLevel,
    required this.humidity,
  });

  /// Create a new instance of [Main] from a JSON object.
  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp'] as double,
      feelsLike: json['feels_like'] as double,
      tempMin: json['temp_min'] as double,
      tempMax: json['temp_max'] as double,
      pressure: json['pressure'] as int,
      groundLevel: json['grnd_level'] as int?,
      humidity: json['humidity'] as int,
    );
  }

  /// Convert this [Main] instance to a JSON object.
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['temp'] = temp;
    data['feels_like'] = feelsLike;
    data['temp_min'] = tempMin;
    data['temp_max'] = tempMax;
    data['pressure'] = pressure;
    data['grnd_level'] = groundLevel;
    data['humidity'] = humidity;
    return data;
  }

  /// Temperature in Kelvin
  final double temp;

  /// Temperature feels like in Kelvin
  final double feelsLike;

  /// Minimum temperature at the moment of calculation in Kelvin
  final double tempMin;

  /// Maximum temperature at the moment of calculation in Kelvin
  final double tempMax;

  /// Atmospheric pressure on the sea level, hPa
  final int pressure;

  /// Atmospheric pressure on the ground level, hPa
  final int? groundLevel;

  /// Humidity, %
  final int humidity;
}

/// Represents weather information for a location.
class WeatherInfo {
  /// Creates a new [WeatherInfo] instance.
  WeatherInfo({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  /// Creates a new [WeatherInfo] instance from a JSON object.
  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      id: json['id'] as int,
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

  /// Converts the [WeatherInfo] instance to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'main': main,
      'description': description,
      'icon': icon,
    };
  }
}

/// Represents the wind information.
class Wind {
  /// Creates a new instance of the [Wind] class.
  const Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  /// Creates a new instance of the [Wind] class from a JSON object.
  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: (json['speed'] as num).toDouble(),
      deg: json['deg'] as int,
      gust: (json['gust'] as num?)?.toDouble() ?? 0.0,
    );
  }

  /// The wind speed in meter/sec.
  final double speed;

  /// The wind direction in degrees (meteorological).
  final int deg;

  /// The wind gust speed in meter/sec.
  final double gust;

  /// Converts this [Wind] instance to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'speed': speed,
      'deg': deg,
      'gust': gust,
    };
  }
}

/// A class representing the coordinates of a location.
class Coord {
  /// Creates a new [Coord] instance.
  ///
  /// All parameters are required.
  Coord({
    required this.lon,
    required this.lat,
  });

  /// Creates a new [Coord] instance from the provided JSON data.
  ///
  /// Throws a [FormatException] if the JSON is not in the expected format.
  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lon: json['lon'] as double,
      lat: json['lat'] as double,
    );
  }

  /// The longitude of the location.
  final double lon;

  /// The latitude of the location.
  final double lat;

  /// Converts this [Coord] instance to a JSON-encodable [Map].
  Map<String, dynamic> toJson() {
    return {
      'lon': lon,
      'lat': lat,
    };
  }
}

/// A class representing the amount of rain within a certain time period.
class Rain {
  /// Creates a new [Rain] instance.
  ///
  /// The [lastHour] parameter is required and specifies the amount of rain
  /// in the last hour.
  Rain({
    required this.lastHour,
  });

  /// Creates a new [Rain] instance from the provided JSON data.
  ///
  /// Throws a [FormatException] if the JSON is not in the expected format.
  factory Rain.fromJson(Map<String, dynamic> json) {
    return Rain(
      lastHour: json['1h'] as double,
    );
  }

  /// The amount of rain in the last hour, in millimeters.
  final double lastHour;

  /// Converts this [Rain] instance to a JSON-encodable [Map].
  Map<String, dynamic> toJson() {
    return {
      '1h': lastHour,
    };
  }
}

/// A class representing a weather report.
class CurrentWeather {
  /// Creates a new [CurrentWeather] instance.
  ///
  /// All parameters are required.
  CurrentWeather({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.rain,
    required this.clouds,
    required this.dt,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  /// Creates a new [CurrentWeather] instance from the provided JSON data.
  ///
  /// Throws a [FormatException] if the JSON is not in the expected format.
  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      coord: Coord.fromJson(json['coord'] as Map<String, dynamic>),
      weather: List<CurrentWeatherData>.from(
        (json['weather'] as List).map(
          (x) => CurrentWeatherData.fromJson(x as Map<String, dynamic>),
        ),
      ),
      base: json['base'] as String,
      main: Main.fromJson(json['main'] as Map<String, dynamic>),
      visibility: json['visibility'] as int,
      wind: Wind.fromJson(json['wind'] as Map<String, dynamic>),
      rain: json['rain'] != null
          ? Rain.fromJson(json['rain'] as Map<String, dynamic>)
          : null,
      clouds: Clouds.fromJson(json['clouds'] as Map<String, dynamic>),
      dt: json['dt'] as int,
      timezone: json['timezone'] as int,
      id: json['id'] as int,
      name: json['name'] as String,
      cod: json['cod'] as int,
    );
  }

  /// The location coordinates of the weather report.
  final Coord coord;

  /// The current weather conditions.
  final List<CurrentWeatherData> weather;

  /// The data source for the report.
  final String base;

  /// The main weather parameters.
  final Main main;

  /// The visibility range in meters.
  final int visibility;

  /// The current wind conditions.
  final Wind wind;

  /// The amount of precipitation in the last hour.
  final Rain? rain;

  /// The cloudiness percentage.
  final Clouds clouds;

  /// The time of the forecast in Unix UTC format.
  final int dt;

  /// The time zone offset from UTC in seconds.
  final int timezone;

  /// The ID of the location for which the report was generated.
  final int id;

  /// The name of the location for which the report was generated.
  final String name;

  /// The HTTP status code of the response.
  final int cod;

  /// Converts this [CurrentWeather] instance to a JSON-encodable [Map].
  Map<String, dynamic> toJson() {
    return {
      'coord': coord.toJson(),
      'weather': weather.map((x) => x.toJson()).toList(),
      'base': base,
      'main': main.toJson(),
      'visibility': visibility,
      'wind': wind.toJson(),
      'rain': rain?.toJson(),
      'clouds': clouds.toJson(),
      'dt': dt,
      'timezone': timezone,
      'id': id,
      'name': name,
      'cod': cod,
    };
  }
}

/// A model class representing weather information.
class CurrentWeatherData {
  /// Creates a new instance of the [CurrentWeatherData] class.
  const CurrentWeatherData({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  /// Creates a new instance of the [CurrentWeatherData] class from a JSON
  /// object.
  factory CurrentWeatherData.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherData(
      id: json['id'] as int,
      main: json['main'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
    );
  }

  /// The weather condition ID.
  final int id;

  /// The main weather condition (e.g. Rain, Snow, etc.).
  final String main;

  /// A more detailed description of the weather condition.
  final String description;

  /// The weather icon ID.
  final String icon;

  /// Converts this [Weather] instance to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'main': main,
      'description': description,
      'icon': icon,
    };
  }
}
