import 'package:flutter/material.dart';

mixin SimpleLoaderMixin<T extends StatefulWidget> on State<T> {
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  void showLoader() {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
  }

  void hideLoader() {
    if (!_isLoading) return;
    setState(() {
      _isLoading = false;
    });
  }
}
