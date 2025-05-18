import 'package:flutter/material.dart';
import 'package:meals_final_project/logic/services/colors.dart';
import 'package:meals_final_project/logic/services/variablesApp.dart';
import 'package:meals_final_project/presentation/widgets/quick_foods_screen_widgets/card_gridView_part_widget.dart';
import 'package:meals_final_project/presentation/widgets/quick_foods_screen_widgets/quick_food_appBar_widget.dart';

class QuickFoodsScreen extends StatefulWidget {
  final void Function()? ontap;

  const QuickFoodsScreen({super.key, this.ontap});

  @override
  State<QuickFoodsScreen> createState() => _QuickFoodsScreenState();
}

class _QuickFoodsScreenState extends State<QuickFoodsScreen> {
  @override
  void initState() {
    getRecipes(context, () {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    double screenWidth = screenSize.width;
    double screenHight = screenSize.height;
    return Scaffold(
      backgroundColor: ColorsApp().backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: screenHight * 0.01,
              top: screenHight * 0.015,
              right: screenHight * 0.015,
              left: screenHight * 0.015,
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: screenHight * 0.015),
                  child: QuickFoodAppBarWidget(
                    ontap: widget.ontap,
                    text: Text(
                      'Quick & Easy',
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                recipesList.isEmpty
                    ? Center(
                      child: Container(
                        margin: EdgeInsets.only(top: screenHight * 0.35),
                        child: CircularProgressIndicator(
                          color: ColorsApp().primaryColor,
                        ),
                      ),
                    )
                    : GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.8,
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: recipesList.length,
                      itemBuilder: (context, index) {
                        return CardGridViewPartWidget(
                          loading: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                color: ColorsApp().primaryColor,
                              ),
                            );
                          },
                          objectForGetApi: recipesList[index],
                          screenHight: screenHight,
                          screenWidth: screenWidth,
                        );
                      },
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
