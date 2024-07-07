import 'package:flutter/material.dart';

class TopHeader extends StatelessWidget {
  const TopHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         const Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey,
              ),
            ),

            const Padding(
              padding: const EdgeInsets.only(top:11, bottom: 4),
              child: Text("Shantanu khadse",
              style: 
              TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
              ),
                        ),
            ),
          Padding(
            padding: const EdgeInsets.only(bottom: 9.0),
            child: RichText(text: 
         const TextSpan(
              style: TextStyle(
                color:Colors.blueGrey,
            
              ),
              children: [
                TextSpan(text: "@khadseshantanu02 "),
                TextSpan(text: "No Subscribtions "),
                TextSpan(text: "No Videos")
              ]
            )
            ),
          ),
      ],
    );
  }
}