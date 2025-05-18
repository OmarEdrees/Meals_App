import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:meals_final_project/logic/cubit/favorite_cubit_cubit.dart';
import 'package:meals_final_project/logic/services/colors.dart';
import 'package:meals_final_project/logic/services/firebase_service.dart';
import 'package:meals_final_project/logic/services/variablesApp.dart';
import 'package:meals_final_project/presentation/widgets/quick_foods_screen_widgets/quick_food_appBar_widget.dart';

class EditeProfile extends StatefulWidget {
  final String oldFirstName;
  final String oldLastName;
  final String oldPassword;
  final String email;

  const EditeProfile({
    super.key,
    required this.email,
    required this.oldFirstName,
    required this.oldLastName,
    required this.oldPassword,
  });

  @override
  State<EditeProfile> createState() => _EditeProfileState();
}

class _EditeProfileState extends State<EditeProfile> {
  late final GlobalKey<FormState> _formKey;
  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    firstNameController.text = widget.oldFirstName;
    lastNameController.text = widget.oldLastName;
    passwordController.text = widget.oldPassword;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    double screenWidth = screenSize.width;
    double screenHight = screenSize.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: screenHight * 0.01,
              top: screenHight * 0.015,
              right: screenHight * 0.015,
              left: screenHight * 0.015,
            ),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: screenHight * 0.03),
                    child: QuickFoodAppBarWidget(
                      ontap: () {
                        Navigator.pop(context);
                      },
                      text: Text(
                        'Edite Profile',
                        style: TextStyle(
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  BlocListener<UserCubit, String>(
                    listener: (context, updatedName) {
                      firstNameController.text = updatedName;
                    },
                    child: signupField(
                      icon: Icon(Icons.person),
                      controller: firstNameController,
                      //controller: ,
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
                  ),

                  SizedBox(height: screenHight * 0.04),
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
                  SizedBox(height: screenHight * 0.04),

                  signupField(
                    icon: Icon(Icons.lock),
                    obscureText: obscurePassword ? true : false,
                    controller: passwordController,
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },

                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() => obscurePassword = !obscurePassword);
                      },
                    ),
                  ),
                  SizedBox(height: screenHight * 0.05),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          FirebaseService().updateFirebase(
                            context: context,
                            email: widget.email,
                            password: passwordController.text.trim(),
                            firstName: firstNameController.text.trim(),
                            lastName: lastNameController.text.trim(),
                          );

                          String newName =
                              firstNameController.text
                                  .trim(); // <-- هنا نحصل على الاسم الجديد
                          context.read<UserCubit>().updateUsername(
                            newName,
                          ); // نحدث الاسم في Cubit
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please fill textFields')),
                          );
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),

                      height: screenHight * 0.065,
                      minWidth: double.infinity,
                      color: ColorsApp().primaryColor,
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.05,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
