// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:swaptry/models/station.dart';

class SearchPage1 extends StatefulWidget {
  const SearchPage1({super.key});

  @override
  State<SearchPage1> createState() => SearchPage1State();
}

class SearchPage1State extends State<SearchPage1> {
  static List<Station> main_station_list = [];

  List<Station> display_list = List.from(main_station_list);
  // filter list
  void updateList(String value) {
    // search function
    setState() {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0.8,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // tulisan city
            Text(
              'City',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),

            // search bar
            TextField(
              // tulisan input warna apa
              style: TextStyle(color: Colors.black),
              // box
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey,
                // border
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                // tulisan hint
                hintText: 'Search Swap Station',
                // icon
                prefixIcon: Icon(Icons.search),
                prefixIconColor: Colors.purple,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: display_list.length,
                itemBuilder: (context, index) => ListTile(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
