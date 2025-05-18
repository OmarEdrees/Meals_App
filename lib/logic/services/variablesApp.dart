import 'package:flutter/material.dart';
import 'package:meals_final_project/logic/services/api_service.dart';
import 'package:meals_final_project/logic/services/colors.dart';
import 'package:meals_final_project/logic/services/object_for_get_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

//////////////////////////////////////////////////////////////
//////////          List of categoreis          //////////////
//////////////////////////////////////////////////////////////
const List catgories = ["All", "Breakfast", "Lunch", "Dinner"];

//////////////////////////////////////////////////////////////
//////////          Future of getRecipes          ////////////
//////////////////////////////////////////////////////////////
List<ObjectForGetApi> recipesList = [];
bool dataFetched = false;
Future<void> getRecipes(BuildContext context, Function() updateState) async {
  if (!dataFetched && context.mounted) {
    recipesList = (await ApiService().getRecipes())!;
    dataFetched = true;
    if (context.mounted) {
      updateState(); // استدعاء دالة setState التي تم تمريرها
    }
  } else {}
}

//////////////////////////////////////////////////////////////
////////          Future of saveLoginState          //////////
//////////////////////////////////////////////////////////////
Future<void> saveLoginState() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', true);
}

//////////////////////////////////////////////////////////////
///////          Future of checkLoginState          //////////
//////////////////////////////////////////////////////////////
Future<bool> checkLoginState() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
}

//////////////////////////////////////////////////////////////
///////          check is login with google          /////////
//////////////////////////////////////////////////////////////
bool? isLogGoogle;

//////////////////////////////////////////////////////////////
/////         TextEditingController variables          ///////
//////////////////////////////////////////////////////////////
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController firstNameController = TextEditingController();
TextEditingController lastNameController = TextEditingController();

//////////////////////////////////////////////////////////////
//    check is sign up or login for change button color    ///
//////////////////////////////////////////////////////////////
bool isSignOrLog = false;
late String text;

//////////////////////////////////////////////////////////////
///////          variables for hiding password         ///////
//////////////////////////////////////////////////////////////
bool obscurePassword = true;

//////////////////////////////////////////////////////////////
//////////      loginFields TextFormFields         ///////////
//////////////////////////////////////////////////////////////
TextFormField loginField({
  required String labelText,
  required String hintText,
  TextEditingController? controller,
  TextInputType? keyboardType,
  required bool obscureText,
  IconButton? suffixIcon,
  Icon? icon,
  String? Function(String?)? validator,
}) {
  return TextFormField(
    validator: validator,
    keyboardType: keyboardType,
    obscureText: obscureText,
    controller: controller,
    cursorColor: ColorsApp().textFieldColor,
    decoration: InputDecoration(
      icon: icon,
      iconColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return ColorsApp().primaryColor; // اللون عند التركيز
        }
        return Colors.grey; // اللون العادي
      }),

      prefixIconColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return ColorsApp().primaryColor; // اللون عند التركيز
        }
        return Colors.grey; // اللون العادي
      }),
      suffixIcon: suffixIcon,
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.grey),
      floatingLabelStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: ColorsApp().primaryColor,
      ),
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey),
      suffixIconColor: ColorsApp().primaryColor,
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ColorsApp().textFieldColor, width: 2),
      ),
      border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      // إضافة هذه الخصائص لتحسين ظهور رسائل التحقق
      errorStyle: TextStyle(fontSize: 12, color: Colors.red),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
    ),
  );
}

//////////////////////////////////////////////////////////////
//////////      signupFields TextFormFields         //////////
//////////////////////////////////////////////////////////////
TextFormField signupField({
  required String labelText,
  required String hintText,
  TextEditingController? controller,
  TextInputType? keyboardType,
  required bool obscureText,
  IconButton? suffixIcon,
  Icon? icon,
  String? Function(String?)? validator,
}) {
  return TextFormField(
    validator: validator,
    keyboardType: keyboardType,
    obscureText: obscureText,
    controller: controller,

    cursorColor: ColorsApp().textFieldColor,
    decoration: InputDecoration(
      icon: icon,
      iconColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return ColorsApp().primaryColor; // اللون عند التركيز
        }
        return Colors.grey; // اللون العادي
      }),

      prefixIconColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return ColorsApp().primaryColor; // اللون عند التركيز
        }
        return Colors.grey; // اللون العادي
      }),
      suffixIcon: suffixIcon,
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.grey),
      floatingLabelStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: ColorsApp().primaryColor,
      ),
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey),
      suffixIconColor: ColorsApp().primaryColor,
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ColorsApp().textFieldColor, width: 2),
      ),
      border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      // إضافة هذه الخصائص لتحسين ظهور رسائل التحقق
      errorStyle: TextStyle(fontSize: 12, color: Colors.red),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
    ),
  );
}
