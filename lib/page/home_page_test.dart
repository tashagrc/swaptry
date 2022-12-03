import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:swaptry/models/station.dart';
import 'package:swaptry/page/search_page1.dart';
import 'package:swaptry/page/widgets/appTheme.dart';
import 'package:swaptry/page/widgets/get_distance.dart';
import 'package:swaptry/page/widgets/station_card.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart' as stat;
import 'package:swaptry/main.dart';

class HomePageTest extends StatefulWidget {
  const HomePageTest({super.key});

  @override
  State<HomePageTest> createState() => _HomePageTestState();
}

class _HomePageTestState extends State<HomePageTest> {
  
  LatLng _initialcameraposition = const LatLng(-6.175835, 106.827158);
  late List<stat.GeocodedLocation> markerList = [
    const stat.GeocodedLocation.latLng(0, 0),
  ];

  Future<List<Station>>?  stationList;
  
  GoogleMapController? _googleMapController;
  
  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
  }

  LocationData? currentLocation;
  Location location = Location();

  @override
  void initState() {
    fetchLocation();
    getStation();
    getMarker();
    _googleMapController?.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _initialcameraposition, zoom: 14.5)));
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    fetchLocation();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: darkGrey,
        ),
        toolbarHeight: 67,
        backgroundColor: purple,
        elevation: 0,
        title: Center(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SearchPage1(LatLng(_initialcameraposition.latitude, _initialcameraposition.longitude))),
              );
            },
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width - 40,
              padding: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: <Widget>[
                  const Icon(Icons.search),
                  const SizedBox(width: 10),
                  Text(
                    'Search swap station',
                    style: textStyle(16, medium, darkGrey)
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
                      color: white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: shadow,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 20, bottom: 7, top: 12),
                          child: Text(
                            'Station around you',
                            style: textStyle(20, bold, black)
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: InkWell(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: stat.StaticMap(
                                paths: [
                                  stat.Path.circle(
                                    center: stat.Location(_initialcameraposition.latitude, _initialcameraposition.longitude), 
                                    radius: 1500,
                                    fillColor: purple.withOpacity(0.3),
                                    color: purple.withOpacity(0),
                                    encoded: true
                                  )
                                ],
                                googleApiKey:'AIzaSyBRCUfJ3RAt0x91m6js-Y-2ShQkub1DId8',
                                center: stat.Location(
                                    _initialcameraposition.latitude,
                                    _initialcameraposition.longitude),
                                zoom: 13,
                                scaleToDevicePixelRatio: true,
                                markers: [
                                  stat.Marker(
                                    size: stat.MarkerSize.mid,
                                    color: Colors.red,
                                    locations: [
                                      stat.GeocodedLocation.latLng(_initialcameraposition.latitude, _initialcameraposition.longitude),
                                    ]
                                  ),
                                  stat.Marker(
                                    size: stat.MarkerSize.small,
                                    color: purple,
                                    locations: markerList,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SearchPage1(LatLng(_initialcameraposition.latitude, _initialcameraposition.longitude))),
                              );
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20, top: 17),
                          child: Text(
                            'Your Motorcycle Type',
                            style: textStyle(16, semiBold, black)
                          ),
                        ),
                        Container(
                          height:MediaQuery.of(context).size.height * 0.065,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                          margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                          decoration: BoxDecoration(
                            color: lightGrey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Gesits',
                            style: textStyle(15, semiBold, darkerGrey)
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: Text(
                      'Featured Station',
                      style: textStyle(20, semiBold, darkerGrey)
                    ),
                  ),
                  FutureBuilder<List<Station>>(
                    future: stationList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: 10,
                          itemBuilder: ((context, index) { 
                            
                            return StationCard(
                                Station(
                                  image: snapshot.data![index].image,
                                  name: snapshot.data![index].name,
                                  address: snapshot.data![index].address,
                                  price: snapshot.data![index].price,
                                  distance: snapshot.data![index].distance, 
                                  latitude: snapshot.data![index].latitude,
                                  longitude: snapshot.data![index].longitude,
                                  currLoc: LatLng(_initialcameraposition.latitude, _initialcameraposition.longitude),
                                ),
                            );}),
                            // StationCard(
                            //   Station(
                            //     image: e['image'],
                            //     name: e['stationName'],
                            //     address: e['address'],
                            //     price: e['price1'],
                            //     distance: double.parse((getDistance(
                            //       _initialcameraposition.latitude, _initialcameraposition.longitude ,e['location'].latitude, e['location'].longitude
                            //     )).toStringAsFixed(2)), 
                            //     latitude: e['latitude'],
                            //     longitude: e['longitude'],
                            //     currLoc: LatLng(_initialcameraposition.latitude, _initialcameraposition.longitude),
                            //   ),
                            // ),
                          // ).take(5).toList(),
                        );
                      } else {
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

  Future getMarker() async{
    await firestore.collection("station").get().then((querySnapshot){
      var fireBase = querySnapshot.docs;
      for(var i = 1; i < fireBase.length; i++){
        GeoPoint point = fireBase[i].data()['location'];
        markerList.add(
          stat.GeocodedLocation.latLng(double.parse('${point.latitude}'), 
          double.parse('${point.longitude}'))
        );
      }
    });
  }

  getStation() async{
    final List stationList = await getStation();
    await firestore.collection("station").get().then((querySnapshot){
      var fireBase = querySnapshot.docs;
      for(var i = 1; i < fireBase.length; i++){
        stationList.add(
          Station(
            image: fireBase[i].data()['image'],
            name: fireBase[i].data()['stationName'],
            address: fireBase[i].data()['address'],
            price: fireBase[i].data()['price1'],
            distance: double.parse((getDistance(
              _initialcameraposition.latitude, _initialcameraposition.longitude, 
              fireBase[i].data()['location'].latitude, fireBase[i].data()['location'].longitude
            )).toStringAsFixed(2)), 
            latitude: fireBase[i].data()['latitude'],
            longitude: fireBase[i].data()['longitude'],
            currLoc: LatLng(_initialcameraposition.latitude, _initialcameraposition.longitude),
          ),
        );
      }
    });
  }
}