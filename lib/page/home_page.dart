import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:swaptry/models/station.dart';
import 'package:swaptry/page/search_page1.dart';
import 'package:swaptry/page/search_page2.dart';
import 'package:swaptry/page/widgets/get_distance.dart';
import 'package:swaptry/page/widgets/station_card.dart';
import 'package:swaptry/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LatLng _initialcameraposition = const LatLng(-6.175835, 106.827158);

  GoogleMapController? _googleMapController;
  
  @override
  void dispose(){
    _googleMapController?.dispose();
    super.dispose();
  }

  LocationData? currentLocation;
  Location location = Location();

  @override
  void initState(){
    fetchLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    _googleMapController?.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _initialcameraposition, zoom: 14.5)));
    return Scaffold(
      extendBodyBehindAppBar: true,  
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xff565656),
        ),
        toolbarHeight: 67,
        backgroundColor: const Color(0xff6E80FE),
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
                                  child: GoogleMap(
                                    myLocationButtonEnabled: false,
                                    myLocationEnabled: true,
                                    zoomControlsEnabled: false,
                                    buildingsEnabled: false,
                                    initialCameraPosition: CameraPosition(target: _initialcameraposition, zoom: 14.5),
                                    onMapCreated: (controller){
                                      _googleMapController = controller;
                                    }
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
                      if(snapshot.hasData && currentLocation != null){
                        return Column(
                          children: (snapshot.data!).docs.map((e) =>
                            StationCard(Station(
                                image: e['image'],
                                name: e['stationName'],
                                address: e['address'],
                                price: e['price1'],
                                distance: double.parse((getDistance(
                                  _initialcameraposition.latitude, _initialcameraposition.longitude ,e['location'].latitude, e['location'].longitude
                                )).toStringAsFixed(2)), 
                                latitude: e['latitude'],
                                longitude: e['longitude'],
                              ),
                            ),
                          ).toList(),
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
    );
  }
  fetchLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    currentLocation = await location.getLocation();
    location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        currentLocation = currentLocation;
        _initialcameraposition = LatLng(currentLocation.latitude!, currentLocation.longitude!);
      });
    });
  }
}
