import 'package:flutter/material.dart';
import 'package:meals_final_project/logic/services/colors.dart';
import 'package:meals_final_project/logic/services/object_for_get_api.dart';
import 'package:meals_final_project/logic/services/variablesApp.dart';
import 'package:meals_final_project/presentation/widgets/instructions_widget.dart';
import 'package:meals_final_project/presentation/widgets/quick_foods_screen_widgets/quick_food_appBar_widget.dart';

class InstructionsScreen extends StatefulWidget {
  const InstructionsScreen({super.key, required this.objectForGetApi});
  final ObjectForGetApi objectForGetApi;

  @override
  State<InstructionsScreen> createState() => _InstructionsScreenState();
}

class _InstructionsScreenState extends State<InstructionsScreen> {
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
      body:
          recipesList.isEmpty
              ? Center(
                child: CircularProgressIndicator(
                  color: ColorsApp().primaryColor,
                ),
              )
              : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(screenHight * 0.015),
                      child: SafeArea(
                        child: QuickFoodAppBarWidget(
                          ontap: () => Navigator.pop(context),
                          text: Text(
                            'Instructions',
                            style: TextStyle(
                              fontSize: screenWidth * 0.06,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenHight * 0.02,
                      ),
                      child: Column(
                        children: List.generate(
                          widget.objectForGetApi.instructions.length,
                          (index) {
                            return InstructionsWidget(
                              instructionsTips:
                                  widget.objectForGetApi.instructions[index],
                              objectForGetApi: recipesList[index],
                              counter: index + 1,
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: screenWidth * 0.04,
                        right: screenWidth * 0.065,
                        bottom: screenHight * 0.03,
                        top: screenHight * 0.02,
                      ),
                      child: Divider(color: Colors.grey.shade300, height: 0.7),
                    ),
                  ],
                ),
              ),
    );
  }
}
