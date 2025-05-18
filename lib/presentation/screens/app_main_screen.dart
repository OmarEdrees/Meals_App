import 'package:flutter/material.dart';
import 'package:meals_final_project/logic/services/colors.dart';
import 'package:meals_final_project/logic/services/variablesApp.dart';
import 'package:meals_final_project/presentation/screens/home_screen.dart';
import 'package:iconsax/iconsax.dart';
import 'package:meals_final_project/presentation/screens/quick_foods_screen.dart';
import 'package:meals_final_project/presentation/screens/favorite_screen.dart';
import 'package:meals_final_project/presentation/screens/profile_screen.dart';

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  int selectIndex = 0;
  final List screens = [
    HomeScreen(email: emailController.text.trim()),
    FavoriteScreen(ontap: () {}, text: 'Favorite'),
    QuickFoodsScreen(ontap: () {}),
    ProfileScreen(email: emailController.text.trim()),
  ];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    double screenHight = screenSize.height;
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: ColorsApp().backgroundColor,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: ColorsApp().primaryColor,
          unselectedItemColor: Colors.grey,
          currentIndex: selectIndex,
          elevation: 0,

          selectedIconTheme: IconThemeData(size: screenHight * 0.036),
          iconSize: screenHight * 0.032,
          type: BottomNavigationBarType.fixed,

          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: screenHight * 0.017,
          ),

          selectedLabelStyle: TextStyle(
            fontSize: screenHight * 0.018,
            fontWeight: FontWeight.w800,
            color: ColorsApp().primaryColor,
          ),
          onTap: (value) {
            setState(() {
              selectIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon:
                  selectIndex == 0 ? Icon(Iconsax.home5) : Icon(Iconsax.home_1),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon:
                  selectIndex == 1 ? Icon(Iconsax.heart5) : Icon(Iconsax.heart),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon:
                  selectIndex == 2
                      ? Icon(Iconsax.calendar5)
                      : Icon(Iconsax.calendar),
              label: 'Meal Plans',
            ),
            BottomNavigationBarItem(
              icon:
                  selectIndex == 3
                      ? Icon(Icons.person)
                      : Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),

        body: screens[selectIndex],
      ),
    );
  }
}
