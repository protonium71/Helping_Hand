import 'package:flutter/material.dart';
import 'package:helping_hand/widgets/search_results_widget.dart'; 

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
  String dropdown_value = "";
  String textarea_value = "";
  DateTime? search_date = DateTime.now();
  final searchController = TextEditingController();
  _showDatePicker(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2000), 
      lastDate: DateTime(2030)
    ).then((value){
      setState(() {
        search_date = value;
      });
    });
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
                SearchResultsWidget(category: widget.dropdownValue, searchDate:search_date,),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}