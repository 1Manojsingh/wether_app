import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utilities/design_utility.dart';

class AppButton extends ConsumerStatefulWidget {
  const AppButton(
      {required this.child,
      this.style,
      this.onPressed,
      this.shrinkOnLoading = true,
      super.key,
      this.soundFx,
      this.completedSoundFx});

  final ButtonStyle? style;
  final Widget child;
  final Function? onPressed;
  final bool shrinkOnLoading;
  final String? soundFx;
  final String? completedSoundFx;

  @override
  ConsumerState<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends ConsumerState<AppButton> {
  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: isLoading && widget.shrinkOnLoading
            ? const CircleBorder(side: BorderSide.none)
            : null,
      ).merge(widget.style),
      onPressed:
          widget.onPressed != null && !isLoading ? (){} : null,
      child: buildLoadingAwareChild(context),
    );
  }

  Widget buildLoadingAwareChild(BuildContext context) {
    if (isLoading && !widget.shrinkOnLoading) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildLoader(context),
          horizontalSpaceRegular,
          widget.child,
        ],
      );
    }
    if (isLoading) return buildLoader(context);
    return widget.child;
  }

  Widget buildLoader(BuildContext context) {
    return const SizedBox(
      height: 15,
      width: 15,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        valueColor: AlwaysStoppedAnimation(Colors.grey),
      ),
    );
  }
}
