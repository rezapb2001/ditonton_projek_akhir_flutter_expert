import 'dart:async';
import 'package:flutter/material.dart';

import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splashscreen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() async {
    Duration duration = const Duration(seconds: 5);
    return Timer(duration, () {
      Navigator.pushReplacementNamed(context, ScreenLogin.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 45),
                    child: Image.asset(
                      "assets/movieTv.png",
                      height: 225.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Text('  Ditonton  ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellowAccent
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
