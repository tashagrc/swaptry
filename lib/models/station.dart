import 'package:google_maps_flutter/google_maps_flutter.dart';

class Station{
  String image;
  String name;
  String address;
  int price;
  double distance;
  double latitude;
  double longitude;
  LatLng currLoc;
  

  Station({
    required this.image,
    required this.name,
    required this.address,
    required this.price,
    required this.distance,
    required this.latitude,
    required this.longitude,
    required this.currLoc,
  });
}