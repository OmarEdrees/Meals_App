import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:meals_final_project/logic/services/colors.dart';
import 'package:meals_final_project/logic/services/object_for_get_api.dart';
import 'package:meals_final_project/logic/services/variablesApp.dart';
import 'package:meals_final_project/presentation/screens/recipe_screen.dart';

class SearchPartWidget extends StatefulWidget {
  const SearchPartWidget({super.key});

  @override
  State<SearchPartWidget> createState() => _SearchPartWidgetState();
}

class _SearchPartWidgetState extends State<SearchPartWidget> {
  final TextEditingController searchController = TextEditingController();

  List<ObjectForGetApi> searchResults = [];

  void onSearchChanged(String value) {
    if (value.isEmpty) {
      setState(() {
        searchResults.clear();
      });
    } else {
      // فلترة القائمة بحسب value
      final results =
          recipesList
              .where(
                (recipe) =>
                    recipe.name.toLowerCase().contains(value.toLowerCase()),
              )
              .toList();

      setState(() {
        searchResults = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    double screenWidth = screenSize.width;
    double screenHight = screenSize.height;
    return Column(
      children: [
        TextField(
          controller: searchController,
          onChanged: onSearchChanged,
          cursorColor: Colors.black,

          decoration: InputDecoration(
            floatingLabelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorsApp().primaryColor,
            ),
            border: InputBorder.none,
            hintText: 'Search any recipes',
            filled: true,
            fillColor: Colors.white,
            hintStyle: TextStyle(color: Colors.grey),
            prefixIcon: Icon(Iconsax.search_normal),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),

          onSubmitted: (value) async {
            ObjectForGetApi? foundItem;
            try {
              foundItem = recipesList.firstWhere(
                (recipe) => recipe.name.toLowerCase() == value.toLowerCase(),
              );
            } catch (e) {
              foundItem = null;
            }

            if (foundItem != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => RecipeScreen(objectForGetApi: foundItem!),
                ),
              );
              searchController.clear();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('The element is not present')),
              );
              searchController.clear();
              setState(() {
                searchResults.clear();
              });
            }
          },
        ),
        if (searchController.text.isNotEmpty && searchResults.isNotEmpty) ...[
          SizedBox(height: screenHight * 0.01),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color.fromARGB(255, 241, 241, 241),
            ),
            padding: EdgeInsets.only(top: screenWidth * 0.04),

            child: ListView.builder(
              shrinkWrap: true, // مهم داخل Column
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => RecipeScreen(
                              objectForGetApi: searchResults[index],
                            ),
                      ),
                    );

                    searchController.clear();
                    setState(() {
                      searchResults.clear();
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: screenWidth * 0.04,
                      right: screenWidth * 0.03,
                      left: screenWidth * 0.03,
                    ),
                    padding: EdgeInsets.only(right: screenWidth * 0.04),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          offset: Offset.fromDirection(1.5, 1.5),
                          color: Colors.grey,
                          blurStyle: BlurStyle.normal,
                          blurRadius: 0.5,
                          spreadRadius: 0.2,
                        ),
                      ],

                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: screenWidth * 0.03),
                          height: screenHight * 0.11,
                          width: screenWidth * 0.23,

                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(searchResults[index].image),
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: screenWidth * 0.54,
                              child: Text(
                                searchResults[index].name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: screenWidth * 0.045,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Iconsax.flash_1,
                                  size: screenWidth * 0.05,

                                  color: Colors.grey,
                                ),
                                Text(
                                  searchResults[index].caloriesPerServing,
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.035,
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
                                    size: screenWidth * 0.05,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  searchResults[index].prepTimeMinutes,
                                  style: TextStyle(
                                    letterSpacing: 0.01,
                                    fontSize: screenWidth * 0.035,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}
