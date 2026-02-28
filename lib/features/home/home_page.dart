import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wether_app/core/theme/app_colors.dart';
import 'package:wether_app/core/theme/text_theme.dart';
import 'package:wether_app/core/utilities/design_utility.dart';
import 'package:wether_app/core/wigdets/app_padding.dart';
import 'package:wether_app/core/wigdets/error_section.dart';
import 'package:wether_app/core/wigdets/search_field.dart';
import '../../core/providers/prefs_provider.dart';
import '../../core/providers/theme_brightness_provider.dart';
import 'providers/weather_providers.dart';
import 'widgets/current_weather_card.dart';
import 'widgets/forecast_details_card.dart';
import 'widgets/forecast_item.dart';
import 'widgets/quote_card.dart';
import 'shimmer/home_page_shimmer.dart';
import 'shimmer/section_loader.dart';

@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with SingleTickerProviderStateMixin {
  String _city = 'Chandigarh';
  DateTime? _selectedForecastDate;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    final brightness = ref.watch(themeBrightnessProvider);
    final isDarkMode = brightness == Brightness.dark;
    final weatherAsync = ref.watch(weatherProvider(_city));
    final quoteAsync = ref.watch(quoteProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: true,
        actions: [
          AnimatedRotation(
            turns: isDarkMode ? 0.5 : 0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: IconButton(
              icon: Icon(
                isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              ),
              onPressed: () async {
                final prefs = ref.read(prefsProvider);
                await prefs.setBool('isDarkMode', !isDarkMode);
                ref.invalidate(themeBrightnessProvider);
              },
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary.withOpacity(0.18),
              AppColors.scaffoldBackground,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: DefaultAppPadding(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchField(
                    initialValue: _city,
                    onSubmitted: (value) {
                      if (value.trim().isEmpty) return;
                      setState(() {
                        _city = value.trim();
                        // Reset selected forecast when changing city
                        _selectedForecastDate = null;
                      });
                    },
                  ),
                  verticalSpaceMedium,
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position:
                              Tween<Offset>(
                                begin: const Offset(0, 0.1),
                                end: Offset.zero,
                              ).animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeOut,
                                ),
                              ),
                          child: child,
                        ),
                      );
                    },
                    child: weatherAsync.when(
                      data: (bundle) {
                        final forecasts = bundle.forecast;
                        if (forecasts.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        final selectedDate =
                            _selectedForecastDate ?? forecasts.first.date;

                        return Column(
                          children: [
                            CurrentWeatherCard(
                              key: ValueKey('weather-${bundle.current.city}'),
                              current: bundle.current,
                            ),
                            verticalSpaceMedium,
                            Text(
                              '${forecasts.length}-Day Forecast',
                              style: appTextTheme.titleMedium,
                            ),
                            verticalSpaceRegular,
                            SizedBox(
                              height: 120,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (_, index) {
                                  final day = forecasts[index];
                                  final isSelected = _isSameDay(
                                    day.date,
                                    selectedDate,
                                  );
                              
                                  return TweenAnimationBuilder<double>(
                                    tween: Tween(begin: 0.0, end: 1.0),
                                    duration: Duration(
                                      milliseconds: 300 + (index * 100),
                                    ),
                                    curve: Curves.easeOut,
                                    builder: (context, value, child) {
                                      return Transform.translate(
                                        offset: Offset(0, 20 * (1 - value)),
                                        child: Opacity(
                                          opacity: value,
                                          child: child,
                                        ),
                                      );
                                    },
                                    child: ForecastItem(
                                      forecast: day,
                                      isSelected: isSelected,
                                      onTap: () {
                                        setState(() {
                                          _selectedForecastDate = day.date;
                                        });
                                      },
                                    ),
                                  );
                                },
                                separatorBuilder: (_, __) =>
                                    horizontalSpaceRegular,
                                itemCount: forecasts.length,
                              ),
                            ),
                            verticalSpaceRegular,
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 400),
                              transitionBuilder: (child, animation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: SlideTransition(
                                    position:
                                        Tween<Offset>(
                                          begin: const Offset(0, 0.2),
                                          end: Offset.zero,
                                        ).animate(
                                          CurvedAnimation(
                                            parent: animation,
                                            curve: Curves.easeOut,
                                          ),
                                        ),
                                    child: child,
                                  ),
                                );
                              },
                              child: ForecastDetailsCard(
                                key: ValueKey('details-$selectedDate'),
                                forecast: forecasts.firstWhere(
                                  (f) => _isSameDay(f.date, selectedDate),
                                  orElse: () => forecasts.first,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      loading: () => const HomePageShimmer(key: ValueKey('home-loading')),
                      error: (err, _) {
                        final raw = err.toString();
                        final friendly = raw.startsWith('Exception: ')
                            ? raw.substring('Exception: '.length)
                            : raw;

                        return ErrorSection(
                          key: ValueKey('error-$friendly'),
                          message: friendly,
                          onRetry: () => ref.refresh(weatherProvider(_city)),
                        );
                      },
                    ),
                  ),
                  verticalSpaceMedium,
                  Text('Thought of the Day', style: appTextTheme.titleMedium),
                  verticalSpaceRegular,
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position:
                              Tween<Offset>(
                                begin: const Offset(0, 0.1),
                                end: Offset.zero,
                              ).animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeOut,
                                ),
                              ),
                          child: child,
                        ),
                      );
                    },
                    child: quoteAsync.when(
                      data: (quote) {
                        return QuoteCard(
                          key: ValueKey('quote-${quote.text.substring(0, 10)}'),
                          quote: quote,
                        );
                      },
                      loading: () =>
                          const SectionLoader(key: ValueKey('quote-loading')),
                      error: (err, _) => ErrorSection(
                        key: const ValueKey('quote-error'),
                        message: 'Could not load quote.\n${err.toString()}',
                        onRetry: () => ref.refresh(quoteProvider),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
