import 'package:flutter/material.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:foodstorefront/models/review_model.dart';
import 'package:foodstorefront/utils/colors.dart';

class ReviewWidget extends StatelessWidget {
  final ReviewModel review;

  const ReviewWidget({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate time ago
    String timeAgo = getTimeAgo(review.reviewTime);

    return Container(
      height: 130,
      //  width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: MyColors.grey.withOpacity(0.3))),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 260,
              child: Text(
                review.reviewText,
                style: TextStyle(fontSize: 12, overflow: TextOverflow.clip),
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                RatingBar(
                  size: 15,
                  alignment: Alignment.center,
                  filledIcon: Icons.star,
                  emptyIcon: Icons.star_border,
                  emptyColor: MyColors.primary,
                  filledColor: Colors.amberAccent,
                  halfFilledIcon: Icons.star_half,
                  halfFilledColor: Colors.amberAccent,
                  initialRating: review.rating,
                  maxRating: 5,
                  onRatingChanged: (double) {},
                ),
                SizedBox(width: 8),
                Text(
                  review.reviewerName,
                  style: TextStyle(color: MyColors.greyText, fontSize: 12),
                ),
                SizedBox(width: 8),
                Text(
                  timeAgo,
                  style: TextStyle(color: MyColors.greyText, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String getTimeAgo(DateTime reviewTime) {
    Duration timeDifference = DateTime.now().difference(reviewTime);
    if (timeDifference.inDays > 0) {
      return '${timeDifference.inDays}d ago';
    } else if (timeDifference.inHours > 0) {
      return '${timeDifference.inHours}h ago';
    } else if (timeDifference.inMinutes > 0) {
      return '${timeDifference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
