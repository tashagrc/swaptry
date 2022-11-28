import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swaptry/page/widgets/batteries_card.dart';

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
          title: const Text(
            'Swap Station Details',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          backgroundColor: const Color(0xff6E80FE),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Image.asset(
                'assets/img/jakselstation.png',
                width: MediaQuery.of(context).size.width,
                height: 170,
                fit: BoxFit.cover,
              ),

              Container(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      width: MediaQuery.of(context).size.width,
                      child: const Text(
                        'Jaksel Station',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff4A4A4A),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Text(
                        'Tebet Barat, Jakarta Selatan',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff818181),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Text(
                        'Directions',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff4A4A4A),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Text(
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
                      margin: const EdgeInsets.only(right: 20),
                      child:  InkWell(
                        onTap: () {
                          Navigator.push(
                            context, MaterialPageRoute(builder: (context) => const DirectionPage())
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: const GoogleMap(
                            zoomControlsEnabled: false,
                            initialCameraPosition: CameraPosition(target: _initialcameraposition, zoom: 14.5),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // height: 20,
                      padding: const EdgeInsets.only(top: 20),
                      child: const Text(
                        'Select Available Batteries Type',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    BatteriesCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}
