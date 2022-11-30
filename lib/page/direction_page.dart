import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:swaptry/page/widgets/get_distance.dart';


// ignore: must_be_immutable
class DirectionPage extends StatefulWidget {
  String name;
  String address;
  double distance;
  double latitude;
  double longitude;

  DirectionPage(
    this.name,
    this.address,
    this.distance,
    this.latitude,
    this.longitude,
    {super.key}
  );

  @override
  // ignore: no_logic_in_create_state
  State<DirectionPage> createState() => _DirectionPageState(name, distance, latitude, longitude);
}

class _DirectionPageState extends State<DirectionPage> {
  final String _name;
  final double _distance;
  final double _latitude;
  final double _longitude;

  _DirectionPageState(
    this._name, 
    this._distance, 
    this._latitude, 
    this._longitude
  );
  GoogleMapController? _googleMapController;

  @override
  void dispose(){
    _googleMapController?.dispose();
    super.dispose();
  }
  
  int i = 1;
  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;
  Location location = Location();
  

  @override
  void initState(){
    fetchLocation();
    
    super.initState();
  }
  
  String distance = '0';
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Directions',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          backgroundColor: const Color(0xff6E80FE),
        ),
      
      body: currentLocation == null 
      ?Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Please Wait',
              style: TextStyle(
                fontSize: 30,
                color: Color(0xff818181),
                fontWeight: FontWeight.w600
              ),
            ),
            CircularProgressIndicator(),
          ],
        ), 
      )
      :Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: GoogleMap(
                  onMapCreated: (controller){
                    _googleMapController = controller;
                    
                  },
                  compassEnabled: false,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  initialCameraPosition: CameraPosition(target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!), zoom: 14),
                  polylines: {
                    Polyline(
                      polylineId: const PolylineId('route'),
                      points: polylineCoordinates,
                      color: const Color.fromARGB(255, 92, 108, 232),
                      width: 6
                    ),
                  },
                  markers: {
                    Marker(
                      markerId: const MarkerId('destination'),
                      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
                      position: LatLng(_latitude, _longitude),
                    )
                  },
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  height: 85,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    color: Color(0xff6E80FE),
                  ),
                  child: Column(
                    children: [
                      Text(
                        _name,
                        style: const TextStyle(
                          height: 1.2,
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.w600
                          ),
                      ),
                      const Text(
                        'Distance',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '$distance Km',
                        style: const TextStyle(
                          height: 1.1,
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
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
        if(i <= 1){
          getPolyPoints();
        }
        i++;
      });
    });
  }

  void getPolyPoints() async{
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyBRCUfJ3RAt0x91m6js-Y-2ShQkub1DId8', 
      PointLatLng(currentLocation!.latitude!, currentLocation!.longitude!), 
      PointLatLng(_latitude, _longitude),
    );

    if(result.points.isNotEmpty){
      for (var point in result.points) {
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      }
    }
    double totDistance = 0;
    if(polylineCoordinates.isNotEmpty && polylineCoordinates.length >= 2){
      for(var i = 0; i < polylineCoordinates.length-1; i++){
        totDistance += getDistance(
          polylineCoordinates[i].latitude, 
          polylineCoordinates[i].longitude, 
          polylineCoordinates[i+1].latitude, 
          polylineCoordinates[i+1].longitude
        );
      }
    }
    
    setState(() {
      distance = totDistance.toStringAsPrecision(4);
    });
  }
}