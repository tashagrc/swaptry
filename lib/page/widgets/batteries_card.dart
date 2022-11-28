import 'package:flutter/material.dart';

class BatteriesCard extends StatelessWidget {
  const BatteriesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 70,
      width: 150,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xff4C59B4)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: const [
          
          Text(
            'Gesits',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500
            ),
          ),
        ],
      ),
    );
  }
}