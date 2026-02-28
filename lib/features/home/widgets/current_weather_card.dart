import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wether_app/core/utilities/design_utility.dart';

import '../models/weather_models.dart';
import 'weather_metric_chip.dart';

class CurrentWeatherCard extends StatefulWidget {
  const CurrentWeatherCard({
    super.key,
    required this.current,
  });

  final CurrentWeather current;

  @override
  State<CurrentWeatherCard> createState() => _CurrentWeatherCardState();
}

class _CurrentWeatherCardState extends State<CurrentWeatherCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _tempController;
  late Animation<double> _tempAnimation;

  @override
  void initState() {
    super.initState();
    _tempController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _tempAnimation = Tween<double>(
      begin: 0,
      end: widget.current.temperatureC,
    ).animate(CurvedAnimation(
      parent: _tempController,
      curve: Curves.easeOut,
    ));
    _tempController.forward();
  }

  @override
  void didUpdateWidget(CurrentWeatherCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.current.temperatureC != widget.current.temperatureC) {
      _tempAnimation = Tween<double>(
        begin: oldWidget.current.temperatureC,
        end: widget.current.temperatureC,
      ).animate(CurvedAnimation(
        parent: _tempController,
        curve: Curves.easeOut,
      ));
      _tempController.reset();
      _tempController.forward();
    }
  }

  @override
  void dispose() {
    _tempController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final now = DateTime.now();
    final formattedDate = DateFormat('EEE, d MMM').format(now);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: isDark
              ? const [Color(0xFF232532), Color(0xFF171821)]
              : [
                  theme.colorScheme.primary,
                  theme.colorScheme.primary.withOpacity(0.85),
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.current.city,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    verticalSpaceTiny,
                    Text(
                      formattedDate,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                    verticalSpaceSmall,
                    Text(
                      widget.current.condition.text,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              verticalSpaceRegular,
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AnimatedBuilder(
                    animation: _tempAnimation,
                    builder: (context, child) {
                      return Text(
                        '${_tempAnimation.value.toStringAsFixed(0)}°',
                        style: theme.textTheme.displaySmall?.copyWith(
                          color: Colors.white,
                          fontSize: 90
                        ),
                      );
                    },
                  ),
                  verticalSpaceTiny,
                  Text(
                    'Feels like ${widget.current.feelsLikeC.toStringAsFixed(0)}°',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ],
          ),
          verticalSpaceRegular,
          Row(
            children: [
              Expanded(
                child: WeatherMetricChip(
                  icon: Icons.water_drop_rounded,
                  label: 'Humidity',
                  value: '${widget.current.humidity}%',
                ),
              ),
              horizontalSpaceRegular,
              Expanded(
                child: WeatherMetricChip(
                  icon: Icons.air_rounded,
                  label: 'Wind',
                  value: '${widget.current.windKph.toStringAsFixed(1)} km/h',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

