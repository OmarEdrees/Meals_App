import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HeaderPartWidget extends StatelessWidget {
  const HeaderPartWidget({super.key, required this.screenWidth});

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: screenWidth * 0.05),
      child: Row(
        children: [
          Text(
            'What are you \ncooking today?',
            style: TextStyle(
              fontSize: screenWidth * 0.08,
              fontFamily: 'Biofit',
              color: Colors.black,
              height: 1,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Icon(Iconsax.notification, size: screenWidth * 0.07),
        ],
      ),
    );
  }
}
