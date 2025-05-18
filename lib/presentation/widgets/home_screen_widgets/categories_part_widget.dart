import 'package:flutter/material.dart';
import 'package:meals_final_project/logic/services/colors.dart';
import 'package:meals_final_project/logic/services/variablesApp.dart';

// ignore: must_be_immutable
class CategoriesPartWidget extends StatefulWidget {
  CategoriesPartWidget({
    super.key,
    required this.screenHight,
    required this.screenWidth,
    required this.currentCat,
  });

  final double screenHight;
  final double screenWidth;
  String currentCat = catgories[0];

  @override
  State<CategoriesPartWidget> createState() => _CategoriesPartWidgetState();
}

class _CategoriesPartWidgetState extends State<CategoriesPartWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: widget.screenHight * 0.02),
          child: Text(
            'Categories',
            style: TextStyle(
              fontSize: widget.screenWidth * 0.06,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(catgories.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    widget.currentCat = catgories[index];
                    if (widget.currentCat == 'Breakfast') {}
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(right: widget.screenWidth * 0.04),

                  padding: EdgeInsets.symmetric(
                    vertical: widget.screenHight * 0.008,
                    horizontal: widget.screenWidth * 0.055,
                  ),
                  decoration: BoxDecoration(
                    color:
                        widget.currentCat == catgories[index]
                            ? ColorsApp().secondryColor
                            : Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    catgories[index],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color:
                          widget.currentCat == catgories[index]
                              ? Colors.white
                              : Colors.grey.shade600,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
