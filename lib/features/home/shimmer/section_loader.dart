import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/theme/app_colors.dart';

class SectionLoader extends StatelessWidget {
  const SectionLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Shimmer.fromColors(
      baseColor: isDark 
          ? AppColors.shimmerBaseColorDark 
          : AppColors.shimmerBaseColorLight,
      highlightColor: isDark
          ? AppColors.shimmerBaseColorDark.withOpacity(0.5)
          : AppColors.shimmerBaseColorLight.withOpacity(0.5),
      period: const Duration(milliseconds: 1200),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: isDark 
              ? AppColors.shimmerBaseColorDark 
              : AppColors.shimmerBaseColorLight,
        ),
      ),
    );
  }
}

