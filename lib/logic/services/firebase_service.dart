import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meals_final_project/logic/services/colors.dart';
import 'package:meals_final_project/presentation/screens/Login_screen.dart';
import 'package:meals_final_project/presentation/screens/app_main_screen.dart';
import 'package:meals_final_project/presentation/screens/signup_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseService {
  //////////////////////////////////////////////////////////////
  //////////    Future of getUserDataFromFirestore    //////////
  //////////////////////////////////////////////////////////////
  Future<Map<String, dynamic>?> getUserDataFromFirestore(String email) async {
    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('Users').doc(email).get();

      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>;
      } else {
        print('User not found in Firestore');
        return null;
      }
    } catch (e) {
      print('Error fetching user data');
      return null;
    }
  }

  //////////////////////////////////////////////////////////////
  /////////           Future of getFirebase           //////////
  //////////////////////////////////////////////////////////////
  Future<Map<String, dynamic>> getFirebase({
    required BuildContext context,
    required String email,
  }) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    try {
      DocumentSnapshot getUser =
          await firebaseFirestore.collection('Users').doc(email).get();
      Map<String, dynamic> getMap = getUser.data() as Map<String, dynamic>;
      return getMap;
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('there is an error in get data')));

      return {};
    }
  }

  //////////////////////////////////////////////////////////////
  /////////          Future of updateFirebase         //////////
  //////////////////////////////////////////////////////////////
  Future updateFirebase({
    required BuildContext context,
    required String email,
    required String password,
    required String lastName,
    required String firstName,
  }) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await firebaseFirestore.collection('Users').doc(email).update({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
      });
      auth.currentUser!.updatePassword(password);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data has been edited successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('there is an error in editting user')),
      );
    }
  }

  //////////////////////////////////////////////////////////////
  /////////           Future of setFirebase           //////////
  //////////////////////////////////////////////////////////////
  Future setFirebase({
    required BuildContext context,
    required String email,
    required String password,
    required String lastName,
    required String firstName,
  }) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    try {
      await firebaseFirestore.collection('Users').doc(email).set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('there is an error in saving user')),
      );
    }
  }

  //////////////////////////////////////////////////////////////
  /////////             Future of login               //////////
  //////////////////////////////////////////////////////////////
  Future<bool> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user!.emailVerified) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => AppMainScreen()),
          (route) => false,
        );
        return true;
      } else {
        // متغير للتحكم في حالة الإرسال
        bool isSending = false;

        AwesomeDialog? dialog;

        dialog = AwesomeDialog(
          context: context,
          dismissOnTouchOutside: false,
          dialogType: DialogType.warning,
          showCloseIcon: false,
          desc: 'Please confirm the email through the link in the email',
          btnOk: StatefulBuilder(
            builder: (context, setState) {
              Size screenSize = MediaQuery.sizeOf(context);
              double screenWidth = screenSize.width;
              double screenHight = screenSize.height;
              return MaterialButton(
                onPressed: () async {
                  setState(() => isSending = true);

                  try {
                    await FirebaseAuth.instance.currentUser!
                        .sendEmailVerification();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Verification email sent! Please check your inbox.',
                        ),
                      ),
                    );

                    // تحقق دوري كل 3 ثوانٍ إذا تم التحقق
                    Timer.periodic(Duration(seconds: 3), (timer) async {
                      await FirebaseAuth.instance.currentUser!.reload();
                      var user = FirebaseAuth.instance.currentUser;
                      if (user != null && user.emailVerified) {
                        timer.cancel(); // أوقف المؤقت
                        dialog?.dismiss(); // اغلق الـ dialog
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AppMainScreen(),
                          ),
                          (route) => false,
                        );
                      }
                    });
                  } on FirebaseAuthException catch (e) {
                    setState(() => isSending = false);
                    String errorMessage = 'Failed to send email';
                    if (e.code == 'too-many-requests') {
                      errorMessage =
                          'Too many requests. Please try again later.';
                    } else if (e.code == 'user-not-found') {
                      errorMessage = 'User not found. Please sign up again.';
                    }
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(errorMessage)));
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),

                height: screenHight * 0.06,
                minWidth: double.infinity,
                color: ColorsApp().primaryColor,
                child:
                    isSending
                        ? Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        )
                        : Text(
                          'Send Verify Code',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
              );
            },
          ),
        )..show();

        return true;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('There is an error in email or password')),
      );
      return false;
    }
  }

  //////////////////////////////////////////////////////////////
  /////////             Future of signup              //////////
  //////////////////////////////////////////////////////////////
  Future<void> signup({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) {
          return false;
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('There is an error in signUp')));
    }
  }

  //////////////////////////////////////////////////////////////
  /////////             Future of logout              //////////
  //////////////////////////////////////////////////////////////
  Future<void> logout(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.signOut();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('logout successfully!')));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false,
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('isLoggedIn');
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('there is an error in logout')));
    }
  }

  //////////////////////////////////////////////////////////////
  //////////       Future of signInWithGoogle         //////////
  //////////////////////////////////////////////////////////////
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final googleSignIn = GoogleSignIn(
        scopes: ['email'],

        forceCodeForRefreshToken: true,
      );

      // إجبار عرض قائمة الحسابات حتى مع وجود حساب مسجل مسبقًا
      await googleSignIn.signOut();
      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) return; // تم الإلغاء

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      final user = userCredential.user;

      if (user != null) {
        // تخزين معلومات إضافية في Firestore
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.email)
            .set(
              {
                'uid': user.uid,
                'email': user.email,
                'firstName': user.displayName,
              },
              SetOptions(merge: true),
            ); // merge يمنع الكتابة فوق البيانات الموجودة
      }

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => AppMainScreen()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google sign-in failed: ${e.message}')),
      );
    }
  }

  //////////////////////////////////////////////////////////////
  //////////         Future of signOutGoogle          //////////
  //////////////////////////////////////////////////////////////
  Future<void> signOutGoogle(BuildContext context) async {
    try {
      var googleSignIn = GoogleSignIn();

      // 1. إلغاء اتصال حساب Google بالكامل
      await googleSignIn.disconnect();

      // 2. تسجيل الخروج من Firebase
      await FirebaseAuth.instance.signOut();

      // 3. مسح ذاكرة التخزين المؤقت لـ Google Sign-In
      await googleSignIn.signOut();

      // 4. إعادة تحميل حالة Google Sign-In
      googleSignIn = GoogleSignIn();
    } catch (e) {
      print('Error during sign out: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to sign out properly')));
    }
  }

  //////////////////////////////////////////////////////////////
  /////////   Future of deleteEmailPasswordAccount    //////////
  //////////////////////////////////////////////////////////////
  Future<void> deleteEmailPasswordAccount({
    required BuildContext context,
  }) async {
    final fireStore = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    try {
      // 1. التحقق من وجود المستخدم
      if (user == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('There is no registered user currently'),
            ),
          );
        }
        return;
      }

      // 2. طلب كلمة المرور
      final password = await showPasswordDialog(context);

      if (password == null || password.isEmpty) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('The password must be entered')),
          );
        }
        return;
      }

      // 3. إنشاء بيانات الاعتماد
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );

      // 4. إعادة المصادقة
      try {
        await user.reauthenticateWithCredential(credential);
      } on FirebaseAuthException catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Wrong password')));
        }
        return; //  أوقف التنفيذ إذا كانت كلمة المرور خاطئة
      }

      // 5. حذف الحساب من Auth
      await user.delete();

      if (user == null || user.email == null || user.email!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No authenticated user found.')),
        );
        return;
      }

      // 6. حذف البيانات من Firestore
      await fireStore.collection('Users').doc(user.email).delete();

      // 7. إظهار إشعار النجاح
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The account has been deleted successfully!'),
          ),
        );
      }

      // 8. حذف بيانات تسجيل الدخول المحلية
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('isLoggedIn');

      // 9. توجيه المستخدم إلى صفحة التسجيل
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SignupScreen()),
          (route) => false,
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('There was an error deleting the user')),
        );
      }
    }
  }

  //////////////////////////////////////////////////////////////
  /////////       Future of showPasswordDialog        //////////
  //////////////////////////////////////////////////////////////
  Future<String?> showPasswordDialog(BuildContext context) async {
    Size screenSize = MediaQuery.sizeOf(context);
    double screenWidth = screenSize.width;
    double screenHight = screenSize.height;
    final passwordController = TextEditingController();

    return await showDialog<String>(
      barrierDismissible: true,
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              'Confirm deletion',
              style: TextStyle(
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorsApp().textFieldColor,
                    width: 2,
                  ),
                ),
                labelText: 'Enter the password',
                floatingLabelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorsApp().primaryColor,
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            actions: [
              MaterialButton(
                onPressed: () => Navigator.pop(context),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),

                height: screenHight * 0.035,
                minWidth: screenHight * 0.1,

                color: ColorsApp().primaryColor,
                child: Text(
                  'Cancle',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.03,
                  ),
                ),
              ),

              MaterialButton(
                onPressed: () {
                  if (passwordController.text.trim().isNotEmpty) {
                    Navigator.pop(context, passwordController.text.trim());
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),

                height: screenHight * 0.035,
                minWidth: screenHight * 0.1,

                color: ColorsApp().primaryColor,
                child: Text(
                  'Ok',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.03,
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
