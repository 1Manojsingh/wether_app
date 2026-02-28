import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wether_app/core/utilities/design_utility.dart';

import '../models/weather_models.dart';

class HourlyForecastItem extends StatelessWidget {
  const HourlyForecastItem({
    super.key,
    required this.hour,
  });

  final HourlyForecast hour;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final timeLabel = DateFormat('ha').format(hour.time); // e.g. 2PM

    return Container(
      width: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: theme.colorScheme.surface.withOpacity(
          theme.brightness == Brightness.dark ? 0.6 : 0.9,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            timeLabel,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          verticalSpaceTiny,
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 400),
            curve: Curves.elasticOut,
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: child,
              );
            },
            child: SizedBox(
              height: 24,
              child: Image.network(
                hour.condition.iconUrl,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.cloud, size: 20),
              ),
            ),
          ),
          verticalSpaceTiny,
          Text(
            '${hour.tempC.toStringAsFixed(0)}°',
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

