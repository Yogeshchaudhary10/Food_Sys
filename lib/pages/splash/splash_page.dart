import 'dart:async';
import 'package:food_ordering_app/resources/routes_manager.dart';
import 'package:food_ordering_app/services/splash_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  SplashServices splashScreen = SplashServices();

  @override
  void initState() {
    super.initState();
    splashScreen.isLogin(context);
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, Routes.loginScreen);
    });
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              Navigator.pushReplacementNamed(context, Routes.loginScreen);
            }
          });
    // _animationController.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     Navigator.pushReplacementNamed(context, Routes.loginScreen);
    //   }
    // });
    _animation =
        Tween<double>(begin: 1.0, end: 1.2).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: 300,
          child: Center(
            child: SizedBox(
              width: 200 * _animation.value, // Scale width property
              child: Image.asset(
                "assets/images/Logo.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 150,
          child: Image.asset(
            "assets/images/testerlogo.png",
            fit: BoxFit.cover,
          ),
        ),
      ],
    ));
  }
}
