import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LocalizationService extends ChangeNotifier {
  Locale _locale = const Locale('en'); // Default language

  Locale get locale => _locale;

  Map<String, String> _localizedStrings = {};

  Future<void> loadLanguage(String languageCode) async {
    String jsonString = await rootBundle.loadString('assets/lang/$languageCode.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));

    _locale = Locale(languageCode);
    notifyListeners(); // Notify all pages to rebuild
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}
