import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helping_hand/views/user/navigation.dart';
import 'package:helping_hand/widgets/donation_card.dart';

// ignore: must_be_immutable
class PaymentPage extends StatefulWidget {
  const PaymentPage({
    super.key,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final CollectionReference _jobs =
      FirebaseFirestore.instance.collection('organisations');
  // ignore: non_constant_identifier_names
  String textarea_value = "";

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              final NavigationController controller = Get.find();
              controller.handleNotificationNavigation(0);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            )),
        centerTitle: true,
        title: const Text(
          'Fundraising',
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.04, vertical: height * 0.01),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 160, 159, 159))),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: "Search organisation",
                      ),
                      onChanged: (val) {
                        setState(() {
                          textarea_value = val;
                        });
                      },
                    ),
                    SizedBox(height: height * 0.01),
                    StreamBuilder(
                      stream: _jobs.snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                        if (streamSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return Expanded(
                            child: ListView.builder(
                                itemCount: streamSnapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot documentSnapshot =
                                      streamSnapshot.data!.docs[index];
                                  if (documentSnapshot['orgname']
                                      .toString()
                                      .toLowerCase()
                                      .startsWith(
                                          textarea_value.toLowerCase())) {
                                    return DonationCard(
                                        documentSnapshot: documentSnapshot);
                                  } else {
                                    return Container();
                                  }
                                }),
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
