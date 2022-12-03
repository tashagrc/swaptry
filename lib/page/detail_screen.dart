import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:swaptry/page/direction_page.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart' as stat;
import 'package:swaptry/page/payment_page.dart';
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
        title: Text(
          'Swap Station Details',
          style: TextStyle(fontWeight: bold),
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
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    color: white),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        _name,
                        style: textStyle(25, semiBold, darkerGrey)
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        _address,
                        style: textStyle(14, medium, greyText)
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Directions',
                        style: textStyle(17, medium, darkerGrey)
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        '$_distance Km From you',
                        style: textStyle(16, regular, greyText)
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
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        'Available Batteries',
                        style: textStyle(18, medium, darkerGrey)
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
                          child: Text(
                            'Gesits Battery',
                            style: textStyle(17, medium, white)
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 28),
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            NumberFormat.currency(
                              locale: 'id',
                              symbol: 'Rp ',
                              decimalDigits: 2).format(_price),
                            style: textStyle(15, medium, white)
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(top: 54),
                            width: MediaQuery.of(context).size.width - 50,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => PaymentPage(_name,_address,_price, _latitude,_longitude)),
                                );
                              },
                              style: buttonStyle2,
                              child: Center(
                                child: Text(
                                  'SWAP!',
                                  style: textStyle(18, bold, darkerGrey)
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
