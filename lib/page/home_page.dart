import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swaptry/models/station.dart';
import 'package:swaptry/page/search_page1.dart';
import 'package:swaptry/page/search_page2.dart';
import 'package:swaptry/page/widgets/get_distance.dart';
import 'package:swaptry/page/widgets/is_nearby.dart';
import 'package:swaptry/page/widgets/station_card.dart';
import 'package:swaptry/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const LatLng _initialcameraposition = LatLng(-6.175835, 106.827158);


  @override
  Widget build(BuildContext context){
    
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins'
      ),
      home: Scaffold(
        extendBodyBehindAppBar: true,  
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Color(0xff565656),
          ),
          toolbarHeight: 67,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Center(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const SearchPage1()),
                );
              },
              child:Container(
                height: 40,
                width: MediaQuery.of(context).size.width-40,
                padding: const EdgeInsets.only(left: 10),

                decoration: BoxDecoration(
                  color: const Color(0xfff5f5f5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: const <Widget>[
                    Icon(Icons.search),
                    SizedBox(width: 10),
                    Text(
                      'Search swap station', 
                      style: TextStyle(
                        color: Color(0xff565656),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        body: SingleChildScrollView(
          child: Stack(
            children: [
              Image.asset('assets/img/home_rectangle.png', fit: BoxFit.fill, width: MediaQuery.of(context).size.width),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                margin: const EdgeInsets.only(top: 83),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 20, bottom: 7, top: 13),
                              child: const Text(
                                'Station around you',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700, 
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Stack(
                              children: 
                                [
                                  Container(
                                    height: MediaQuery.of(context).size.height * 0.2,
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.symmetric(horizontal: 20),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: const GoogleMap(
                                        zoomControlsEnabled: false,
                                        initialCameraPosition: CameraPosition(target: _initialcameraposition, zoom: 14.5),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context, MaterialPageRoute(builder: (_) => const SearchPage2()),
                                      );
                                    },
                                    child: SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.2,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                  ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 20, top: 17),
                              child: const Text(
                                'Your Motorcycle Type',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 90,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height * 0.063,
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.only(left: 20),
                                    margin: const EdgeInsets.only(left: 20, right: 20, bottom: 2, top: 10),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffF0F0F0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Text(
                                      'Gesits',
                                      style: TextStyle(
                                        color: Color(0xff4a4a4a),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
            
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding: const EdgeInsets.only(left: 20),
                                    child: const Text(
                                      '*You can change this in your profile',
                                      style: TextStyle(
                                        color: Color(0xff9c9c9c),
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              
                            ),
                          ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: const Text(
                        'Nearby',
                        style: TextStyle( 
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff4a4a4a),
                        ),
                      ),
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: stationName.snapshots(),
                      builder: (_,snapshot){
                        if(snapshot.hasData){
                          return Column(
                            children: (snapshot.data!).docs.map((e) =>
                              StationCard(Station(
                                  image: e['image'],
                                  name: e['stationName'],
                                  address: e['address'],
                                  price: e['price1'],
                                  distance: getDistance(
                                    e['location'].latitude, e['location'].longitude
                                  ), 
                                  isNearby: isNearby(getDistance(e['location'].latitude, e['location'].longitude)),
                                ),
                              ),
                            ).where((isNearby) => true).toList(),
                          );
                        }else{
                          return const Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
