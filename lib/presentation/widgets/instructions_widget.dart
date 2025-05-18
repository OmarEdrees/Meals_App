import 'package:flutter/material.dart';
import 'package:meals_final_project/logic/services/colors.dart' show ColorsApp;
import 'package:meals_final_project/logic/services/object_for_get_api.dart';

class InstructionsWidget extends StatelessWidget {
  final ObjectForGetApi objectForGetApi;
  final int counter;
  final String instructionsTips;

  const InstructionsWidget({
    super.key,
    required this.instructionsTips,
    required this.objectForGetApi,
    required this.counter,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    double screenWidth = screenSize.width;
    double screenHight = screenSize.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              right: screenWidth * 0.025,
              bottom: screenHight * 0.025,
              top: screenHight * 0.025,
            ),
            child: Divider(color: Colors.grey.shade300, height: 0.7),
          ),
          Row(
            children: [
              Container(
                alignment: Alignment.center,

                margin: EdgeInsets.only(right: screenWidth * 0.02),

                height: screenHight * 0.04,
                width: screenHight * 0.04,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorsApp().primaryColor,
                ),
                child: Text(
                  textAlign: TextAlign.center,
                  '$counter',
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.04),
              SizedBox(
                width: screenWidth * 0.76,

                child: Text(
                  instructionsTips,
                  softWrap: true,

                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
