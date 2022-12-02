import 'package:flutter/material.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart' as stat;
import 'package:intl/intl.dart';
import 'package:swaptry/models/history.dart';
import 'package:swaptry/page/direction_page.dart';
import 'package:swaptry/page/widgets/appTheme.dart';

class HistoryDetailPage extends StatefulWidget {
  final History history;
  const HistoryDetailPage(this.history, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<HistoryDetailPage> createState() => _HistoryDetailPageState(history);
}

class _HistoryDetailPageState extends State<HistoryDetailPage> {
  final History _history;

  _HistoryDetailPageState(
    this._history
  );

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

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _history.name,
                style: textStyle(25, bold, black),
              ),
              Text(
                _history.address,
                style: textStyle(14, regular, greyText),
              ),
              const SizedBox(height: 24,),
              Text(
                'Order Status',
                style: textStyle(16, medium, black),
              ),
              Text(
                'Order ID : ${_history.orderId}',
                style: textStyle(13, regular, greyText),
              ),
              Container(
                width: 82, height: 22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: const Color(0xffBAFF99)
                ),
                child: Center(
                  child: Text(
                    'Completed',
                    style: textStyle(10, medium, darkerGrey),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Order Date',
                style: textStyle(16, medium, black),
              ),
              Text(
                DateFormat.yMMMMd().add_jm().format(_history.date),
                style: textStyle(13, regular, greyText),
              ),
              const SizedBox(height: 16),
              Text(
                'Item',
                style: textStyle(16, medium, black),
              ),
              Text(
                NumberFormat.currency(
                  locale: 'id', symbol: 'Rp ', decimalDigits: 2
                ).format(_history.price),
                style: textStyle(13, regular, greyText),
              ),
              const SizedBox(height: 16),
              Text(
                'Payment Method',
                style: textStyle(16, medium, black),
              ),
              Text(
                'Credit Card',
                style: textStyle(13, regular, greyText),
              ),
              const SizedBox(height: 26),
              Text(
                'Station Direction',
                style: textStyle(20, semiBold, black),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 10),
                child: InkWell(
                  onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DirectionPage(_history.name,_history.address,_history.latitude,_history.longitude,_history.currLoc)),);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: stat.StaticMap(
                      googleApiKey:
                          'AIzaSyBRCUfJ3RAt0x91m6js-Y-2ShQkub1DId8',
                      center: stat.Location(_history.latitude, _history.longitude),
                      zoom: 14,
                      scaleToDevicePixelRatio: true,
                      markers: [
                        stat.Marker(
                          color: purple,
                          locations: [
                            stat.GeocodedLocation.latLng(_history.latitude, _history.longitude)
                          ]
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}