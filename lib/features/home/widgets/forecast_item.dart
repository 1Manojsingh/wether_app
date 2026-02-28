import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:wether_app/core/theme/text_theme.dart';
import 'package:wether_app/core/utilities/design_utility.dart';
import '../../../core/providers/theme_brightness_provider.dart';
import '../models/weather_models.dart';

class ForecastItem extends ConsumerWidget {
  const ForecastItem({
    super.key,
    required this.forecast,
    required this.isSelected,
    required this.onTap,
  });

  final DailyForecast forecast;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final brightness = ref.watch(themeBrightnessProvider);
    final isDarkMode = brightness == Brightness.dark;
    final theme = Theme.of(context);
    final label = DateFormat('EEE').format(forecast.date);

    final baseColor = theme.colorScheme.surface.withOpacity(
      theme.brightness == Brightness.dark ? 0.4 : 0.9,
    );
    final selectedColor = theme.colorScheme.primary.withOpacity(
      theme.brightness == Brightness.dark ? 0.6 : 0.8,
    );

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isSelected ? selectedColor : baseColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(
                theme.brightness == Brightness.dark ? 0.4 : 0.1,
              ),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: appTextTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            verticalSpaceSmall,
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 500),
              curve: Curves.elasticOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: child,
                );
              },
              child: SizedBox(
                height: 32,
                child: Image.network(
                  forecast.condition.iconUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.cloud,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            verticalSpaceSmall,
            Text(
              '${forecast.minTempC.toStringAsFixed(0)}° / ${forecast.maxTempC.toStringAsFixed(0)}°',
              style: appTextTheme.bodyMedium?.copyWith(
                color:  isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

