import 'package:flutter/material.dart';
import 'package:meals_final_project/presentation/screens/quick_foods_screen.dart';

class ExplorePartWidget extends StatelessWidget {
  final double screenHight;
  final double screenWidth;
  const ExplorePartWidget({
    super.key,
    required this.screenHight,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.bottomRight,
          image: AssetImage('assets/images/cooker7.png'),
        ),
        borderRadius: BorderRadius.circular(15),
        color: Color(0xfff65954),
      ),
      width: double.infinity,
      height: screenHight * 0.187,

      child: Container(
        padding: EdgeInsets.all(5),
        child: Padding(
          padding: EdgeInsets.only(
            //left: 20,
            left: screenWidth * 0.035,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cook the best\nrecipes at home',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  height: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => QuickFoodsScreen(
                            ontap: () => Navigator.pop(context),
                          ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 9),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                  ),
                  child: Text(
                    'Explore',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
