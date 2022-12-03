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
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/welcome_bar.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(), //LU ISI GAMBAR

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // const Text(
                //   textAlign: TextAlign.center,
                //   "Let's start our journey\nshall we?",
                // ),
                // FittedBox(
                //   child: GestureDetector(
                //     onTap: () {
                //       Navigator.push(context, MaterialPageRoute(
                //         builder: (context) {
                //           return AuthPage();
                //         },
                //       ));
                //     },
                //     child: Container(
                //       margin: EdgeInsets.only(bottom: 25),
                //       padding:
                //           EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(25),
                //         color: Colors.purple,
                //       ),
                //       child: Row(
                //         children: <Widget>[
                //           Text(
                //             "START LEARNING",
                //           ),
                //           SizedBox(width: 10),
                //           Icon(
                //             Icons.arrow_forward,
                //             color: Colors.black,
                //           )
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
