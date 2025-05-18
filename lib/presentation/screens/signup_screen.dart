// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:meals_final_project/logic/services/firebase_service.dart';
import 'package:meals_final_project/logic/services/variablesApp.dart';
import 'package:meals_final_project/presentation/screens/Login_screen.dart';
import 'package:meals_final_project/presentation/widgets/login_signup_screen_widgets/heading_widget.dart';
import 'package:meals_final_project/presentation/widgets/login_signup_screen_widgets/log_sign_bigButtonwidget.dart';
import 'package:meals_final_project/presentation/widgets/login_signup_screen_widgets/signup_field_widget.dart';
import 'package:meals_final_project/presentation/widgets/login_signup_screen_widgets/signup_small_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    double screenWidth = screenSize.width;
    double screenHight = screenSize.height;
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
                                if (isSignOrLog) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignupScreen(),
                                    ),
                                  );
                                  if (isSignOrLog = true) {
                                    setState(() {
                                      isSignOrLog = false;
                                    });
                                  }
                                } else {
                                  return;
                                }
                              },
                              child: SignupSmallButton(
                                screenWidth: screenWidth,
                                screenHight: screenHight,
                                text: 'Sign Up',
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
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
                              },
                              child: SignupSmallButton(
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
                      headingText: 'Create new account',
                    ),
                    SizedBox(height: screenHight * 0.01),
                    SignupFieldWidget(
                      screenHight: screenHight,
                      formKey: _signupFormKey,
                    ),
                    SizedBox(height: screenHight * 0.025),

                    LogSignBigButtonWidget(
                      onPressed: () {
                        if (_signupFormKey.currentState!.validate()) {
                          FirebaseService().signup(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            context: context,
                          );
                          isLogGoogle = true;
                          isSignOrLog = true;
                          FirebaseService().setFirebase(
                            context: context,
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            lastName: lastNameController.text,
                            firstName: firstNameController.text,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please fill textFields')),
                          );
                        }
                      },

                      txt: "Sign Up",
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
