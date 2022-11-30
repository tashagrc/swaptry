import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:swaptry/firebase_options.dart';
import 'package:swaptry/page/widgets/get_distance.dart';
import 'package:swaptry/page/widgets/navigation.dart';
import 'package:swaptry/models/station.dart';
import 'package:swaptry/page/home_page.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference stationName = firestore.collection('station');

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
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home: const Navigation(),
    );
  }
}


