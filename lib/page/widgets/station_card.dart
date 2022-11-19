import 'package:flutter/material.dart';
import 'package:swaptry/models/station.dart';
import 'package:swaptry/page/detail_screen.dart';
import 'package:intl/intl.dart';

class StationCard extends StatelessWidget {

  final Station station;
  const StationCard(this.station, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context, MaterialPageRoute(builder: (_) => const DetailScreen())
        );
      },
      child: Container( 
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 105,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 105,
              height: 105,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(station.image),
                  fit: BoxFit.cover,
                ),
              ),
              
              
            ),
            const SizedBox(width: 10),
            Column(     
              crossAxisAlignment: CrossAxisAlignment.start,    
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Text(
                      station.name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff4a4a4a),
                        
                      ),
                    ),
    
                    Text(
                      station.address,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xff818181),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${station.distance} Km From You',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xff818181),
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    Text(
                      NumberFormat.currency(
                        locale: 'id', symbol: 'Rp ', decimalDigits: 0
                      ).format(station.price),
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}