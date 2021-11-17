import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marvel_comics/constants/app_images.dart';
import 'package:marvel_comics/constants/strings.dart';
import 'package:marvel_comics/utilities/navigator.dart';

import '../../routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      Navigator.pushReplacementNamed(context, homeScreen);
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
          body: Center(
              child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Image.asset(AppImages.logoIcon),
      )));
}
