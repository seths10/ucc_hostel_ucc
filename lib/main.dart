import 'package:flutter/material.dart';
import 'package:ucc_hostel/pages/home_page.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ucc hostels',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.white,
      ),
      home: AnimatedSplashScreen(
          duration: 5000,
          splash: Image.asset(
            'assets/splash.png'
          ),
          nextScreen: HomePage(),
          splashTransition: SplashTransition.fadeTransition,
      ),
    );
  }
}