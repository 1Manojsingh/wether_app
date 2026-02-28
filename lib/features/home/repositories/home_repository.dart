import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/weather_models.dart';
import 'http_home_repository.dart';

/// Abstraction for all data the home screen needs (weather + quote).
abstract class HomeRepository {
  Future<WeatherBundle> fetchWeather(String city);
  Future<Quote> fetchQuote();
}

/// Default implementation that talks to the remote Weather/Quote APIs.
final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HttpHomeRepository(ref);
});

