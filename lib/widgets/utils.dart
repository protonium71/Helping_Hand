// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Card{
  String text;
  Icon icon;
  double size;

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

List<Card> skillCard = [
                        Card(text: 'Animal Care', icon: const Icon(Icons.pets), size: 12),
                        Card(text: 'Communication Skill', icon: const Icon(Icons.chat_bubble, size: 25,), size: 11.5),
                        Card(text: 'Counselling and Support', icon: const Icon(Icons.favorite), size: 12),
                        Card(text: 'Customer Service', icon: const Icon(Icons.headset_mic), size: 12),
                        Card(text: 'Creativity', icon: const Icon(Icons.brush), size: 12),
                        Card(text: 'Education & Mentoring', icon: const Icon(Icons.school), size: 12),
                        Card(text: 'Environment Skill', icon: const Icon(Icons.eco), size: 12),
                        Card(text: 'Event Planning', icon: const Icon(Icons.event), size: 11),
                        Card(text: 'Fundraising', icon: const Icon(Icons.monetization_on), size: 11),
                        Card(text: 'Healthcare Skills', icon: const Icon(Icons.healing), size: 12),
                        Card(text: 'Teamwork', icon: const Icon(Icons.people), size: 12),
                        Card(text: 'Language Skill', icon: const Icon(Icons.language), size: 12),
                        Card(text: 'Manual Skill', icon: const Icon(Icons.build), size: 12),
                        Card(text: 'Organisation Skill', icon: const Icon(Icons.event), size: 12),
                        Card(text: 'Research Skill', icon: const Icon(Icons.search), size: 11),
                        Card(text: 'Sports and Fitness', icon: const Icon(Icons.fitness_center), size: 12),
                        Card(text: 'Social Media', icon: const Icon(Icons.share), size: 11),
                        Card(text: 'Teaching', icon: const Icon(Icons.school), size: 12),
                        Card(text: 'Technical Skill', icon: const Icon(Icons.code), size: 12),
                        Card(text: 'Technical Support', icon: const Icon(Icons.settings), size: 12),
                      ];

//this map maps the string value of skills to their respective icons
Map<String, Icon>s_string_icon = {
'Animal Care':const Icon(Icons.pets),
'Communication Skill':const Icon(Icons.chat_bubble),
'Counselling and Support':const Icon(Icons.favorite),
'Customer Service':const Icon(Icons.headset_mic),
'Creativity':const Icon(Icons.brush),
'Education & Mentoring':const Icon(Icons.school),
'Environment Skill':const Icon(Icons.eco),
'Event Planning':const Icon(Icons.event),
'Fundraising':const Icon(Icons.monetization_on),
'Healthcare Skills':const Icon(Icons.healing),
'Teamwork':const Icon(Icons.people),
'Language Skill':const Icon(Icons.language),
'Manual Skill':const Icon(Icons.build),
'Organisation Skill':const Icon(Icons.event),
'Research Skill':const Icon(Icons.search),
'Sports and Fitness':const Icon(Icons.fitness_center),
'Social Media':const Icon(Icons.share),
'Teaching':const Icon(Icons.school),
'Technical Skill':const Icon(Icons.code),
'Technical Support':const Icon(Icons.settings),
};

//this map maps the string value of interests to their respective icons
Map<String, Icon>i_string_icon = {
'Animals':const Icon(Icons.pets),
'Art & Culture':const Icon(Icons.art_track),
'Children & youth':const Icon(Icons.child_friendly),
'Cooking':const Icon(Icons.fastfood),
'Education & Literacy':const Icon(Icons.cast_for_education),
'Emergency & Safety':const Icon(Icons.safety_check),
'Employment':const Icon(Icons.work),
'Environment':const Icon(Icons.nature),
'Faith Based':const Icon(Icons.healing),
'Health & Medicine':const Icon(Icons.health_and_safety),
'Homeless & Housing':const Icon(Icons.house),
'Human Rights':const Icon(Icons.man),
'Immigrants & Refugees':const Icon(Icons.flag),
'International':const Icon(Icons.group_add_outlined),
'LGBTQ+':const Icon(Icons.transgender),
'Media & Broadcasting':const Icon(Icons.perm_media),
'Social Work':const Icon(Icons.social_distance),
'Sports':const Icon(Icons.sports_tennis),
'Tutoring':const Icon(Icons.book),
};

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

pickImage(ImageSource source) async{
  final ImagePicker _imagePicker = ImagePicker();
  XFile? file = await _imagePicker.pickImage(source: source);
  if(file != null)return await file.readAsBytes();
  print("no image selected");
}