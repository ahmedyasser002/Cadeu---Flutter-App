import 'package:demo_project/constants/app_colors.dart';
import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int rating;
  final int maxRating;
  final Color filledStarColor;
  final Color outlinedStarColor;

  const StarRating({super.key, 
    required this.rating,
    this.maxRating = 5,
    this.filledStarColor = AppColors.goldStarColor,
    this.outlinedStarColor = AppColors.outlineStarColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxRating, (index) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.star_border,
              color: outlinedStarColor,
            ),
            Icon(
              Icons.star,
              color: rating > index ? filledStarColor : Colors.transparent,
            ),
          ],
        );
      }),
    );
  }
}