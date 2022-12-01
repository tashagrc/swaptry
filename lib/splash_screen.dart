import 'dart:async';

import 'package:flutter/material.dart';
import 'package:swaptry/main.dart';
import 'package:swaptry/main_page.dart';
import 'package:swaptry/page/home_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
     Timer(
        const Duration(seconds: 3), () =>
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const MainPageRoute())));
            
    return const Center(
      child: Text(
        'Splash Screen'
      ),
    );
  }
}