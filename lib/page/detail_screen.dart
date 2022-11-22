import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'direction_page.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  static const LatLng _initialcameraposition = LatLng(-6.175835, 106.827158);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Swap Station Details',
            style: const TextStyle(fontWeight: FontWeight.w700),
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

              Container(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Jaksel Station',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff4A4A4A),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Tebet Barat, Jakarta Selatan',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff818181),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Directions',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff4A4A4A),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        '1.2 Km From you',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff818181),
                        ),
                      ),
                    ),
                    Container(
                      height: 160,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(right: 20),
                      child:  InkWell(
                        onTap: () {
                          Navigator.push(
                            context, MaterialPageRoute(builder: (context) => const DirectionPage())
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: const GoogleMap(
                            initialCameraPosition: CameraPosition(target: _initialcameraposition, zoom: 14.5),
                          ),
                        ),
                      ),
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
