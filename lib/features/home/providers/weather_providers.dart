import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/weather_models.dart';
import '../repositories/home_repository.dart';

/// Weather for a given city, backed by [HomeRepository].
final weatherProvider =
    FutureProvider.family<WeatherBundle, String>((ref, city) async {
  final repo = ref.watch(homeRepositoryProvider);
  return repo.fetchWeather(city);
});

/// Thought of the day quote, backed by [HomeRepository].
final quoteProvider = FutureProvider<Quote>((ref) async {
  final repo = ref.watch(homeRepositoryProvider);
  return repo.fetchQuote();
});


