import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wether_app/core/utilities/design_utility.dart';
import '../models/weather_models.dart';
import 'hourly_forecast_item.dart';

class ForecastDetailsCard extends StatelessWidget {
  const ForecastDetailsCard({
    super.key,
    required this.forecast,
  });

  final DailyForecast forecast;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dayLabel = DateFormat('EEEE, d MMM').format(forecast.date);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: theme.colorScheme.surface.withOpacity(
          theme.brightness == Brightness.dark ? 0.7 : 0.9,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              theme.brightness == Brightness.dark ? 0.5 : 0.08,
            ),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dayLabel,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          verticalSpaceSmall,
          Text(
            forecast.condition.text,
            style: theme.textTheme.bodyMedium,
          ),
          verticalSpaceSmall,
          Text(
            'Min ${forecast.minTempC.toStringAsFixed(0)}° • Max ${forecast.maxTempC.toStringAsFixed(0)}°',
            style: theme.textTheme.bodyLarge,
          ),
          if (forecast.hourly.isNotEmpty) ...[
            verticalSpaceRegular,
            Text(
              '24-Hour Forecast',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            verticalSpaceSmall,
            SizedBox(
              height: 90,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: forecast.hourly.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final hour = forecast.hourly[index];
                  return TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: Duration(milliseconds: 200 + (index * 50)),
                    curve: Curves.easeOut,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 10 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: HourlyForecastItem(hour: hour),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}

