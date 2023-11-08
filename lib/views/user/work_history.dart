import 'package:flutter/material.dart';

const List<CardItem> items = [
  CardItem(
      urlImage:
          'https://img.freepik.com/free-photo/abstract-design-with-colorful-patterns-nature-leaf-generated-by-ai_188544-15573.jpg?size=626&ext=jpg',
      title: 'photo'),
  CardItem(
      urlImage:
          'https://img.freepik.com/free-photo/abstract-design-with-colorful-patterns-nature-leaf-generated-by-ai_188544-15573.jpg?size=626&ext=jpg',
      title: 'photo'),
  CardItem(
      urlImage:
          'https://img.freepik.com/free-photo/abstract-design-with-colorful-patterns-nature-leaf-generated-by-ai_188544-15573.jpg?size=626&ext=jpg',
      title: 'photo'),
];

class CardItem {
  final String urlImage;
  final String title;

  const CardItem({
    required this.urlImage,
    required this.title,
  });
}

class WorkHistory extends StatefulWidget {
  const WorkHistory({super.key});

  @override
  State<WorkHistory> createState() => _WorkHistoryState();
}

class _WorkHistoryState extends State<WorkHistory> {
  @override
  Widget build(BuildContext context) => Container(
      height: 140,
      child: ListView.separated(
        //padding: EdgeInsets.all(2),
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        separatorBuilder: (context, _) => SizedBox(width: 1),
        itemBuilder: (context, index) => buildCard(items[index]),
      ));
}

Widget buildCard(
  CardItem item,
) =>
    Container(
      width: 200,
      child: Column(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  item.urlImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item.title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
