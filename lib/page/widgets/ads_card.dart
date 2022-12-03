import 'package:flutter/material.dart';
import 'package:swaptry/page/widgets/appTheme.dart';

Widget adsCard(String adsImage) =>
  Container(
    width: 330,
    padding: const EdgeInsets.all(3),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          spreadRadius: -4.6,
          blurRadius: 2,
          offset: const Offset(2, 3),
        ),
      ],
      
    ), 
    
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(adsImage, fit: BoxFit.cover,)
    ),
  );