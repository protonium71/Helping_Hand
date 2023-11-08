import 'package:flutter/material.dart';
import 'package:helping_hand/utilities/event_card.dart';
import 'package:helping_hand/utilities/search_box.dart';

const List<String> list = <String>['Recommendations', 'Location', 'Date', 'Cause', 'Organisation'];

// ignore: must_be_immutable
class SearchPage extends StatefulWidget {
  String? dropdownValue = list.first;
  dynamic controller;

  SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  _showDatePicker(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2000), 
      lastDate: DateTime(2030)
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){},
          child: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20,)
        ), 
        centerTitle: true,
        title: const Text(
            'Volunteer Events',
            style: TextStyle(
                color: Color(0xFF1D1517),
                fontSize: 26,
                // fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
            ),
        ),
        shadowColor: Colors.white, 
        backgroundColor: Colors.white, 
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width*0.04, vertical: height*0.01),
            child: Column(
              children: [
                DropdownMenu<String>(
                  textStyle: const TextStyle(fontSize: 18),
                  initialSelection: list.first,
                  width: width*0.92,
                  onSelected: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      widget.dropdownValue = value!;
                    });
                    if(widget.dropdownValue == 'Date'){
                      _showDatePicker();
                    }
                  },
                  dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(value: value, label: value);
                  }).toList(),
                ),
                SearchBox(value: widget.dropdownValue),
                SizedBox(height: height*0.015),
                if (widget.dropdownValue == list.first) Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Recommendations',
                          style: TextStyle(
                              color: Color(0xFF1D1517),
                              fontSize: 25,
                              // fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              // height: 0.09,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height*0.005,),
                  ],
                ) else const SizedBox(height: 0,),
                if (widget.dropdownValue == list.first) Expanded(
                  child: ListView.builder(
                    // padding: const EdgeInsets.all(20),
                    // physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      var documentSnapshot;
                      return  EventCard(documentSnapshot: documentSnapshot);
                    }
                  ),
                ) else const SizedBox(height: 0,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}