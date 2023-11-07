import 'package:flutter/material.dart';

class Card{
  String? text;
  Icon? icon;
  double? size;

  Card({required this.text, required this.icon, required this.size});
}

List<Card> cardList = [
                        Card(text: 'Animals', icon: const Icon(Icons.pets), size: 12),
                        Card(text: 'Art & Culture', icon: const Icon(Icons.art_track, size: 40,), size: 12),
                        Card(text: 'Children & youth', icon: const Icon(Icons.child_friendly), size: 12),
                        Card(text: 'Computer & Technology', icon: const Icon(Icons.computer), size: 12),
                        Card(text: 'Cooking', icon: const Icon(Icons.fastfood), size: 12),
                        Card(text: 'Education & Literacy', icon: const Icon(Icons.cast_for_education), size: 12),
                        Card(text: 'Emergency & Safety', icon: const Icon(Icons.safety_check), size: 12),
                        Card(text: 'Employment', icon: const Icon(Icons.work), size: 12),
                        Card(text: 'Environment', icon: const Icon(Icons.nature), size: 12),
                        Card(text: 'Faith Based', icon: const Icon(Icons.healing), size: 12),
                        Card(text: 'Health & Medicine', icon: const Icon(Icons.health_and_safety), size: 12),
                        Card(text: 'Homeless & Housing', icon: const Icon(Icons.house), size: 12),
                        Card(text: 'Human Rights', icon: const Icon(Icons.man), size: 12),
                        Card(text: 'Immigrants & Refugees', icon: const Icon(Icons.flag), size: 12),
                        Card(text: 'International', icon: const Icon(Icons.group_add_outlined), size: 12),
                        Card(text: 'LGBTQ+', icon: const Icon(Icons.transgender), size: 12),
                        Card(text: 'Media & Broadcasting', icon: const Icon(Icons.perm_media), size: 11.5),
                        Card(text: 'Social Work', icon: const Icon(Icons.social_distance), size: 12),
                        Card(text: 'Sports', icon: const Icon(Icons.sports_tennis), size: 12),
                        Card(text: 'Tutoring', icon: const Icon(Icons.book), size: 12),
                      ];

class EventCard extends StatelessWidget {
  const EventCard({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: height*0.01),
      child: SizedBox(
        height: height*0.22,
        // color: Colors.black,
        child: Row(
          children: [
            Container(
              height: height*0.22,
              width: width*0.42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.red,
              ),
            ),
            Container(
              height: height*0.22,
              width: width*0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                // color: Colors.green,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width*0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height*0.18,
                      // color: Colors.yellow,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: height*0.005,),
                          const Text(
                              'test data ',
                              style: TextStyle(
                                  color: Color(0xFF1D1517),
                                  fontSize: 15,
                                  // fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  // height: 0.12,
                              ),
                          ),
                          SizedBox(height: height*0.005,),
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined, color: Color(0xFF7B6F72),),
                              SizedBox(width: width*0.015,),
                              const Text('test data', style: TextStyle(fontSize: 15, color: Color(0xFF7B6F72))),
                            ],
                          ),
                          SizedBox(height: height*0.01,),
                          Row(
                            children: [
                              const Icon(Icons.date_range_outlined, color: Color(0xFF7B6F72),),
                              SizedBox(width: width*0.015,),
                              const Text('test data', style: TextStyle(fontSize: 15, color: Color(0xFF7B6F72))),
                            ],
                          ),
                          SizedBox(height: height*0.01,),
                          Row(
                            children: [
                              const Icon(Icons.people_alt_outlined, color: Color(0xFF7B6F72),),
                              SizedBox(width: width*0.015,),
                              const Text('test data', style: TextStyle(fontSize: 15, color: Color(0xFF7B6F72))),
                            ],
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        height: height*0.04,
                        width: width*0.25,
                        // padding: const EdgeInsets.all(25),
                        // margin: const EdgeInsets.symmetric(horizontal: 25),
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
                          child: Text('Details', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
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


//custom colorswatch
Map<int, Color> color =
{
50:const Color.fromARGB(255,146,163,253),
100:const Color.fromARGB(255,146,163,253),
200:const Color.fromARGB(255,146,163,253),
300:const Color.fromARGB(255,146,163,253),
400:const Color.fromARGB(255,146,163,253),
500:const Color.fromARGB(255,146,163,253),
600:const Color.fromARGB(255,146,163,253),
700:const Color.fromARGB(255,146,163,253),
800:const Color.fromARGB(255,146,163,253),
900:const Color.fromARGB(255,146,163,253),
};

MaterialColor colorCustom = MaterialColor(0xFF92A3FD, color);