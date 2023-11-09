import 'package:flutter/material.dart';
import 'package:helping_hand/utilities/interest_card.dart';
import 'package:helping_hand/utilities/utils.dart';

class CustomProfileContainer extends StatelessWidget {
  final String text;
  final String type;

  const CustomProfileContainer({super.key, required this.text, required this.type});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width*0.9,
      height: height*0.2,
      decoration: ShapeDecoration(
          color: Colors.white,
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
        padding:  EdgeInsets.symmetric(horizontal: width*0.04, vertical: height*0.012),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(height: 10,),
            Text(
              text,
              style: const TextStyle(
                  color: Color(0xFF1D1517),
                  fontSize: 25,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
              ),
            ),
             SizedBox(height: height*0.007,),
            Container(
              height: height*0.13,
              // color: Colors.black,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 12,
                itemBuilder: (BuildContext context, int index) {
                  if(type == 'interests'){
                    return  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(height: height*0.13, width: width*0.237, child: InterestCard(text: cardList[index].text!, icon: cardList[index].icon!, size: cardList[index].size!,),),
                    );
                  }
                  else if(type == 'skills'){
                    return  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(height: height*0.13, width: width*0.237, color: Colors.red,),
                    );
                  }
                  else{
                    return  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(height: height*0.13, width: width*0.237, color: Colors.red,),
                    );
                  }
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}