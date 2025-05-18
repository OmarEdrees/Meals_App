import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals_final_project/logic/cubit/favorite_cubit_cubit.dart';
import 'package:meals_final_project/logic/services/colors.dart';
import 'package:meals_final_project/logic/services/firebase_service.dart';
import 'package:meals_final_project/logic/services/variablesApp.dart';
import 'package:meals_final_project/presentation/widgets/home_screen_widgets/card_gridView_part_homeScreen_widget.dart';
import 'package:meals_final_project/presentation/widgets/home_screen_widgets/categories_part_widget.dart';
import 'package:meals_final_project/presentation/widgets/home_screen_widgets/explore_part_widget.dart';
import 'package:meals_final_project/presentation/widgets/home_screen_widgets/header_part_widget.dart';
import 'package:meals_final_project/presentation/widgets/home_screen_widgets/quick_word_part.dart';
import 'package:meals_final_project/presentation/widgets/home_screen_widgets/search_part_widget.dart';

class HomeScreen extends StatefulWidget {
  final String email;
  const HomeScreen({super.key, required this.email});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic> userData = {};
  Future<void> getData() async {
    userData = await FirebaseService().getFirebase(
      context: context,
      email: widget.email,
    );
    setState(() {});
  }

  @override
  void initState() {
    getRecipes(context, () {
      if (mounted) {
        setState(() {});
      }
    });
    context.read<FavoriteCubit>().loadFavoritesFromFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String currentCat = 'All';
    Size screenSize = MediaQuery.sizeOf(context);
    double screenWidth = screenSize.width;
    double screenHight = screenSize.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(screenHight * 0.015),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHight * 0.01),
                HeaderPartWidget(screenWidth: screenWidth),
                SizedBox(height: screenHight * 0.02),
                SearchPartWidget(),
                SizedBox(height: screenHight * 0.02),
                ExplorePartWidget(
                  screenHight: screenHight,
                  screenWidth: screenWidth,
                ),
                CategoriesPartWidget(
                  screenHight: screenHight,
                  screenWidth: screenWidth,
                  currentCat: currentCat,
                ),
                QuickWordPart(
                  screenHight: screenHight,
                  screenWidth: screenWidth,
                ),
                Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child:
                        recipesList.isEmpty
                            ? SizedBox(
                              height: screenHight * 0.25,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: ColorsApp().primaryColor,
                                ),
                              ),
                            )
                            : Row(
                              children: List.generate(recipesList.length, (
                                index,
                              ) {
                                return CardGridViewPartHomeScreenWidget(
                                  loading: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: ColorsApp().primaryColor,
                                      ),
                                    );
                                  },
                                  objectForGetApi: recipesList[index],
                                  screenWidth: screenWidth,
                                  screenHight: screenHight,
                                );
                              }),
                            ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
