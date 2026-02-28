import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'prefs_provider.dart';

/// Provides the current app [Brightness] based on stored preferences,
/// falling back to the platform brightness on first launch.
final themeBrightnessProvider = Provider<Brightness>((ref) {
  final isDarkMode = ref.watch(prefsProvider).getBool('isDarkMode');
  if (isDarkMode == null) {
    return SchedulerBinding.instance.platformDispatcher.platformBrightness;
  }
  return isDarkMode ? Brightness.dark : Brightness.light;
});
