import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../utilities/design_utility.dart';

class LabeledWidget extends StatelessWidget {
  const LabeledWidget(
      {super.key,
      required this.label,
      required this.child,
      this.color = AppColors.textGray});

  final String label;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme(context).bodySmall?.copyWith(color: color),
        ),
        verticalSpaceRegular,
        child,
      ],
    );
  }
}
