import 'package:flutter/material.dart';


Color purple = const Color(0xff6E80FE);
Color greyText = const Color(0xff818181);
Color lightGrey = const Color(0xffF0F0F0);
Color darkGrey = const Color(0xff565656);
Color darkerGrey = const Color(0xff4A4A4A);
Color black = Colors.black;
Color white = Colors.white;

FontWeight extraBold = FontWeight.w800;
FontWeight bold = FontWeight.w700;
FontWeight semiBold = FontWeight.w600;
FontWeight medium = FontWeight.w500;
FontWeight regular = FontWeight.w400;

var buttonStyle = ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, 
                    backgroundColor: const Color(0xff6E80FE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23),
                    ),
                  );

var buttonStyle2 = ElevatedButton.styleFrom(
                    foregroundColor: purple,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  );

TextStyle textStyle(double size, FontWeight weight, Color colors){
  return 
    TextStyle(
      fontSize: size,
      color: colors,
      fontWeight: weight,
  );
}


List<BoxShadow> shadow = [
  BoxShadow(
    color: Colors.black.withOpacity(0.25),
    spreadRadius: 2,
    blurRadius: 10,
    offset: const Offset(0,5),
  ),
];

