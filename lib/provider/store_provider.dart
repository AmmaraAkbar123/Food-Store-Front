import 'package:flutter/material.dart';

class DeliveryInfoProvider with ChangeNotifier {
  bool _isAppBarExpanded = false;
  bool _isCollapsed = false;

  bool get isAppBarExpanded => _isAppBarExpanded;
  bool get isCollapsed => _isCollapsed;

  void setAppBarExpanded(bool value) {
    if (_isAppBarExpanded != value) {
      _isAppBarExpanded = value;
      notifyListeners();
    }
  }

  void setCollapsed(bool value) {
    if (_isCollapsed != value) {
      _isCollapsed = value;
      notifyListeners();
    }
  }
}
