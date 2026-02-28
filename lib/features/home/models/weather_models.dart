class WeatherCondition {
  final String text;
  final String iconUrl;

  WeatherCondition({
    required this.text,
    required this.iconUrl,
  });

  factory WeatherCondition.fromJson(Map<String, dynamic> json) {
    return WeatherCondition(
      text: json['text'] as String? ?? '',
      // WeatherAPI returns icon path like "//cdn.weatherapi.com/..."
      iconUrl: (json['icon'] as String? ?? '').startsWith('http')
          ? (json['icon'] as String? ?? '')
          : 'https:${json['icon'] ?? ''}',
    );
  }
}

class CurrentWeather {
  final String city;
  final double temperatureC;
  final double feelsLikeC;
  final int humidity;
  final double windKph;
  final WeatherCondition condition;

  CurrentWeather({
    required this.city,
    required this.temperatureC,
    required this.feelsLikeC,
    required this.humidity,
    required this.windKph,
    required this.condition,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    final location = json['location'] as Map<String, dynamic>? ?? {};
    final current = json['current'] as Map<String, dynamic>? ?? {};

    return CurrentWeather(
      city: location['name'] as String? ?? '',
      temperatureC: (current['temp_c'] as num?)?.toDouble() ?? 0,
      feelsLikeC: (current['feelslike_c'] as num?)?.toDouble() ?? 0,
      humidity: (current['humidity'] as num?)?.toInt() ?? 0,
      windKph: (current['wind_kph'] as num?)?.toDouble() ?? 0,
      condition: WeatherCondition.fromJson(
        current['condition'] as Map<String, dynamic>? ?? {},
      ),
    );
  }
}

class HourlyForecast {
  final DateTime time;
  final double tempC;
  final WeatherCondition condition;

  HourlyForecast({
    required this.time,
    required this.tempC,
    required this.condition,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    final timeString = json['time'] as String? ?? '';
    return HourlyForecast(
      time: DateTime.tryParse(timeString) ?? DateTime.now(),
      tempC: (json['temp_c'] as num?)?.toDouble() ?? 0,
      condition: WeatherCondition.fromJson(
        json['condition'] as Map<String, dynamic>? ?? {},
      ),
    );
  }
}

class DailyForecast {
  final DateTime date;
  final double minTempC;
  final double maxTempC;
  final WeatherCondition condition;
  final List<HourlyForecast> hourly;

  DailyForecast({
    required this.date,
    required this.minTempC,
    required this.maxTempC,
    required this.condition,
    required this.hourly,
  });

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    final day = json['day'] as Map<String, dynamic>? ?? {};
    final hourJson = json['hour'] as List<dynamic>? ?? [];
    final hourly = hourJson
        .map((e) => HourlyForecast.fromJson(e as Map<String, dynamic>))
        .toList();
    return DailyForecast(
      date: DateTime.tryParse(json['date'] as String? ?? '') ?? DateTime.now(),
      minTempC: (day['mintemp_c'] as num?)?.toDouble() ?? 0,
      maxTempC: (day['maxtemp_c'] as num?)?.toDouble() ?? 0,
      condition: WeatherCondition.fromJson(
        day['condition'] as Map<String, dynamic>? ?? {},
      ),
      hourly: hourly,
    );
  }
}

class WeatherBundle {
  final CurrentWeather current;
  final List<DailyForecast> forecast;

  WeatherBundle({
    required this.current,
    required this.forecast,
  });

  factory WeatherBundle.fromJson(Map<String, dynamic> json) {
    final forecastJson =
        (json['forecast'] as Map<String, dynamic>? ?? {})['forecastday']
            as List<dynamic>? ??
            [];

    final forecast = forecastJson
        .map((e) => DailyForecast.fromJson(e as Map<String, dynamic>))
        .toList();

    return WeatherBundle(
      current: CurrentWeather.fromJson(json),
      forecast: forecast,
    );
  }
}

class Quote {
  final String text;
  final String author;

  const Quote({
    required this.text,
    required this.author,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    // Quotable: { content, author }
    return Quote(
      text: json['content'] as String? ?? '',
      author: json['author'] as String? ?? 'Unknown',
    );
  }
}


