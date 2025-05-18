import 'package:flutter/material.dart';
import 'package:meals_final_project/logic/services/colors.dart';
import 'package:meals_final_project/logic/services/variablesApp.dart';

class LoginSmallButton extends StatelessWidget {
  final String text;
  const LoginSmallButton({
    super.key,
    required this.text,
    required this.screenWidth,
    required this.screenHight,
  });

  final double screenWidth;
  final double screenHight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenHight * 0.012,
      ),

      width: screenWidth * 0.44,
      height: screenHight * 0.055,
      decoration: BoxDecoration(
        color:
            (isSignOrLog && text == 'Sign Up' ||
                    !isSignOrLog && text == 'Log In')
                ? Colors.white
                : ColorsApp().primaryColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(30),
          topRight: Radius.circular(30),
          topLeft: Radius.circular(80),
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color:
              (isSignOrLog && text == 'Sign Up' ||
                      !isSignOrLog && text == 'Log In')
                  ? ColorsApp().primaryColor
                  : Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
