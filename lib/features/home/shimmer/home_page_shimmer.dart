import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utilities/design_utility.dart';

class HomePageShimmer extends StatelessWidget {
  const HomePageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark 
        ? AppColors.shimmerBaseColorDark 
        : AppColors.shimmerBaseColorLight;
    final highlightColor = isDark
        ? AppColors.shimmerBaseColorDark.withOpacity(0.5)
        : AppColors.shimmerBaseColorLight.withOpacity(0.5);

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      period: const Duration(milliseconds: 1200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                colors: isDark
                    ? [AppColors.shimmerBaseColorDark, AppColors.shimmerBaseColorDark.withOpacity(0.8)]
                    : [AppColors.shimmerBaseColorLight, AppColors.shimmerBaseColorLight.withOpacity(0.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          verticalSpaceMedium,
          
          Container(
            height: 20,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: baseColor,
            ),
          ),
          verticalSpaceRegular,
          
          SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              separatorBuilder: (_, __) => horizontalSpaceRegular,
              itemBuilder: (_, __) => Container(
                width: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: baseColor,
                ),
              ),
            ),
          ),
          verticalSpaceRegular,
          
          Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: baseColor,
            ),
          ),
        ],
      ),
    );
  }
}

