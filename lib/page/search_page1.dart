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
      appBar: AppBar(
          elevation: 0,
          title: const Text(
            'Search Station',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          backgroundColor: const Color(0xff6E80FE),
        ),
      body: Column(
        children: [
          Stack(
            children: 
              [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 65,
                  decoration: const BoxDecoration(
                    color: Color(0xff6E80FE),
                  ),
                ),

                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width-40,
                    height: 45,
                    child: TextField(
                      
                      // tulisan input warna apa
                      style: const TextStyle(color: Colors.black),
                      
                      // box
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        // border
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none
                          ),
                        ),
                        // tulisan hint
                        hintText: 'Search Swap Station',
                        contentPadding: const EdgeInsets.all(0),
                        // icon
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: display_list.length,
              itemBuilder: (context, index) => ListTile(),
            ),
          ),
        ],
      ),
    );
  }
}
