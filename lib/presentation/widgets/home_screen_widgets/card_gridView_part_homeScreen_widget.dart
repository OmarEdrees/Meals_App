import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:meals_final_project/logic/cubit/favorite_cubit_cubit.dart';
import 'package:meals_final_project/logic/services/object_for_get_api.dart';
import 'package:meals_final_project/presentation/screens/recipe_screen.dart';

class CardGridViewPartHomeScreenWidget extends StatefulWidget {
  const CardGridViewPartHomeScreenWidget({
    super.key,

    required this.objectForGetApi,
    required this.loading,
    required this.screenWidth,
    required this.screenHight,
  });
  final ObjectForGetApi objectForGetApi;
  final double screenWidth;
  final double screenHight;
  final Widget Function(BuildContext, Widget, ImageChunkEvent?)? loading;

  @override
  State<CardGridViewPartHomeScreenWidget> createState() =>
      _CardGridViewPartHomeScreenWidgetState();
}

class _CardGridViewPartHomeScreenWidgetState
    extends State<CardGridViewPartHomeScreenWidget> {
  bool isFavorit = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    RecipeScreen(objectForGetApi: widget.objectForGetApi),
          ),
        );
      },
      child: Container(
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
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.only(right: 10, bottom: 10, left: 1),
        padding: EdgeInsets.only(bottom: 10),
        width: widget.screenWidth * 0.56,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: widget.screenHight * 0.17,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.network(
                      widget.objectForGetApi.image,

                      fit: BoxFit.fill,
                      loadingBuilder: widget.loading,
                    ),
                  ),
                ),
                SizedBox(height: widget.screenHight * 0.013),
                Padding(
                  padding: EdgeInsets.only(left: widget.screenWidth * 0.017),
                  child: Text(
                    widget.objectForGetApi.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: widget.screenWidth * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: widget.screenHight * 0.005),
                Padding(
                  padding: EdgeInsets.only(left: widget.screenWidth * 0.01),
                  child: Row(
                    children: [
                      Icon(
                        Iconsax.flash_1,
                        size: widget.screenWidth * 0.05,

                        color: Colors.grey,
                      ),
                      Text(
                        widget.objectForGetApi.caloriesPerServing,
                        style: TextStyle(
                          fontSize: widget.screenWidth * 0.034,
                          color: Colors.grey,
                          letterSpacing: 0.01,
                        ),
                      ),
                      const Text(" · ", style: TextStyle(color: Colors.grey)),
                      Icon(
                        Iconsax.clock,
                        size: widget.screenWidth * 0.05,
                        color: Colors.grey,
                      ),
                      Text(
                        widget.objectForGetApi.prepTimeMinutes,
                        style: TextStyle(
                          letterSpacing: 0.01,
                          fontSize: widget.screenWidth * 0.034,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: widget.screenHight * 0.002,
              right: widget.screenHight * 0.002,
              child: BlocBuilder<FavoriteCubit, Set<String>>(
                builder: (context, favorites) {
                  final cubit = context.read<FavoriteCubit>();
                  final name = widget.objectForGetApi.name;
                  final isFav = cubit.isFavorite(name);

                  return IconButton(
                    onPressed: () async {
                      if (isFav) {
                        final snapshot =
                            await FirebaseFirestore.instance
                                .collection('Favorite')
                                .where('name', isEqualTo: name)
                                .get();

                        for (var doc in snapshot.docs) {
                          await FirebaseFirestore.instance
                              .collection('Favorite')
                              .doc(doc.id)
                              .delete();
                        }

                        cubit.toggleFavorite(name);
                      } else {
                        await FirebaseFirestore.instance
                            .collection('Favorite')
                            .add({
                              'name': name,
                              'image': widget.objectForGetApi.image,
                              'caloriesPerServing':
                                  widget.objectForGetApi.caloriesPerServing,
                              'prepTimeMinutes':
                                  widget.objectForGetApi.prepTimeMinutes,
                              'date': DateTime.now(),
                            });

                        cubit.toggleFavorite(name);
                      }
                    },
                    iconSize: widget.screenHight * 0.025,
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize: Size(20, 20),
                    ),
                    icon:
                        isFav
                            ? Icon(Iconsax.heart5, color: Colors.red)
                            : Icon(Iconsax.heart, color: Colors.black),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
