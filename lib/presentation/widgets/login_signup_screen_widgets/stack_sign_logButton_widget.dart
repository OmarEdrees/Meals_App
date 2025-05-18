import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_final_project/logic/services/colors.dart';
import 'package:meals_final_project/logic/services/variablesApp.dart';

class StackSignLogButtonWidget extends StatefulWidget {
  const StackSignLogButtonWidget({
    super.key,
    required this.screenWidth,
    required this.screenHight,
  });

  final double screenWidth;
  final double screenHight;

  @override
  State<StackSignLogButtonWidget> createState() =>
      _StackSignLogButtonWidgetState();
}

class _StackSignLogButtonWidgetState extends State<StackSignLogButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Container(
            height: widget.screenWidth - 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/beaf-steak.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(widget.screenHight * 0.015),
          child: IconButton(
            iconSize: widget.screenWidth * 0.08,
            onPressed: () {
              Navigator.pop(context);
            },
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              fixedSize: const Size(55, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            color: ColorsApp().primaryColor,
            icon: const Icon(CupertinoIcons.chevron_back),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: widget.screenWidth - 185,
          child: Container(
            height: widget.screenHight * 0.15,
            width: double.infinity,

            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(80)),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      if (isSignOrLog) {
                        setState(() {
                          isSignOrLog = true;
                        });
                      } else {
                        setState(() {
                          isSignOrLog = true;
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: widget.screenWidth * 0.05,
                        vertical: widget.screenHight * 0.012,
                      ),

                      width: widget.screenWidth * 0.44,
                      height: widget.screenHight * 0.055,
                      decoration: BoxDecoration(
                        color:
                            (isSignOrLog && text == 'Sign Up' ||
                                    !isSignOrLog && text == 'Log In')
                                ? ColorsApp().primaryColor
                                : Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(80),
                        ),
                      ),
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ColorsApp().primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: widget.screenWidth * 0.05,
                        vertical: widget.screenHight * 0.012,
                      ),
                      width: widget.screenWidth * 0.44,
                      height: widget.screenHight * 0.055,
                      decoration: BoxDecoration(
                        color:
                            (isSignOrLog && text == 'Sign Up' ||
                                    !isSignOrLog && text == 'Log In')
                                ? ColorsApp().primaryColor
                                : Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(80),
                        ),
                      ),
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
