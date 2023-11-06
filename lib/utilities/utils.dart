import 'package:flutter/material.dart';

class Card{
  String? text;
  Icon? icon;
  double? size;

  Card({required this.text, required this.icon, required this.size});
}

List<Card> cardList = [
                        Card(text: 'Animals', icon: Icon(Icons.pets), size: 12),
                        Card(text: 'Art & Culture', icon: Icon(Icons.art_track, size: 40,), size: 12),
                        Card(text: 'Children & youth', icon: Icon(Icons.child_friendly), size: 12),
                        Card(text: 'Computer & Technology', icon: Icon(Icons.computer), size: 12),
                        Card(text: 'Cooking', icon: Icon(Icons.fastfood), size: 12),
                        Card(text: 'Education & Literacy', icon: Icon(Icons.cast_for_education), size: 12),
                        Card(text: 'Emergency & Safety', icon: Icon(Icons.safety_check), size: 12),
                        Card(text: 'Employment', icon: Icon(Icons.work), size: 12),
                        Card(text: 'Environment', icon: Icon(Icons.nature), size: 12),
                        Card(text: 'Faith Based', icon: Icon(Icons.healing), size: 12),
                        Card(text: 'Health & Medicine', icon: Icon(Icons.health_and_safety), size: 12),
                        Card(text: 'Homeless & Housing', icon: Icon(Icons.house), size: 12),
                        Card(text: 'Human Rights', icon: Icon(Icons.man), size: 12),
                        Card(text: 'Immigrants & Refugees', icon: Icon(Icons.flag), size: 12),
                        Card(text: 'International', icon: Icon(Icons.group_add_outlined), size: 12),
                        Card(text: 'LGBTQ+', icon: Icon(Icons.transgender), size: 12),
                        Card(text: 'Media & Broadcasting', icon: Icon(Icons.perm_media), size: 11.5),
                        Card(text: 'Social Work', icon: Icon(Icons.social_distance), size: 12),
                        Card(text: 'Sports', icon: Icon(Icons.sports_tennis), size: 12),
                        Card(text: 'Tutoring', icon: Icon(Icons.book), size: 12),
                      ];

class EventCard extends StatelessWidget {
  const EventCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: 200,
        // color: Colors.black,s
        child: Row(
          children: [
            Container(
              height: 200,
              width: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.red,
              ),
            ),
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 165,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5,),
                          Container( 
                            child: Text(
                                'test data',
                                style: TextStyle(
                                    color: Color(0xFF1D1517),
                                    fontSize: 15,
                                    // fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    // height: 0.12,
                                ),
                            )
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Icon(Icons.location_on_outlined, color: const Color(0xFF7B6F72),),
                              SizedBox(width: 7,),
                              Text('test data', style: TextStyle(fontSize: 15, color: Color(0xFF7B6F72))),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Icon(Icons.date_range_outlined, color: const Color(0xFF7B6F72),),
                              SizedBox(width: 7,),
                              Text('test data', style: TextStyle(fontSize: 15, color: Color(0xFF7B6F72))),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Icon(Icons.people_alt_outlined, color: const Color(0xFF7B6F72),),
                              SizedBox(width: 7,),
                              Text('test data', style: TextStyle(fontSize: 15, color: Color(0xFF7B6F72))),
                            ],
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        height: 35,
                        width: 100,
                        // padding: const EdgeInsets.all(25),
                        // margin: const EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          color: Color(0xff6379A5), 
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(
                            begin: Alignment(-1.00, 0.08),
                            end: Alignment(1, -0.08),
                            colors: [Color(0xFF92A3FD), Color(0xFF9DCEFF)],
                          ),
                        ),
                        child: Center(
                          child: Text('Details', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
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
    if(value != null){
      if(value == 'Location' || value == 'Cause' || value == 'Organisation'){
        return Column(
          children: [
            const SizedBox(height: 20),
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
                hintText: 'Enter ${value}'
              ),
            ),
          ],
        );
      }
      else{
        return SizedBox(height: 0,);
      }
    }
    else return SizedBox(height: 0,);
  }
}


//custom colorswatch
Map<int, Color> color =
{
50:Color.fromARGB(255,146,163,253),
100:Color.fromARGB(255,146,163,253),
200:Color.fromARGB(255,146,163,253),
300:Color.fromARGB(255,146,163,253),
400:Color.fromARGB(255,146,163,253),
500:Color.fromARGB(255,146,163,253),
600:Color.fromARGB(255,146,163,253),
700:Color.fromARGB(255,146,163,253),
800:Color.fromARGB(255,146,163,253),
900:Color.fromARGB(255,146,163,253),
};

MaterialColor colorCustom = MaterialColor(0xFF92A3FD, color);