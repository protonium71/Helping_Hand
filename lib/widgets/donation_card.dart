import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_upi_payment/easy_upi_payment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DonationCard extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  const DonationCard({super.key, required this.documentSnapshot});

  @override
  State<DonationCard> createState() => _DonationCardState();
}

class _DonationCardState extends State<DonationCard> {

  void showErrorMessage(String message){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text(message),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.01),
      child: Container(
        height: height * 0.22,
        // color: Colors.yellow,
        child: Row(
          children: [
            Container(
              height: height * 0.22,
              width: width * 0.42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.red,
              ),
            ),
            Container(
              height: height * 0.22,
              width: width * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * 0.18,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: height * 0.005,
                          ),
                          Container(
                            // height: ,
                            child:  Text(
                              widget.documentSnapshot['orgname'],
                              maxLines: 2,
                              style: const TextStyle(
                                color: Color(0xFF1D1517),
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            child:  Text(
                              widget.documentSnapshot['bio'],
                              maxLines: 6,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 85, 83, 83),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () async{
                        try {
                          final res = await EasyUpiPaymentPlatform.instance.startPayment(
                            EasyUpiPaymentModel(
                              payeeVpa: widget.documentSnapshot['upiID'],
                              payeeName: FirebaseAuth.instance.currentUser!.displayName.toString(),
                              amount: 0,
                              description: 'Donation',
                            ),
                          );
                          // TODO: add your success logic here
                          print(res);
                          // if(res.responseCode)
                        } on EasyUpiPaymentException catch(err){
                          // TODO: add your exception logic here
                          if(err.message == "Payee VPA address should be valid (For e.g. example@vpa)"){
                            showErrorMessage("Payee VPA address should be valid (For e.g. example@vpa)");
                          }
                          if(err.type == EasyUpiPaymentExceptionType.cancelledException){
                            showErrorMessage("Transaction Cancelled!");
                          }
                          if(err.type == EasyUpiPaymentExceptionType.failedException){
                            showErrorMessage("Transaction Failed!");
                          }
                          if(err.type == EasyUpiPaymentExceptionType.appNotFoundException){
                            showErrorMessage("App not found!");
                          }
                        }
                      },
                      child: Container(
                        height: height * 0.04,
                        width: width * 0.25,
                        decoration: BoxDecoration(
                          color: const Color(0xff6379A5),
                          borderRadius: BorderRadius.circular(5),
                          gradient: const LinearGradient(
                            begin: Alignment(-1.00, 0.08),
                            end: Alignment(1, -0.08),
                            colors: [Color(0xFF92A3FD), Color(0xFF9DCEFF)],
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Donate',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
