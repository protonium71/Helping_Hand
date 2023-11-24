// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helping_hand/widgets/event_card.dart';
const List<String> list = <String>['Recommendations', 'Location', 'Date', 'Cause', 'Organisation'];

// ignore: must_be_immutable
class SearchResultsWidget extends StatefulWidget {
  
  String? category;
  DateTime? searchDate;
  SearchResultsWidget({super.key, required this.category, required this.searchDate, DateTime? DateTime,});

  @override
  State<SearchResultsWidget> createState() => _SearchResultsWidgetState();
}

class _SearchResultsWidgetState extends State<SearchResultsWidget> {
  final CollectionReference _jobs = FirebaseFirestore.instance.collection('events'); 
  String textarea_value = "";
  
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    //final searchController = SearchController();
    if(widget.category == 'Location')widget.category = 'location';
    if(widget.category == 'Date')widget.category = 'startTime';
    if(widget.category == 'Cause')widget.category = 'cause';
    if(widget.category == 'Organisation')widget.category = 'organiserName';
    
    if(widget.category == 'Recommendations'){
      
      return Expanded(
        child: Column(
          children:[
            StreamBuilder(
            stream: _jobs.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
              //print(streamSnapshot.data!.docs.length);
              if(streamSnapshot.connectionState == ConnectionState.waiting)return const Center(child: CircularProgressIndicator(),);         
              return Expanded(
                child: ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,  
                  itemBuilder: (context, index){
                      DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                      return EventCard(documentSnapshot: documentSnapshot,  user:"volunteer");
                      
                  }),
              );
            },)
          ]
          
        ),
      );
    }
    else{
      return Expanded(
        child: Column(
          
            children: [
              SizedBox(height: height*0.02),
              if(widget.category != 'startTime')
                TextField(
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 160, 159, 159))
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: '${widget.category}' + '...',
                ),
                onChanged: (val){
                  setState(() {
                    textarea_value = val;
                  });
                },
              ) else const SizedBox(height: 0,),
              
              StreamBuilder(
                stream: _jobs.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
                  if(streamSnapshot.connectionState == ConnectionState.waiting)return Center(child: CircularProgressIndicator(),);
                  // else{
                    
                   
                    return Expanded(
                      child: ListView.builder(
                        //shrinkWrap: true,
                        itemCount: streamSnapshot.data!.docs.length,
                        
                        itemBuilder: (context, index){
                          // var data = streamSnapshot.data!.docs[index];
                          DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                          print(documentSnapshot[widget.category!]);
                          if(widget.category == 'startTime'){
                            print(1);
                            if(documentSnapshot[widget.category!].toDate().day == widget.searchDate?.day && documentSnapshot[widget.category!].toDate().month == widget.searchDate?.month && documentSnapshot[widget.category!].toDate().year == widget.searchDate?.year){
                              return EventCard(documentSnapshot: documentSnapshot,  user:"volunteer");
                            }
                            else return Center();
                          }
                          else if(textarea_value.isEmpty){  
                            print(2);
                            return EventCard(documentSnapshot: documentSnapshot,  user:"volunteer");
                          }    
                          else if(documentSnapshot[widget.category!].toLowerCase().startsWith(textarea_value.toLowerCase())){
                            print(3);
                            return EventCard(documentSnapshot: documentSnapshot,  user:"volunteer");
                          }
                          else {
                            print(4);
                            return Center();
                          }
                        }
                        ),
                    );
                  
                },
              )
            ],
          ),
      );
    }
  }
}