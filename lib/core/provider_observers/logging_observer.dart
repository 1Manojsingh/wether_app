import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Simple logger for Riverpod provider changes, compatible with
/// the newer Riverpod 3.x `ProviderObserver` API.
base class ProviderLogger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    debugPrint(
      '(PROVIDER_OBSERVER) ${context.provider} updated from $previousValue to $newValue',
    );
  }

  @override
  void didAddProvider(
    ProviderObserverContext context,
    Object? value,
  ) {
    debugPrint(
      '(PROVIDER_OBSERVER) ${context.provider} added with value $value',
    );
  }

  @override
  void didDisposeProvider(ProviderObserverContext context) {
    debugPrint(
      '(PROVIDER_OBSERVER) ${context.provider} disposed',
    );
  }
}

