import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Swap Station Details',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          backgroundColor: Color(0xff6E80FE),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Image.asset(
                'assets/img/jakselstation.png',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.amber,
                      child: Text(
                        'Jaksel Station',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Tebet Barat, Jakarta Selatan',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    Text(
                      'Directions',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '1.2 Km From you',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    // batteries type
                    Row(
                      children: [],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}
