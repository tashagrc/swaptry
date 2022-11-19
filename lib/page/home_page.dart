import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:swaptry/models/station.dart';
import 'package:swaptry/page/search_page2.dart';
import 'package:swaptry/page/widgets/station_card.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const LatLng _initialcameraposition = LatLng(-6.175835, 106.827158);


  @override
  Widget build(BuildContext context){
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference station_name = firestore.collection('station');
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
                print("Tapped a container");
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Container(
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
                              Expanded(
                                child: Container(
                                  height: 160,
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child:  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => const SearchPage2())
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
                                      height: 45,
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
                        stream: station_name.snapshots(),
                        builder: (_,snapshot){
                          if(snapshot.hasData){
                            return Column(
                              children: (snapshot.data!).docs.map((e) =>
                              StationCard(Station(
                                  image: e['image'],
                                  name: e['stationName'],
                                  address: e['address'],
                                  price: e['price1'],
                                  distance: 0.2,
                                ),
                              ),).toList(),
                            );
                          }else{
                            return const Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                      
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
