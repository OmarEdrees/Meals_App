import 'package:flutter/material.dart';
import 'package:meals_final_project/logic/services/colors.dart';
import 'package:meals_final_project/logic/services/firebase_service.dart';
import 'package:meals_final_project/logic/services/variablesApp.dart';

class LogSignBigButtonWidget extends StatelessWidget {
  final String txt;
  final void Function()? onPressed;
  const LogSignBigButtonWidget({
    super.key,
    required this.txt,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    double screenWidth = screenSize.width;
    double screenHight = screenSize.height;
    return Column(
      children: [
        MaterialButton(
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),

          height: screenHight * 0.065,
          minWidth: double.infinity,
          color: ColorsApp().primaryColor,
          child: Text(
            txt,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.05,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: screenHight * 0.012),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                color: ColorsApp().primaryColor,
                height: screenHight * 0.004,
                width: screenWidth * 0.13,
              ),
              Text(
                'OR',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: screenWidth * 0.05,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                color: ColorsApp().primaryColor,
                height: screenHight * 0.004,
                width: screenWidth * 0.13,
              ),
            ],
          ),
        ),
        MaterialButton(
          onPressed: () async {
            await FirebaseService().signInWithGoogle(context);
            isLogGoogle = false;
            saveLoginState();
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          height: screenHight * 0.065,
          minWidth: double.infinity,
          color: ColorsApp().primaryColor,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                color: Colors.white,
                'assets/images/googleLogo2-removebg.png',
                height: screenWidth * 0.075,
                width: screenWidth * 0.075,
              ),
              SizedBox(width: screenWidth * 0.025),
              Text(
                'Log In With Google',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.05,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
