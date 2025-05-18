import 'package:flutter/material.dart';
import 'package:meals_final_project/logic/services/variablesApp.dart';

class LoginFieldWidget extends StatefulWidget {
  final double screenHight;
  const LoginFieldWidget({super.key, required this.screenHight});

  @override
  State<LoginFieldWidget> createState() => _LoginFieldWidgetState();
}

class _LoginFieldWidgetState extends State<LoginFieldWidget> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          loginField(
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
          loginField(
            icon: Icon(Icons.lock),
            obscureText: obscurePassword ? true : false,
            controller: passwordController,
            labelText: 'Password',
            hintText: 'Enter your password',

            //obscureText: true,
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
