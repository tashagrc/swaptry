import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:swaptry/carbonara_swaptry_icons.dart';
import 'package:swaptry/firebase_options.dart';
import 'package:swaptry/page/detail_screen.dart';
import 'package:swaptry/page/search_page1.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swaptry/page/widgets/navigation.dart';
import 'page/home_page.dart';
import 'firebase_options.dart';
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
  

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Navigation(),
    );
  }
}


