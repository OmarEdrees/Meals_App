import 'package:flutter/material.dart';

class HeadingWidget extends StatelessWidget {
  final String headingText;
  final double screenHight;
  final double screenWidth;
  final double paddTop;

  const HeadingWidget({
    super.key,
    required this.paddTop,
    required this.headingText,
    required this.screenHight,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: screenHight * 0.006, top: paddTop),
      child: Text(
        headingText,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'Biofit',
          fontSize: screenWidth * 0.08,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
