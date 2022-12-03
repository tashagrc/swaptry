import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:swaptry/main.dart';
import 'package:swaptry/models/history.dart';
import 'package:swaptry/page/widgets/appTheme.dart';
import 'package:swaptry/page/widgets/history_card.dart';


class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  LatLng _initialcameraposition = const LatLng(-6.175835, 106.827158);
  LocationData? currentLocation;
  Location location = Location();
  
  @override
  void initState() {
    fetchLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: purple,
        elevation: 2,
        title: Text(
          'Transaction History',
          style: textStyle(20, bold, white)
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 40, top: 20, right: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your History',
                style: textStyle(23, bold, black),
              ),
        
              const SizedBox(height: 5),
        
              StreamBuilder<QuerySnapshot>(
                stream: transaction.orderBy('orderDate', descending: true).snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: (snapshot.data!).docs.map((e) =>
                        HistoryCard(History(
                            name: e['stationName'],
                            address: e['address'],
                            price: e['totalPrice'],
                            latitude: e['latitude'],
                            longitude: e['longitude'],
                            currLoc: _initialcameraposition,
                            date: e['orderDate'].toDate(),
                            uid: e['uid'],
                            orderId: e.id,
                          ),
                        ),
                      ).where((e) => e.history.uid == uid).toList(),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  fetchLocation() async {
    
    location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        currentLocation = currentLocation;
        _initialcameraposition = LatLng(currentLocation.latitude!, currentLocation.longitude!);
      });
    });
  }



}