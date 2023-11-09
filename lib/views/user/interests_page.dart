import 'package:flutter/material.dart';
import 'package:helping_hand/utilities/interest_card.dart';
import 'package:helping_hand/utilities/my_button.dart';
import 'package:helping_hand/utilities/utils.dart';

class InterestsPage extends StatelessWidget {
  const InterestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
               SizedBox(height: height * 0.05,),
              const Text('Select your interests', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color(0xff323459)),),
              SizedBox(height: height * 0.005,),
              const Text('You can choose multiple categories', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),),
               SizedBox(height: height * 0.02,),
              Container(
                height: height * 0.57,
                child: GridView.builder(
                  padding: const EdgeInsets.all(15),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: cardList.length,
                  itemBuilder: (BuildContext context, int index){
                    return InterestCard(text: cardList[index].text!, icon: cardList[index].icon!, size: cardList[index].size!,);
                  }
                ),
              ),
              //continue button
              SizedBox(height: height * 0.02,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: MyButton(onTap: () {}, text: 'Continue', color: const Color(0xff6379A5),),
              ),

              //skip button
               SizedBox(height: height * 0.02,),
              GestureDetector(
                onTap: (){},
                child: Container(
                  padding: const EdgeInsets.all(25),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration( borderRadius: BorderRadius.circular(50), border: Border.all(color: const Color(0xffBBBBD6))),
                  child: const Center(
                    child: Text('Skip', style: TextStyle(color: Color.fromARGB(255, 144, 144, 151), fontWeight: FontWeight.bold, fontSize: 16),),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}