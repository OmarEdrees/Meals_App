import 'package:flutter/material.dart';
import 'package:meals_final_project/logic/services/colors.dart';

class StackProfileWidget extends StatelessWidget {
  const StackProfileWidget({
    super.key,
    required this.screenWidth,
    required this.screenHight,
  });

  final double screenWidth;
  final double screenHight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Container(
            height: screenWidth,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/profileImage.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          child: Container(
            height: screenWidth,
            decoration: BoxDecoration(
              color: const Color.fromARGB(216, 0, 0, 0),
            ),
          ),
        ),

        Positioned(
          left: 0,
          right: 0,
          top: screenWidth - 90,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(screenHight * 0.4),
            decoration: BoxDecoration(
              color: ColorsApp().backgroundColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: screenWidth - 154,
          child: Container(
            height: screenHight * 0.162,
            width: screenHight * 0.162,

            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: Offset.fromDirection(1.5, 1.5),
                  color: Colors.grey,
                  blurStyle: BlurStyle.normal,
                  blurRadius: 0.5,
                  spreadRadius: 0.2,
                ),
              ],
              image: DecorationImage(
                image: AssetImage('assets/images/profileImage.jpg'),
              ),
              shape: BoxShape.circle,
              color: ColorsApp().primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
