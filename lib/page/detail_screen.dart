import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:swaptry/page/direction_page.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart' as stat;
import 'package:swaptry/page/widgets/appTheme.dart';

// ignore: must_be_immutable
class DetailScreen extends StatefulWidget {
  String image;
  String name;
  String address;
  int price;
  double distance;
  double latitude;
  double longitude;
  LatLng currLoc;

  DetailScreen(this.image, this.name, this.address, this.price, this.distance,
      this.latitude, this.longitude, this.currLoc,
      {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<DetailScreen> createState() => _DetailScreenState(image, name, address, price, latitude, longitude, currLoc, distance);
}

class _DetailScreenState extends State<DetailScreen> {
  final String _image;
  final String _name;
  final String _address;
  final int _price;
  final double _latitude;
  final double _longitude;
  final LatLng _currLoc;
  final double _distance;

  _DetailScreenState(
    this._image,
    this._name,
    this._address,
    this._price,
    this._latitude,
    this._longitude,
    this._currLoc,
    this._distance,
  );

  String distance = '0';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Swap Station Details',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: purple,
      ),
      body: Stack(
        children: [
          Image.asset(
            _image,
            width: MediaQuery.of(context).size.width,
            height: 190,
            fit: BoxFit.cover,
          ),
          ListView(
            children: [
              const SizedBox(
                height: 170,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    color: Colors.white),
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
                    Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 10),
                      child: InkWell(
                        onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => DirectionPage(_name,_address,_latitude,_longitude,_currLoc)),);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: stat.StaticMap(
                            googleApiKey:
                                'AIzaSyBRCUfJ3RAt0x91m6js-Y-2ShQkub1DId8',
                            center: stat.Location(_latitude, _longitude),
                            zoom: 14,
                            scaleToDevicePixelRatio: true,
                            markers: [
                              stat.Marker(
                                color: purple,
                                locations: [
                                  stat.GeocodedLocation.latLng(_latitude, _longitude)
                                ]
                              ),
                            ],
                          ),
                        ),
                      ),
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
                            color: purple,
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
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 28),
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            NumberFormat.currency(
                              locale: 'id',
                              symbol: 'Rp ',
                              decimalDigits: 0).format(_price),
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(top: 54),
                            width: MediaQuery.of(context).size.width - 50,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                foregroundColor: purple,
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
                                      fontWeight: FontWeight.w700),
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
    );
  }
}
