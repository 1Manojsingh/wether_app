import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/weather_models.dart';
import '../repositories/home_repository.dart';

final weatherProvider =
    FutureProvider.family<WeatherBundle, String>((ref, city) async {
  final repo = ref.watch(homeRepositoryProvider);
  return repo.fetchWeather(city);
});

final quoteProvider = FutureProvider<Quote>((ref) async {
  final repo = ref.watch(homeRepositoryProvider);
  return repo.fetchQuote();
});


