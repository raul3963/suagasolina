import 'dart:async';

import 'package:flutter/material.dart';

import '../main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(milliseconds: 2500),(){
      setState(() {
        Abrindo=false;
        main();
      });
    });
    return Scaffold(backgroundColor: Colors.white,);
  }
}
