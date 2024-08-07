import 'package:flutter/material.dart';

class CountryCodeProvider extends ChangeNotifier {
  String _countryCode = '92'; // Default country code for Pakistan
  String _countryFlag = '🇵🇰'; // Default flag for Pakistan

  String get countryCode => _countryCode;
  String get countryFlag => _countryFlag;

  void setCountryCode(String code, String flag) {
   // _countryCode = code;
    _countryFlag = flag;
    notifyListeners();
  }
}
