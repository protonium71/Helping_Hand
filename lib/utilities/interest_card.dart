import 'package:flutter/material.dart';

class InterestCard extends StatelessWidget {
  final String text;
  final Icon icon;
  final double size;

  const InterestCard({super.key, required this.text, required this.icon, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.teal[400],
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8), 
        // color: Colors.teal[400],
        border: Border.all(color: Color(0xffBBBBD6))
        
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Text(text, style: TextStyle(fontSize: size, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
          ],
        ),
      )
    );
  }
}