import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchBox extends StatelessWidget {
  String? value;

  SearchBox({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    if(value != null){
      if(value == 'Location' || value == 'Cause' || value == 'Organisation'){
        return Column(
          children: [
            SizedBox(height: height*0.02),
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
                hintText: 'Enter $value'
              ),
            ),
          ],
        );
      }
      else{
        return const SizedBox(height: 0,);
      }
    }
    else {return const SizedBox(height: 0,);}
  }
}
