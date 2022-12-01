import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
          backgroundColor: const Color(0xff6E80FE),
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
                  const SizedBox(width: 12,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Signed In As',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        user.email!,
                      ),
                    ],
                  ),
                  
                ],
              ),
              const SizedBox(height: 20,),
              SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton.icon(
                  onPressed: () {
                    signOut();
                  },
                  icon: const Icon(Icons.logout_rounded, size: 27,),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, 
                    backgroundColor: const Color(0xff6E80FE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  
                  label: const Text(
                    'Log Out',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600
                    ),
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