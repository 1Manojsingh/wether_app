import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../../core/config/config.dart';
import '../../../core/services/http/http_service.dart';
import '../../../core/services/http/http_service_provider.dart';
import '../models/weather_models.dart';
import 'home_repository.dart';

class HttpHomeRepository implements HomeRepository {
  final Ref ref;

  HttpHomeRepository(this.ref);

  HttpService get _httpService => ref.read(httpServiceProvider);

  @override
  Future<WeatherBundle> fetchWeather(String city) async {
    const days = 5;
    final result = await _httpService.get(
      '/forecast.json',
      queryParams: {
        'key': Configs.weatherApiKey,
        'q': city,
        'days': days.toString(),
      },
    );

    return result.fold(
      (failure) => throw Exception(failure.message),
      (response) {
        final json = response.data as Map<String, dynamic>;
        return WeatherBundle.fromJson(json);
      },
    );
  }

  @override
  Future<Quote> fetchQuote() async {
    final uri = Uri.parse('${Configs.quoteBaseUrl}/random');

    try {
      final response = await http.get(uri).timeout(
            const Duration(seconds: 8),
          );

      if (response.statusCode != 200) {
        throw Exception('Failed to load quote (${response.statusCode})');
      }

      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return Quote.fromJson(json);
    } on HandshakeException {
      return const Quote(
        text:
            'Keep your face always toward the sunshine—and shadows will fall behind you.',
        author: 'Walt Whitman',
      );
    } on SocketException {
      return const Quote(
        text: 'No internet connection. Every storm runs out of rain.',
        author: 'Maya Angelou',
      );
    } on TimeoutException {
      return const Quote(
        text: 'Good things take time. Be patient with yourself today.',
        author: 'Unknown',
      );
    } catch (_) {
      return const Quote(
        text: 'Unable to load today\'s thought. Stay positive and keep going!',
        author: 'Unknown',
      );
    }
  }
}

