import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/pages/home_page/home_page_navigation_bar.dart';
import 'package:food_ordering_app/pages/sign_in/signin_screen.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if (user != null) {
      // SessionController().userId = user.uid.toString();
      Timer(
          const Duration(seconds: 2),
          () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage())));
    } else {
      Timer(
          const Duration(seconds: 2),
          () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SignInScreen())));
    }
  }
}
