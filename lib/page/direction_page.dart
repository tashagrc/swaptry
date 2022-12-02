import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swaptry/page/widgets/appTheme.dart';
import 'package:swaptry/page/widgets/get_distance.dart';


// ignore: must_be_immutable
class DirectionPage extends StatefulWidget {
  String name;
  String address;
  double latitude;
  double longitude;
  LatLng currLoc;

  DirectionPage(
    this.name,
    this.address,
    this.latitude,
    this.longitude,
    this.currLoc,
    {super.key}
  );

  @override
  // ignore: no_logic_in_create_state
  State<DirectionPage> createState() => _DirectionPageState(name, latitude, longitude, currLoc);
}

class _DirectionPageState extends State<DirectionPage> {
  final String _name;
  final double _latitude;
  final double _longitude;
  final LatLng _currLoc;

  _DirectionPageState(
    this._name, 
    this._latitude, 
    this._longitude,
    this._currLoc
  );

  GoogleMapController? _googleMapController;
  List<LatLng> polylineCoordinates = [];
  String distance = '0';

  @override
  void dispose(){
    _googleMapController?.dispose();
    polylineCoordinates.clear();
    super.dispose();
  }

  @override
  void initState(){ 
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            popAwait();
          },
           icon: const Icon(Icons.arrow_back_rounded)
        ),
        title: const Text(
          'Directions',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: purple,
      ),
      
      body:Stack(
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
                  initialCameraPosition: CameraPosition(target: LatLng(_currLoc.latitude, _currLoc.longitude), zoom: 14),
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
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    color: purple,
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

  void getPolyPoints() async{
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyBRCUfJ3RAt0x91m6js-Y-2ShQkub1DId8', 
      PointLatLng(_currLoc.latitude, _currLoc.longitude), 
      PointLatLng(_latitude, _longitude),
    );

    if(result.points.isNotEmpty){
      for (var point in result.points) {
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      }
    }else{
      print(result.errorMessage);
    }

    double totDistance = 0;
    if(polylineCoordinates.isNotEmpty){
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

  popAwait() async{
    Navigator.of(context).push(MaterialPageRoute(builder: (_) 
      => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Please wait',
                style: textStyle(25, bold, greyText),
              ),
            ),
            const SizedBox(height: 20,),
            const CircularProgressIndicator(),
          ],
        ),
      )));
    await Future.delayed(const Duration(milliseconds: 2000));
    Navigator.of(context)
    ..pop()
    ..pop();
  }
}