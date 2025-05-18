import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class IngredientsPartRecipeWidget extends StatelessWidget {
  const IngredientsPartRecipeWidget({
    super.key,
    required this.screenHight,
    required this.screenWidth,
  });
  final double screenHight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: screenHight * 0.04,
                    bottom: screenHight * 0.01,
                  ),
                  child: Text(
                    'Ingredients',
                    style: TextStyle(
                      fontSize: screenWidth * 0.065,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  "How many servings?",
                  style: TextStyle(
                    fontSize: screenWidth * 0.043,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Spacer(),
            Container(
              height: screenHight * 0.075,
              padding: EdgeInsets.symmetric(horizontal: screenHight * 0.02),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Iconsax.minus,
                    size: screenWidth * 0.065,
                    color: Colors.black,
                  ),
                  SizedBox(width: screenWidth * 0.05),
                  Text(
                    '1',
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.05),
                  Icon(
                    Iconsax.add,

                    size: screenWidth * 0.065,

                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: screenHight * 0.01),
      ],
    );
  }
}
