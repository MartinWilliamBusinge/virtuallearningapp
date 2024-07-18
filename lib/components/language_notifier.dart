import 'package:flutter/material.dart';

class LanguageNotifier with ChangeNotifier {
  Locale _currentLocale;

  LanguageNotifier(this._currentLocale);

  Locale get currentLocale => _currentLocale;

  void setLocale(Locale locale) {
    _currentLocale = locale;
    notifyListeners();
  }
}