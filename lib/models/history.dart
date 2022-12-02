import 'package:google_maps_flutter/google_maps_flutter.dart';

class History{
  String name;
  String address;
  int price;
  double latitude;
  double longitude;
  LatLng currLoc;
  DateTime date;
  String uid;
  String orderId;
  

  History({
    required this.name,
    required this.address,
    required this.price,
    required this.latitude,
    required this.longitude,
    required this.currLoc,
    required this.date,
    required this.uid,
    required this.orderId,
  });
}