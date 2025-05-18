import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:meals_final_project/logic/cubit/favorite_cubit_cubit.dart';
import 'package:meals_final_project/logic/services/colors.dart';
import 'package:meals_final_project/logic/services/firebase_service.dart';
import 'package:meals_final_project/logic/services/variablesApp.dart';
import 'package:meals_final_project/presentation/screens/Login_screen.dart';
import 'package:meals_final_project/presentation/screens/favorite_screen.dart';
import 'package:meals_final_project/presentation/screens/edite_profile_screen.dart';
import 'package:meals_final_project/presentation/screens/quick_foods_screen.dart';
import 'package:meals_final_project/presentation/widgets/profile_screen_widgets/profile_card_widget.dart';
import 'package:meals_final_project/presentation/widgets/profile_screen_widgets/stack_profile_widget.dart';

class ProfileScreen extends StatefulWidget {
  final String email;
  const ProfileScreen({super.key, required this.email});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic> userData = {};
  Future<void> getUser() async {
    final data = await FirebaseService().getFirebase(
      context: context,
      email: widget.email,
    );
    userData = data;
    setState(() {});
  }

  //////// هذه الدالة لتحديث الاسم في صفحة profile_screen  ///////////
  Future<void> fetchData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Map<String, dynamic>? data = await FirebaseService()
          .getUserDataFromFirestore(user.email!);
      if (data != null) {
        setState(() {
          userData = data;
        });
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isLogGoogle == true) {
      getUser();
    } else {
      fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    double screenWidth = screenSize.width;
    double screenHight = screenSize.height;
    return Scaffold(
      backgroundColor: ColorsApp().backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            StackProfileWidget(
              screenWidth: screenWidth,
              screenHight: screenHight,
            ),
            BlocBuilder<UserCubit, String>(
              builder: (context, state) {
                return Text(
                  state.isEmpty ? '${userData['firstName'] ?? ''}' : state,

                  style: TextStyle(
                    fontSize: screenWidth * 0.08,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),

            SizedBox(height: screenHight * 0.025),
            ProfileCard(
              name: 'Edite Profile',
              icon: Icons.person,
              ontap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => EditeProfile(
                          oldFirstName: userData['firstName'] ?? '',
                          oldLastName: userData['lastName'] ?? '',
                          oldPassword: userData['password'] ?? '',
                          email: userData['email'] ?? '',
                        ),
                  ),
                );
              },
            ),
            SizedBox(height: screenHight * 0.024),
            ProfileCard(
              name: 'Meal Plan',
              icon: Iconsax.calendar5,
              ontap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => QuickFoodsScreen(
                            ontap: () {
                              Navigator.pop(context);
                            },
                          ),
                    ),
                  ),
            ),
            SizedBox(height: screenHight * 0.024),
            ProfileCard(
              name: 'Favorite',
              icon: Iconsax.heart5,
              ontap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => FavoriteScreen(
                            text: 'Favorite',
                            ontap: () => Navigator.pop(context),
                          ),
                    ),
                  ),
            ),

            SizedBox(height: screenHight * 0.024),
            ProfileCard(
              name: 'logout',
              icon: Icons.logout,
              ontap: () async {
                await FirebaseService().signOutGoogle(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
                isSignOrLog = true;
                await FirebaseService().logout(context);
                emailController.clear();
                passwordController.clear();
                firstNameController.clear();
                lastNameController.clear();
              },
            ),
            SizedBox(height: screenHight * 0.024),
            ProfileCard(
              name: 'Delet Account',
              icon: Icons.delete,
              ontap: () async {
                isSignOrLog = false;
                await FirebaseService().deleteEmailPasswordAccount(
                  context: context,
                  // email: emailController.text.trim(),
                );
                emailController.clear();
                passwordController.clear();
                firstNameController.clear();
                lastNameController.clear();
              },
            ),
            SizedBox(height: screenHight * 0.024),
          ],
        ),
      ),
    );
  }
}
