import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swaptry/page/widgets/appTheme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser!;
  signOut() async {
    await auth.signOut();
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: purple,
          elevation: 2,
          title: const Text(
            'Profile',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 21
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/img/profile.png',
                    width: 51,
                    height: 51,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Signed In As',
                        style: textStyle(20, bold, darkerGrey)
                      ),
                      Text(
                        user.email!,
                      ),
                    ],
                  ),
                  
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton.icon(
                  onPressed: () {signOut();},
                  icon: const Icon(Icons.logout_rounded, size: 27),
                  style: buttonStyle,
                  label: Text(
                    'Log Out',
                    style: textStyle(18, semiBold, white)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}