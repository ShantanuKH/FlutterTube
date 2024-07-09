import 'package:flutter/material.dart';

class CommentTile extends StatelessWidget {
  const CommentTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: Colors.grey,
          
              ),
              Text("Shantanu", style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500
              ),
              ),
              Text("a moment ago"),
              Spacer(),
              Icon(Icons.more_vert)
            ],
          ),

          Text("First Comment"),
        ],

      ),

    );
  }
}