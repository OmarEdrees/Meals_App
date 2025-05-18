import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:meals_final_project/logic/services/object_for_get_api.dart';

class DetailsIngredientsWidget extends StatelessWidget {
  const DetailsIngredientsWidget({
    super.key,
    required this.objectForGetApi,
    required this.screenHight,
    required this.screenWidth,
  });
  final ObjectForGetApi objectForGetApi;
  final double screenHight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(
            top: screenHight * 0.002,
            bottom: screenHight * 0.01,
          ),
          child: Text(
            objectForGetApi.name,
            style: TextStyle(
              fontSize: screenWidth * 0.065,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: screenHight * 0.005),
          child: Row(
            children: [
              Icon(
                Iconsax.flash_1,
                size: screenWidth * 0.056,

                color: Colors.grey,
              ),
              Text(
                objectForGetApi.caloriesPerServing,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.grey,
                  letterSpacing: 0.01,
                ),
              ),
              const Text(" · ", style: TextStyle(color: Colors.grey)),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Icon(
                  Iconsax.clock,
                  size: screenWidth * 0.056,
                  color: Colors.grey,
                ),
              ),
              Text(
                objectForGetApi.prepTimeMinutes,
                style: TextStyle(
                  letterSpacing: 0.01,
                  fontSize: screenWidth * 0.04,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Icon(
              Iconsax.star1,
              color: Colors.yellow[700],
              size: screenWidth * 0.075,
            ),
            SizedBox(width: screenWidth * 0.009),
            Container(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                objectForGetApi.rating,

                style: TextStyle(
                  fontSize: screenWidth * 0.049,
                  color: Colors.grey.shade700,
                  letterSpacing: 0.01,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.02),
            Container(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                '(${objectForGetApi.reviewCount} Reviews)',

                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.grey,
                  letterSpacing: 0.01,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
