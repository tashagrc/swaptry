import 'package:flutter/material.dart';
import 'package:swaptry/models/station.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swaptry/page/widgets/get_distance.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:swaptry/page/widgets/station_card.dart';
import 'package:swaptry/main.dart';

class SearchPage1 extends StatefulWidget {
  const SearchPage1({super.key});

  @override
  State<SearchPage1> createState() => SearchPage1State();
}

class SearchPage1State extends State<SearchPage1> {
  LatLng _initialcameraposition = const LatLng(-6.175835, 106.827158);
  GoogleMapController? _googleMapController;
  String station = "";

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
    _googleMapController?.moveCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: _initialcameraposition, zoom: 14.5)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Column(
          children: [
            Stack(
              children: [
                const Text(
                  'Search Station',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  decoration: const BoxDecoration(
                    color: Color(0xff6E80FE),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 40,
                    child: TextField(
                        // tulisan input warna apa
                        style: const TextStyle(color: Colors.black),

                        // box
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          // border
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                                width: 0, style: BorderStyle.none),
                          ),
                          // tulisan hint
                          hintText: 'Search Swap Station',
                          contentPadding: const EdgeInsets.all(0),
                          // icon
                          prefixIcon: const Icon(Icons.search),
                        ),
                        // masukin input user ke var global
                        onChanged: (val) {
                          setState(() {
                            station = val;
                          });
                        }),
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: const Color(0xff6E80FE),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: stationName.snapshots(),
        builder: (_, snapshot) {
          if (snapshot.hasData && currentLocation != null) {
            ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var data =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  if (station.isEmpty) {
                    return Column(
                      children: (snapshot.data!)
                          .docs
                          .map(
                            (e) => StationCard(
                              Station(
                                image: e['image'],
                                name: e['stationName'],
                                address: e['address'],
                                price: e['price1'],
                                distance: double.parse((getDistance(
                                        _initialcameraposition.latitude,
                                        _initialcameraposition.longitude,
                                        e['location'].latitude,
                                        e['location'].longitude))
                                    .toStringAsFixed(2)),
                                latitude: e['latitude'],
                                longitude: e['longitude'],
                                currLoc: LatLng(currentLocation!.latitude!,
                                    currentLocation!.longitude!),
                              ),
                            ),
                          )
                          .toList(),
                    );
                  }
                  if (data['name']
                      .toString()
                      .toLowerCase()
                      .startsWith(station.toLowerCase())) {
                    return Column(
                      children: (snapshot.data!)
                          .docs
                          .map(
                            (e) => StationCard(
                              Station(
                                image: e['image'],
                                name: e['stationName'],
                                address: e['address'],
                                price: e['price1'],
                                distance: double.parse((getDistance(
                                        _initialcameraposition.latitude,
                                        _initialcameraposition.longitude,
                                        e['location'].latitude,
                                        e['location'].longitude))
                                    .toStringAsFixed(2)),
                                latitude: e['latitude'],
                                longitude: e['longitude'],
                                currLoc: LatLng(currentLocation!.latitude!,
                                    currentLocation!.longitude!),
                              ),
                            ),
                          )
                          .toList(),
                    );
                  }
                  return Container();
                });
            // return Container();
          }
          return const Center(child: CircularProgressIndicator());
        }, // builder
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
    // location.onLocationChanged.listen((LocationData currentLocation) {
    setState(() {
      currentLocation = currentLocation;
      _initialcameraposition =
          LatLng(currentLocation!.latitude!, currentLocation!.longitude!);
    });
    // });
  }
}
