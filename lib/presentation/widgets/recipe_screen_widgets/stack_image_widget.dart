import 'package:flutter/material.dart';
import 'package:meals_final_project/presentation/widgets/quick_foods_screen_widgets/quick_food_appBar_widget.dart';

class StackImageWidget extends StatelessWidget {
  const StackImageWidget({
    super.key,
    required this.image,
    required this.screenWidth,
    required this.screenHight,
  });
  final dynamic image;
  final double screenWidth;
  final double screenHight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Container(
            height: screenWidth - 20,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(screenHight * 0.015),
          child: SafeArea(
            child: QuickFoodAppBarWidget(
              text: Text(''),
              ontap: () => Navigator.pop(context),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: screenWidth - 50,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
