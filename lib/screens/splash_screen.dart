import 'package:animated_splash/animated_splash.dart';

import 'package:flutter/material.dart';
import 'package:gezdostumblog/screens/home_page.dart';
import 'package:gezdostumblog/screens/login_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ));
    });
  }

  Function duringSplash = () {
    int a = 123 + 23;

    if (a > 100)
      return 1;
    else
      return 2;
  };
  Map<int, Widget> op = {1: LoginPage(), 2: HomePage()};
  @override
  Widget build(BuildContext context) {
    return AnimatedSplash(
      imagePath: 'assets/gezdostumlogo.png',
      home: LoginPage(),
      customFunction: duringSplash,
      duration: 2500,
      type: AnimatedSplashType.BackgroundProcess,
      outputAndHome: op,
    );
  }
}
