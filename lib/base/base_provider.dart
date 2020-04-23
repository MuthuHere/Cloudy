import 'package:flutter/material.dart';

class BaseProvider extends ChangeNotifier {
  bool _isLoading;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
