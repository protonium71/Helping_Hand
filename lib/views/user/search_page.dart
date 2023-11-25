import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helping_hand/models/user.dart' as model;
import 'package:helping_hand/providers/user_provider.dart';
import 'package:helping_hand/views/user/navigation.dart';
import 'package:helping_hand/widgets/search_results_widget.dart';
import 'package:provider/provider.dart'; 

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
  // ignore: non_constant_identifier_names
  String dropdown_value = "";
  // ignore: non_constant_identifier_names
  String textarea_value = "";
  // ignore: non_constant_identifier_names
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
  CollectionReference jobs = FirebaseFirestore.instance.collection('events');
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            final NavigationController controller = Get.find();
            controller.handleNotificationNavigation(0);
          },
          child: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20,)
        ),
        actions: [
          IconButton(
            onPressed: () async {
              UserProvider userProvider = Provider.of(context, listen: false);
              await userProvider.refreshUser();
              model.User user = userProvider.getUser;
              Map<String, dynamic> userMap = user.getData();
              setState(() {
                jobs = FirebaseFirestore.instance.collection('events');
              });
              
            },
            icon: const Icon(
              Icons.refresh_outlined,
              size: 25,
            ),
            splashRadius: 25,
          ),
        ], 
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
                SearchResultsWidget(category: widget.dropdownValue, searchDate:search_date, jobs:jobs),
              ],
            ),
          ),
        ),
      ),
    );
  }
}