import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:meals_final_project/logic/cubit/favorite_cubit_cubit.dart';
import 'package:meals_final_project/logic/services/colors.dart';
import 'package:meals_final_project/logic/services/object_for_get_api.dart';
import 'package:meals_final_project/logic/services/variablesApp.dart';
import 'package:meals_final_project/presentation/screens/instructions_screen.dart';

class BottoomNBarWidget extends StatefulWidget {
  const BottoomNBarWidget({
    super.key,
    required this.screenWidth,
    required this.objectForGetApi,
    required this.screenHight,
  });
  final ObjectForGetApi objectForGetApi;

  final double screenWidth;
  final double screenHight;

  @override
  State<BottoomNBarWidget> createState() => _BottoomNBarWidgetState();
}

class _BottoomNBarWidgetState extends State<BottoomNBarWidget> {
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
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsApp().primaryColor,
                foregroundColor: Colors.grey,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => InstructionsScreen(
                          objectForGetApi: widget.objectForGetApi,
                        ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'Start Cooking',
                  style: TextStyle(
                    fontSize: widget.screenWidth * 0.045,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: widget.screenWidth * 0.01),
          Expanded(
            child: BlocBuilder<FavoriteCubit, Set<String>>(
              builder: (context, favorites) {
                final cubit = context.read<FavoriteCubit>();
                final name = widget.objectForGetApi.name;
                final isFav = cubit.isFavorite(name);

                return IconButton(
                  onPressed: () async {
                    if (isFav) {
                      // إذا كانت مفضلة، نحذفها من فايربيز ونحدّث Cubit
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

                      cubit.toggleFavorite(name); // إزالة من المفضلة
                    } else {
                      // إذا لم تكن مفضلة، نضيفها إلى فايربيز ونحدّث Cubit
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

                      cubit.toggleFavorite(name); // إضافة إلى المفضلة
                    }
                  },
                  iconSize: widget.screenHight * 0.028,
                  style: IconButton.styleFrom(
                    shape: CircleBorder(
                      side: BorderSide(
                        color: const Color.fromARGB(192, 189, 189, 189),
                        width: 2.5,
                      ),
                    ),
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
    );
  }
}
