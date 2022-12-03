import 'package:flutter/material.dart';
import 'package:swaptry/page/widgets/appTheme.dart';

import '../../carbonara_swaptry_icons.dart';
import '../history_page.dart';
import '../home_page.dart';
import '../profile_page.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentIndex = 0;
  final screens = [
    const HomePage(),
    const HistoryPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: purple,
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
      );
  }
}