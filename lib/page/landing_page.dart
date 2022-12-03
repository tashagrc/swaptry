import 'package:flutter/material.dart';
import 'package:swaptry/page/auth_page.dart';
import 'package:swaptry/page/widgets/appTheme.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purple,
      body: Stack(
        children:[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 560,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/shape.png"),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Container(
            
          ), 
        ]
      ),
    );
  }
}
