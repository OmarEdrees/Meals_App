import 'package:flutter/material.dart';
import 'package:meals_final_project/logic/services/firebase_service.dart';
import 'package:meals_final_project/logic/services/variablesApp.dart';
import 'package:meals_final_project/presentation/screens/signup_screen.dart';
import 'package:meals_final_project/presentation/widgets/login_signup_screen_widgets/heading_widget.dart';
import 'package:meals_final_project/presentation/widgets/login_signup_screen_widgets/log_sign_bigButtonwidget.dart';
import 'package:meals_final_project/presentation/widgets/login_signup_screen_widgets/login_field_widget.dart';
import 'package:meals_final_project/presentation/widgets/login_signup_screen_widgets/login_small_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    double screenWidth = screenSize.width;
    double screenHight = screenSize.height;
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Positioned(
                    child: Container(
                      height: screenWidth - 75,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/food5.avif'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: screenWidth - 160,
                    child: Container(
                      height: screenHight * 0.15,
                      width: double.infinity,

                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(80),
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                if (isSignOrLog = true) {
                                  setState(() {
                                    isSignOrLog = false;
                                  });
                                }

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignupScreen(),
                                  ),
                                );
                              },
                              child: LoginSmallButton(
                                screenWidth: screenWidth,
                                screenHight: screenHight,
                                text: 'Sign Up',
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (isSignOrLog == false) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginScreen(),
                                    ),
                                  );
                                  if (isSignOrLog) {
                                    setState(() {
                                      isSignOrLog = true;
                                    });
                                  } else {
                                    setState(() {
                                      isSignOrLog = true;
                                    });
                                  }
                                } else {
                                  return;
                                }
                              },
                              child: LoginSmallButton(
                                screenWidth: screenWidth,
                                screenHight: screenHight,
                                text: 'Log In',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeadingWidget(
                      paddTop: screenHight * 0.025,
                      screenHight: screenHight,
                      screenWidth: screenWidth,
                      headingText: 'Welcome Back',
                    ),
                    SizedBox(height: screenHight * 0.01),
                    LoginFieldWidget(screenHight: screenHight),
                    SizedBox(height: screenHight * 0.013),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenHight * 0.018,

                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHight * 0.05),
                    LogSignBigButtonWidget(
                      onPressed: () {
                        FirebaseService().login(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                          context: context,
                        );
                        isLogGoogle = true;
                        saveLoginState();
                      },

                      txt: "Log In",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
