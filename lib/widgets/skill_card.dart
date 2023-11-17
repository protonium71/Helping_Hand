import 'package:flutter/material.dart';

class SkillCard extends StatefulWidget {
  final String text;
  final Icon icon;
  final double size;
  List <String> list;

   SkillCard({super.key, required this.text, required this.icon, required this.size, required this.list});

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        setState(() {
          if(widget.list.contains(widget.text)){
            widget.list.remove(widget.text);
            isTapped = false;
          }
          else{
            widget.list.add(widget.text);
            isTapped = true;
          }
        });
      },
      child: Container(
        // color: Colors.teal[400],
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), 
          color: isTapped ? const Color.fromARGB(255, 182, 193, 248) : Colors.white,
          border: Border.all(color: Color(0xffBBBBD6))
          
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.icon,
              Text(widget.text, style: TextStyle(fontSize: widget.size, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
            ],
          ),
        )
      ),
    );
  }
}