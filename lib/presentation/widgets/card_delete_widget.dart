import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:meals_final_project/logic/cubit/favorite_cubit_cubit.dart';
import 'package:meals_final_project/logic/services/colors.dart';
import 'package:meals_final_project/logic/services/recipe_model.dart';
import 'package:provider/provider.dart';

class CardDeleteWidget extends StatefulWidget {
  const CardDeleteWidget({
    super.key,
    required this.screenWidth,
    required this.screenHight,
  });

  final double screenWidth;
  final double screenHight;

  @override
  State<CardDeleteWidget> createState() => _CardDeleteWidgetState();
}

class _CardDeleteWidgetState extends State<CardDeleteWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance
              .collection('Favorite')
              .orderBy('date')
              .snapshots(),

      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Container(
              padding: EdgeInsets.only(top: widget.screenHight * 0.35),
              child: CircularProgressIndicator(color: ColorsApp().primaryColor),
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(child: Text('حدث خطأ في جلب البيانات'));
        }
        List<RecipeModel> favoriteList = [];
        for (var recipe in snapshot.data!.docs) {
          favoriteList.add(RecipeModel.fromjson(recipe.data() as Map));
        }

        return favoriteList.isEmpty
            ? Container(
              padding: EdgeInsets.only(top: widget.screenHight * 0.33),
              child: Center(
                child: Text(
                  'There is no meal in the favorite list',

                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                    fontSize: widget.screenWidth * 0.045,
                  ),
                ),
              ),
            )
            : Expanded(
              child: ListView.builder(
                itemCount: favoriteList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(
                      bottom: widget.screenWidth * 0.04,
                      right: widget.screenWidth * 0.03,
                      left: widget.screenWidth * 0.03,
                    ),
                    padding: EdgeInsets.only(right: widget.screenWidth * 0.04),
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
                          margin: EdgeInsets.only(
                            right: widget.screenWidth * 0.03,
                          ),
                          height: widget.screenHight * 0.11,
                          width: widget.screenWidth * 0.23,

                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(favoriteList[index].image),
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
                              width: widget.screenWidth * 0.54,
                              child: Text(
                                favoriteList[index].name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: widget.screenWidth * 0.045,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Iconsax.flash_1,
                                  size: widget.screenWidth * 0.05,

                                  color: Colors.grey,
                                ),
                                Text(
                                  favoriteList[index].caloriesPerServing,
                                  style: TextStyle(
                                    fontSize: widget.screenWidth * 0.035,
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
                                    size: widget.screenWidth * 0.05,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  favoriteList[index].prepTimeMinutes,
                                  style: TextStyle(
                                    letterSpacing: 0.01,
                                    fontSize: widget.screenWidth * 0.035,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        Consumer<FavoriteCubit>(
                          builder: (context, favoriteCubit, child) {
                            return GestureDetector(
                              onTap: () async {
                                final mealName = favoriteList[index].name;

                                try {
                                  // حذف من Firestore
                                  QuerySnapshot snapshot =
                                      await FirebaseFirestore.instance
                                          .collection('Favorite')
                                          .where('name', isEqualTo: mealName)
                                          .get();

                                  for (var doc in snapshot.docs) {
                                    await FirebaseFirestore.instance
                                        .collection('Favorite')
                                        .doc(doc.id)
                                        .delete();
                                  }

                                  // تحديث الحالة في Cubit
                                  if (mounted) {
                                    if (mounted) {
                                      favoriteCubit.toggleFavorite(mealName);
                                    }
                                  }

                                  // إعادة بناء الواجهة
                                  if (mounted) {
                                    setState(() {});
                                  }
                                } catch (e) {
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Error deleting item'),
                                      ),
                                    );
                                  }
                                }
                              },

                              child: Icon(Icons.delete, color: Colors.red),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
      },
    );
  }
}
