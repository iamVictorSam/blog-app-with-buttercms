import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:blog_app/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashIconSize: Get.height * 0.5,
      duration: 3000,
      backgroundColor: Colors.black,
      splash: Image.asset('assets/logo.png'),
      nextScreen: const HomeScreen(),
      splashTransition: SplashTransition.slideTransition,
      pageTransitionType: PageTransitionType.fade,
    );
  }
}
