import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class QuickFoodAppBarWidget extends StatelessWidget {
  final Text text;
  final void Function()? ontap;
  const QuickFoodAppBarWidget({
    super.key,
    required this.text,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    double screenWidth = screenSize.width;
    double screenHight = screenSize.height;
    return Row(
      children: [
        IconButton(
          iconSize: screenWidth * 0.08,
          onPressed: ontap,
          style: IconButton.styleFrom(
            backgroundColor: Colors.white,
            fixedSize: const Size(55, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          color: Colors.black,
          icon: const Icon(CupertinoIcons.chevron_back),
        ),
        const Spacer(),
        Container(
          padding: EdgeInsets.symmetric(vertical: screenHight * 0.02),
          child: text,
        ),
        const Spacer(),
        IconButton(
          iconSize: screenWidth * 0.07,
          onPressed: () {},
          style: IconButton.styleFrom(
            backgroundColor: Colors.white,
            fixedSize: Size(55, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          color: Colors.black,
          icon: const Icon(Iconsax.notification),
        ),
      ],
    );
  }
}
