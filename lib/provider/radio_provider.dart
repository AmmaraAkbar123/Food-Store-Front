import 'package:flutter/material.dart';

class RadioProvider with ChangeNotifier {
  int _selectedValue = 0;

  int get selectedValue => _selectedValue;

  void updateSelectedValue(int value) {
    _selectedValue = value;
    notifyListeners();
  }
}
