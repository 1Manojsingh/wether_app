import 'package:flutter/material.dart';
import 'package:wether_app/core/theme/text_theme.dart';

import '../models/weather_models.dart';

class QuoteCard extends StatelessWidget {
  const QuoteCard({
    super.key,
    required this.quote,
  });

  final Quote quote;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
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
            '"${quote.text}"',
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '- ${quote.author}',
              style: appTextTheme.bodySmall?.copyWith(
                color: appTextTheme.bodySmall?.color?.withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

