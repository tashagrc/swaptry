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
      body: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(children: [
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.16),
                child: Image.asset('assets/img/logo_black.png'),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.35),
                  child: Text(
                    "Welcome to Swaptry",
                    style: textStyle(20, bold, darkerGrey),
                    textAlign: TextAlign.center,
                  )),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.39),
                child: Text("Swap your Electric Motorcycle Battery instantly!",
                    style: textStyle(15, regular, darkerGrey),
                    textAlign: TextAlign.center),
              )
            ]),
            Column(
              children: [
                Text("Let’s start our journey,\nshall we?",
                    style: textStyle(20, bold, white),
                    textAlign: TextAlign.center),
                const SizedBox(height: 30,),
                Container(
                  margin: const EdgeInsets.only(bottom: 35),
                  height: 55,
                  width: MediaQuery.of(context).size.width / 2,
                  child: ElevatedButton(
                    onPressed: (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AuthPage()
                        ),
                      );
                    }),
                    style: buttonStyle2,
                    child: Center(
                      child: Text("Get Started",
                        style: textStyle(16, semiBold, darkerGrey)),
                    )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
