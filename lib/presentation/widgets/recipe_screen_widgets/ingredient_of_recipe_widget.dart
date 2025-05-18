import 'package:flutter/material.dart';
import 'package:meals_final_project/logic/services/colors.dart';

class IngredientOfRecipe extends StatelessWidget {
  final int counter;
  final String ingredientName;
  final double screenWidth;
  final double screenHight;

  const IngredientOfRecipe({
    super.key,
    required this.ingredientName,
    required this.counter,
    required this.screenWidth,
    required this.screenHight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              right: screenWidth * 0.015,
              bottom: screenHight * 0.018,
              top: screenHight * 0.018,
            ),
            child: Divider(color: Colors.grey.shade300, height: 0.7),
          ),
          Row(
            children: [
              Container(
                alignment: Alignment.center,

                margin: EdgeInsets.only(right: screenWidth * 0.02),

                height: screenHight * 0.04,
                width: screenHight * 0.04,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorsApp().primaryColor,
                ),
                child: Text(
                  textAlign: TextAlign.center,
                  '$counter',
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.04),
              SizedBox(
                width: screenWidth * 0.76,
                child: Text(
                  ingredientName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
