import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:swaptry/carbonara_swaptry_icons.dart';
import 'package:swaptry/firebase_options.dart';
import 'page/home_page.dart';
import 'page/history_page.dart';
import 'page/profile_page.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MainPage());
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  final screens = [
    const HomePage(),
    const HistoryPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xff6e80fe),
        unselectedItemColor: const Color(0xffababab),
        elevation: 10,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const[
          BottomNavigationBarItem(
            icon: Icon(Carbonara_swaptry.home),
            label: 'Home',
          ),
      
          BottomNavigationBarItem(
            icon: Icon(Carbonara_swaptry.history),
            label: 'History',
          ),
      
          BottomNavigationBarItem(
            icon: Icon(Carbonara_swaptry.user),
            label: 'Profile',
          ),
        ],
      ),
    ),
  );
}


