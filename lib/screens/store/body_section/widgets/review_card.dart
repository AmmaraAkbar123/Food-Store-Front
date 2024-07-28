import 'package:flutter/material.dart';
import 'package:foodstorefront/models/review_model.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:foodstorefront/screens/store/body_section/widgets/reviews_widget.dart';

class ReviewCard extends StatelessWidget {
  final List<ReviewModel> reviews; // List of reviews

  const ReviewCard({
    Key? key,
    required this.reviews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 25, left: 12, right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Fellow foodies say",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "See all",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: MyColors.primary),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: ReviewWidget(
                  review: reviews[index], // Pass review object
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
