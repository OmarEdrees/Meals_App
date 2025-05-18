import 'package:flutter/material.dart';
import 'package:meals_final_project/logic/services/colors.dart';

class ProfileCard extends StatelessWidget {
  final void Function()? ontap;
  final String name;
  final IconData icon;
  const ProfileCard({
    super.key,
    required this.name,
    required this.icon,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          padding: EdgeInsets.all(11),
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: Offset.fromDirection(1.5, 1.5),
                color: Colors.grey,
                blurStyle: BlurStyle.normal,
                blurRadius: 0.1,
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(icon, color: ColorsApp().primaryColor),
              ),

              Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
              Spacer(flex: 1),
              Icon(Icons.arrow_forward_ios_outlined, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
