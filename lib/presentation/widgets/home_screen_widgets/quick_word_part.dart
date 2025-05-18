import 'package:flutter/material.dart';
import 'package:meals_final_project/logic/services/colors.dart';
import 'package:meals_final_project/presentation/screens/quick_foods_screen.dart';

class QuickWordPart extends StatelessWidget {
  const QuickWordPart({
    super.key,
    required this.screenHight,
    required this.screenWidth,
  });

  final double screenHight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: screenHight * 0.02),
          child: Text(
            'Quick & Easy',
            style: TextStyle(
              fontSize: screenWidth * 0.06,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) =>
                        QuickFoodsScreen(ontap: () => Navigator.pop(context)),
              ),
            );
          },
          child: Text(
            'View all',
            style: TextStyle(
              fontSize: screenWidth * 0.039,
              fontWeight: FontWeight.bold,
              color: ColorsApp().primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
