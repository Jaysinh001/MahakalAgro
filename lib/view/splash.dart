import 'dart:async';

import 'package:flutter/material.dart';
import 'package:practical_assessment_app/utils/screenConfig.dart';
import 'package:practical_assessment_app/viewModel/wrapper_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Wrapper()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          height: ScreenConfig.screenHeight,
          width: ScreenConfig.screenWidth,
          padding: EdgeInsets.symmetric(
              horizontal: ScreenConfig.screenWidth / 40,
              vertical: ScreenConfig.screenWidth / 30),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/farmer_home.png"),
                alignment: AlignmentDirectional.bottomCenter,
                fit: BoxFit.fitWidth),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: ScreenConfig.screenHeight / 7,
              ),
              const Text("Mahakal Agro🌾",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ],
          )),
    );
  }
}
