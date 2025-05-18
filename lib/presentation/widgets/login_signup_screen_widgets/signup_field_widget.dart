import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:meals_final_project/logic/services/variablesApp.dart';

class SignupFieldWidget extends StatefulWidget {
  final double screenHight;
  final GlobalKey<FormState> formKey;
  const SignupFieldWidget({
    super.key,
    required this.screenHight,
    required this.formKey,
  });

  @override
  State<SignupFieldWidget> createState() => _SignupFieldWidgetState();
}

class _SignupFieldWidgetState extends State<SignupFieldWidget> {
  @override
  void initState() {
    super.initState();
    widget.formKey;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          signupField(
            icon: Icon(Icons.person),
            controller: firstNameController,
            labelText: 'First Name',
            hintText: 'Enter your Name',
            obscureText: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              if (value.length < 3) {
                return 'Name must be at least 2 characters';
              }
              return null;
            },
          ),

          SizedBox(height: widget.screenHight * 0.015),
          signupField(
            icon: Icon(Iconsax.personalcard5),
            controller: lastNameController,
            labelText: 'Last Name',
            hintText: 'Enter your Last Name',
            obscureText: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your last name';
              }
              return null;
            },
            keyboardType: TextInputType.name,
          ),
          SizedBox(height: widget.screenHight * 0.015),
          signupField(
            icon: Icon(Icons.email),
            controller: emailController,
            labelText: 'Email',
            hintText: 'Enter your Email',
            obscureText: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              ).hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: widget.screenHight * 0.015),
          signupField(
            icon: Icon(Icons.lock),
            obscureText: obscurePassword ? true : false,
            controller: passwordController,
            labelText: 'Password',
            hintText: 'Enter your password',

            suffixIcon: IconButton(
              icon: Icon(
                obscurePassword ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() => obscurePassword = !obscurePassword);
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
