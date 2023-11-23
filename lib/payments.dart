import 'package:flutter/material.dart';
import 'package:upi_india/upi_india.dart';
class Payments extends StatefulWidget {
  const Payments({super.key});

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  Future<UpiResponse>? _transaction;
  final UpiIndia _upiIndia = UpiIndia();
  List<UpiIndia>?apps;

  void initState(){
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value){
      setState(() {
        apps = value.cast<UpiIndia>();
      });
    }).catchError((e){
      print(e);
      apps = [];
    });
    super.initState();
  }

  Future<UpiResponse> initiateTransaction(UpiApp app)async{
    return _upiIndia.startTransaction(
      app: app, 
      receiverUpiId: "8810404074@paytm", 
      receiverName: "yash", 
      transactionRefId: "payment",
      amount:1,
      );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}