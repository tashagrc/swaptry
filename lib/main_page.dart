import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swaptry/page/auth_page.dart';
import 'package:swaptry/page/widgets/navigation.dart';
import 'package:swaptry/page/widgets/utils.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class MainPageRoute extends StatelessWidget {
  const MainPageRoute({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return const Navigation();
          }else{
            return const AuthPage();
          }
        }
      ),
    );
  }
}