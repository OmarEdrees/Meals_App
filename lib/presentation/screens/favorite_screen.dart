import 'package:flutter/material.dart';
import 'package:meals_final_project/logic/services/colors.dart';
import 'package:meals_final_project/presentation/widgets/card_delete_widget.dart';
import 'package:meals_final_project/presentation/widgets/quick_foods_screen_widgets/quick_food_appBar_widget.dart';

class FavoriteScreen extends StatelessWidget {
  final String text;
  final void Function()? ontap;

  const FavoriteScreen({super.key, required this.text, required this.ontap});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    double screenWidth = screenSize.width;
    double screenHight = screenSize.height;
    return Scaffold(
      backgroundColor: ColorsApp().backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(screenHight * 0.015),
              child: QuickFoodAppBarWidget(
                ontap: ontap,
                text: Text(
                  'Favorite',
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            CardDeleteWidget(
              screenWidth: screenWidth,
              screenHight: screenHight,
            ),
          ],
        ),
      ),
    );
  }
}
