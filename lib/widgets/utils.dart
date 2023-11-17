import 'package:flutter/material.dart';

class Card{
  String? text;
  Icon? icon;
  double? size;

  Card({required this.text, required this.icon, required this.size});
}

List<Card> cardList = [
                        Card(text: 'Animals', icon: const Icon(Icons.pets), size: 12),
                        Card(text: 'Art & Culture', icon: const Icon(Icons.art_track, size: 40,), size: 11.5),
                        Card(text: 'Children & youth', icon: const Icon(Icons.child_friendly), size: 12),
                        Card(text: 'Computer & Technology', icon: const Icon(Icons.computer), size: 12),
                        Card(text: 'Cooking', icon: const Icon(Icons.fastfood), size: 12),
                        Card(text: 'Education & Literacy', icon: const Icon(Icons.cast_for_education), size: 12),
                        Card(text: 'Emergency & Safety', icon: const Icon(Icons.safety_check), size: 12),
                        Card(text: 'Employment', icon: const Icon(Icons.work), size: 11),
                        Card(text: 'Environment', icon: const Icon(Icons.nature), size: 11),
                        Card(text: 'Faith Based', icon: const Icon(Icons.healing), size: 12),
                        Card(text: 'Health & Medicine', icon: const Icon(Icons.health_and_safety), size: 12),
                        Card(text: 'Homeless & Housing', icon: const Icon(Icons.house), size: 12),
                        Card(text: 'Human Rights', icon: const Icon(Icons.man), size: 12),
                        Card(text: 'Immigrants & Refugees', icon: const Icon(Icons.flag), size: 12),
                        Card(text: 'International', icon: const Icon(Icons.group_add_outlined), size: 11),
                        Card(text: 'LGBTQ+', icon: const Icon(Icons.transgender), size: 12),
                        Card(text: 'Media & Broadcasting', icon: const Icon(Icons.perm_media), size: 11),
                        Card(text: 'Social Work', icon: const Icon(Icons.social_distance), size: 12),
                        Card(text: 'Sports', icon: const Icon(Icons.sports_tennis), size: 12),
                        Card(text: 'Tutoring', icon: const Icon(Icons.book), size: 12),
                      ];

    List<Card> skillCard =[
                        Card(text: 'Animal Care', icon: const Icon(Icons.pets), size: 12),
                        Card(text: 'Communication Skill', icon: const Icon(Icons.chat_bubble), size: 12),
                        Card(text: 'Counselling & Support', icon: const Icon(Icons.favorite), size: 11),
                        Card(text: 'Customer Service', icon: const Icon(Icons.headset_mic), size: 12),
                        Card(text: 'Creativity', icon: const Icon(Icons.brush), size: 11),
                        Card(text: 'Education & Mentoring', icon: const Icon(Icons.school), size: 12),
                        Card(text: 'Environmental Skill', icon: const Icon(Icons.eco), size: 12),
                        Card(text: 'Event Planning', icon: const Icon(Icons.event), size: 12),
                        Card(text: 'Fundraising', icon: const Icon(Icons.monetization_on), size: 12),
                        Card(text: 'Healthcare Skills', icon: const Icon(Icons.eco), size: 12),
                        Card(text: 'Teamwork', icon: const Icon(Icons.people, size: 40,), size: 11.5),
                        Card(text: 'Language Skill', icon: const Icon(Icons.language), size: 12),
                        Card(text: 'Manual Skill', icon: const Icon(Icons.build), size: 11),
                        Card(text: 'Organizational Skill', icon: const Icon(Icons.event), size: 12),
                        Card(text: 'Research Skill', icon: const Icon(Icons.search), size: 11),
                        Card(text: 'Sports & Fitness', icon: const Icon(Icons.fitness_center), size: 12),
                        Card(text: 'Social Media', icon: const Icon(Icons.share), size: 12),
                        Card(text: 'Teaching & Training', icon: const Icon(Icons.school), size: 12),
                        Card(text: 'Technical Skill', icon: const Icon(Icons.code), size: 12),
                        Card(text: 'Technical Support', icon: const Icon(Icons.settings), size: 12),
    ];

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

// String getTextResult(){

// }