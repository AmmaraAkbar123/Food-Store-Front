import 'package:flutter/material.dart';
import 'package:foodstorefront/models/review_model.dart';

class ReviewProvider extends ChangeNotifier {
  List<ReviewModel> _reviews = [];

  List<ReviewModel> get reviews => _reviews;

  void setReviews(List<ReviewModel> reviews) {
    _reviews = reviews;
    notifyListeners();
  }
}
