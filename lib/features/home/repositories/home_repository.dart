import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/weather_models.dart';
import 'http_home_repository.dart';

abstract class HomeRepository {
  Future<WeatherBundle> fetchWeather(String city);
  Future<Quote> fetchQuote();
}

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HttpHomeRepository(ref);
});

