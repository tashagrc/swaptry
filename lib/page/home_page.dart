import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => MaterialApp(
    theme: ThemeData(
      fontFamily: 'Poppins'
    ),
    home: Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xff565656),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Icon(Icons.search),

                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Search swap station', 
                    style: TextStyle(
                      color: Color(0xff565656),
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Color(0xfff5f5f5),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),

      body: Stack(
        children: [
          Container(
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: Image.asset('assets/img/home_rectangle.png', fit: BoxFit.fill),
          ),
        ],
      ),
    ),
  );
}
