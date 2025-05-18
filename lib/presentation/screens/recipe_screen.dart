import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:meals_final_project/logic/services/object_for_get_api.dart';
import 'package:meals_final_project/logic/services/variablesApp.dart';
import 'package:meals_final_project/presentation/widgets/recipe_screen_widgets/bottoomNBar_widget.dart';
import 'package:meals_final_project/presentation/widgets/recipe_screen_widgets/ingredient_of_recipe_widget.dart';
import 'package:meals_final_project/presentation/widgets/recipe_screen_widgets/stack_image_widget.dart';

class RecipeScreen extends StatefulWidget {
  final ObjectForGetApi objectForGetApi;

  const RecipeScreen({super.key, required this.objectForGetApi});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
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
      bottomNavigationBar: BottoomNBarWidget(
        screenHight: screenHight,
        screenWidth: screenWidth,
        objectForGetApi: widget.objectForGetApi,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StackImageWidget(
              image: widget.objectForGetApi.image,
              screenWidth: screenWidth,
              screenHight: screenHight,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: screenHight * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          top: screenHight * 0.002,
                          bottom: screenHight * 0.01,
                        ),
                        child: Text(
                          widget.objectForGetApi.name,
                          style: TextStyle(
                            fontSize: screenWidth * 0.065,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: screenHight * 0.005),
                        child: Row(
                          children: [
                            Icon(
                              Iconsax.flash_1,
                              size: screenWidth * 0.056,

                              color: Colors.grey,
                            ),
                            Text(
                              widget.objectForGetApi.caloriesPerServing,
                              style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                color: Colors.grey,
                                letterSpacing: 0.01,
                              ),
                            ),
                            const Text(
                              " · ",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Icon(
                                Iconsax.clock,
                                size: screenWidth * 0.056,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              widget.objectForGetApi.prepTimeMinutes,
                              style: TextStyle(
                                letterSpacing: 0.01,
                                fontSize: screenWidth * 0.04,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Iconsax.star1,
                            color: Colors.yellow[700],
                            size: screenWidth * 0.075,
                          ),
                          SizedBox(width: screenWidth * 0.009),
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              widget.objectForGetApi.rating,

                              style: TextStyle(
                                fontSize: screenWidth * 0.049,
                                color: Colors.grey.shade700,
                                letterSpacing: 0.01,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              '(${widget.objectForGetApi.reviewCount} Reviews)',

                              style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                color: Colors.grey,
                                letterSpacing: 0.01,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Container(
                    padding: EdgeInsets.only(
                      top: screenHight * 0.04,
                      bottom: screenHight * 0.01,
                    ),
                    child: Text(
                      'Ingredients',
                      style: TextStyle(
                        fontSize: screenWidth * 0.065,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Column(
                    children: List.generate(
                      widget.objectForGetApi.ingredients.length,
                      (index) {
                        return IngredientOfRecipe(
                          counter: index + 1,

                          ingredientName:
                              widget.objectForGetApi.ingredients[index],
                          screenWidth: screenWidth,
                          screenHight: screenHight,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
