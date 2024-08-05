class ReviewModel {
  final String reviewText;
  final double rating;
  final String reviewerName;
  final DateTime reviewTime;

  ReviewModel({
    required this.reviewText,
    required this.rating,
    required this.reviewerName,
    required this.reviewTime,
  });
}

// Example list of reviews (replace with actual data from API or elsewhere)
final List<ReviewModel> reviews = [
  ReviewModel(
    reviewText: 'Delicious food, loved it!',
    rating: 4,
    reviewerName: 'John Doe',
    reviewTime: DateTime.now().subtract(const Duration(days: 5)),
  ),
  ReviewModel(
    reviewText:
        'Fast delivery Delicious food, loved it! ghdddddavgvcajhscbgkhafsg hdbjahwjhjahwjhbdjhbv and great taste!',
    rating: 5.0,
    reviewerName: 'Jane Smith',
    reviewTime: DateTime.now().subtract(const Duration(hours: 3)),
  ),
  // ReviewModel(
  //   reviewText: 'Delicious food, loved it!',
  //   rating: 4,
  //   reviewerName: 'John Doe',
  //   reviewTime: DateTime.now().subtract(Duration(days: 5)),
  // ),
  // ReviewModel(
  //   reviewText: 'Delicious food, loved it!',
  //   rating: 3,
  //   reviewerName: 'John Doe',
  //   reviewTime: DateTime.now().subtract(Duration(days: 5)),
  // ),
  // Add more reviews as needed
];
