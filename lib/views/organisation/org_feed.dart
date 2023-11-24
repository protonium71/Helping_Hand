import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helping_hand/models/organisation.dart' ;
import 'package:helping_hand/providers/organisation_provider.dart';
import 'package:helping_hand/views/organisation/org_event_details.dart';
import 'package:helping_hand/widgets/event_card.dart';
import 'package:provider/provider.dart';

class OrganisationFeed extends StatefulWidget {
  const OrganisationFeed({super.key});

  @override
  State<OrganisationFeed> createState() => _OrganisationFeedState();
}

class _OrganisationFeedState extends State<OrganisationFeed> {
  final CollectionReference _events = FirebaseFirestore.instance.collection('events');

  Widget build(BuildContext context){

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    
    Organisation organisation = Provider.of<OrganisationProvider>(context, listen: false).getOrganisation;
    Map<String, dynamic> organisationMap = organisation.getData();

    List<dynamic> organisationEvents = organisationMap['upcomingEvents'];
    print(organisationMap['email']);
    //print(userEvents);
    // Timestamp t1 = _events['startTime'] ;
    
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          }, 
          child: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20,),
        ), 
        centerTitle: true,
        title:  const Text(
          'Posted Events',
          style: TextStyle(
              color: Color(0xFF1D1517),
              fontSize: 25,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
          ),
        ),
        titleTextStyle: const TextStyle(color: Colors.black87, fontSize: 28),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(height*0.025),
            child: Container(
              width: width*0.9,
              height: height*0.07,
              decoration: ShapeDecoration(
                  color: const Color.fromARGB(255, 218, 234, 251),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                  ),
                  shadows: const [
                      BoxShadow(
                          color: Color(0x111D1617),
                          blurRadius: 40,
                          offset: Offset(0, 10),
                          spreadRadius: 0,
                      )
                  ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width*0.04),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text(
                      'Upcoming Events',
                      style: TextStyle(
                          color: Color(0xFF1D1517),
                          fontSize: 25,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: width*0.01,),
                    const Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Icon(Icons.arrow_forward, size: 25,)
                        ],
                      )
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: height*0.25,
            child: StreamBuilder(
              stream: _events.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
                if(streamSnapshot.hasData){
                  return ListView.builder( 
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index){
                      final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                      Timestamp t1 = documentSnapshot['startTime'];
                      DateTime s_date = t1.toDate();
                      DateTime now = DateTime.now();
                      if(s_date.isAfter(now) && organisationEvents.contains(documentSnapshot['eventid'])){
                        print(documentSnapshot['eventid']);
                        return OrganisationEventDetailsPage(documentSnapshot: documentSnapshot, user:'organisation');
                      }
                      else {
                        return const SizedBox(height: 0,);
                      }
                  });
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            ),
          ),
          SizedBox(height: height*0.02,),
          Padding(
            padding: EdgeInsets.all(height*0.025),
            child: Container(
              width: width*0.9,
              height: height*0.07,
              decoration: ShapeDecoration(
                  color: const Color.fromARGB(255, 218, 234, 251),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                  ),
                  shadows: const [
                      BoxShadow(
                          color: Color(0x111D1617),
                          blurRadius: 40,
                          offset: Offset(0, 10),
                          spreadRadius: 0,
                      )
                  ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width*0.04),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text(
                      'Events History',
                      style: TextStyle(
                          color: Color(0xFF1D1517),
                          fontSize: 25,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: width*0.01,),
                    const Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Icon(Icons.arrow_forward, size: 25,)
                        ],
                      )
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: height*0.25,
            child: StreamBuilder(
              stream: _events.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
                if(streamSnapshot.hasData){
                  return ListView.builder( 
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index){
                      final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                      Timestamp t1 = documentSnapshot['startTime'] ;
                      DateTime s_date = t1.toDate();
                      DateTime now = DateTime.now();
                      if(s_date.isBefore(now) && organisationEvents.contains(documentSnapshot['eventid'])){
                        //print(userEvents);
                        print(documentSnapshot['eventid']);
                        return EventCard(documentSnapshot: documentSnapshot, user:'organisation');
                      }
                      else {
                        return const SizedBox(height: 0,);
                      }
                  });
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            ),
          ),         
        ],
      ),
    );
  }

}