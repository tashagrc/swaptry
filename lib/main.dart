import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:swaptry/firebase_options.dart';
import 'package:swaptry/page/widgets/navigation.dart';



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
    return const MaterialApp(
      home: Navigation(),
    );
  }
}


