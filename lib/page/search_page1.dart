import 'package:flutter/material.dart';
import 'package:swaptry/models/station.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swaptry/page/widgets/appTheme.dart';
import 'package:swaptry/page/widgets/get_distance.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swaptry/page/widgets/station_card.dart';
import 'package:swaptry/main.dart';

// ignore: must_be_immutable
class SearchPage1 extends StatefulWidget {
  LatLng currentLocation;

  SearchPage1(this.currentLocation,{super.key});

  @override
  // ignore: no_logic_in_create_state
  State<SearchPage1> createState() => SearchPage1State(currentLocation);
}

class SearchPage1State extends State<SearchPage1> {
  final LatLng _currenLocation;

  SearchPage1State(
    this._currenLocation
  );

  String station = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Search Swap Station'
        ),

        backgroundColor: purple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
              decoration: BoxDecoration(
                color: purple,
              ),
              child: SizedBox(
                height: 40,
                child: TextField(
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none
                        ),
                      ),
                      hintText: 'Search Station',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: StreamBuilder<QuerySnapshot>(
                stream: stationName.snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: (snapshot.data!).docs.map((e) => StationCard(
                        Station(
                          image: e['image'],
                          name: e['stationName'],
                          address: e['address'],
                          price: e['price1'],
                          distance: double.parse((getDistance(
                                  _currenLocation.latitude,
                                  _currenLocation.longitude,
                                  e['location'].latitude,
                                  e['location'].longitude))
                              .toStringAsFixed(2)),
                          latitude: e['latitude'],
                          longitude: e['longitude'],
                          currLoc: _currenLocation,
                        ),
                      ),).where((e) => e.station.name.toLowerCase().contains(station.toLowerCase()) || e.station.address.toLowerCase().contains(station.toLowerCase())).toList(),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                }, // builder
              ),
            ),
          ],
        ),
      ),
    );
  }
}
