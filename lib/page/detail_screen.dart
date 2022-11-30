import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:swaptry/page/search_page2.dart';

// ignore: must_be_immutable
class DetailScreen extends StatefulWidget {
  String image;
  String name;
  String address;
  int price;
  double distance;
  double latitude;
  double longitude;
  bool isNearby;

  DetailScreen(
    this.image,
    this.name,
    this.address,
    this.price,
    this.distance,
    this.latitude,
    this.longitude,
    this.isNearby,
    {super.key}
  );

  @override
  // ignore: no_logic_in_create_state
  State<DetailScreen> createState() => _DetailScreenState(image, name, address, price, distance, latitude, longitude);
}

class _DetailScreenState extends State<DetailScreen> {
  final String _image;
  final String _name;
  final String _address;
  final int _price;
  final double _distance;
  final double _latitude;
  final double _longitude;

  _DetailScreenState(
    this._image, 
    this._name, 
    this._address, 
    this._price, 
    this._distance, 
    this._latitude, 
    this._longitude
  );

  @override
  Widget build(BuildContext context) {
    List<Marker> markers = [
      Marker(
        markerId: MarkerId('dest'),
        position: LatLng(_latitude,_longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueRed,
        ),
      ),
    ];
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Swap Station Details',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          backgroundColor: const Color(0xff6E80FE),
        ),
        body: SafeArea(
          child: Stack(
            children: 
              [Image.asset(
                _image,
                width: MediaQuery.of(context).size.width,
                height: 190,
                fit: BoxFit.cover,
              ),
              
              ListView(
                children: 
                  [
                  const SizedBox(height: 170,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      color: Colors.white
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            _name,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff4A4A4A),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            _address,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff818181),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: const Text(
                            'Directions',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff4A4A4A),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            '$_distance Km From you',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff818181),
                            ),
                          ),
                        ),
                        Stack(
                          children: 
                            [
                              Container(
                                height: MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.only(top: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: GoogleMap(
                                    zoomControlsEnabled: false,
                                    initialCameraPosition: CameraPosition(target: LatLng(_latitude, _longitude), zoom: 14.5),
                                    markers: markers.map((e) => e).toSet(),
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
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 20),
                          child: const Text(
                            'Available Batteries',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff4A4A4A),
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Stack(
                          children: [
                            Container(
                              height: 110,
                              decoration: BoxDecoration(
                                color: const Color(0xff6E80FE),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5.5),
                              padding: const EdgeInsets.only(left: 10),
                              child: const Text(
                                'Gesits Battery',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 28),
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                NumberFormat.currency(
                                  locale: 'id', symbol: 'Rp ', decimalDigits: 0
                                ).format(_price),
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                margin: const EdgeInsets.only(top: 54),
                                width: MediaQuery.of(context).size.width-50,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: const Color(0xff6E80FE), 
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  
                                  child: const Center(
                                    child: Text(
                                      'SWAP!',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xff4A4A4A),
                                        fontWeight: FontWeight.w700
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  }
}
