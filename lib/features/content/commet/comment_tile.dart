// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:youtube_clone/features/upload/comments/comment_model.dart';

class CommentTile extends StatelessWidget {
  final CommentModel comment;
  const CommentTile({
    Key? key,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: Colors.grey,
                backgroundImage: CachedNetworkImageProvider(comment.profilePic),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.displayName,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const Text(
                      "a moment ago",
                      style: TextStyle(color: Colors.blueGrey, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.more_vert),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: 
            EdgeInsets.only(
              left:MediaQuery.sizeOf(context).width*0.1, 
            ),
            child: Text(comment.commentText),
            
          ),
          Divider(color: Colors.grey.shade300,)
        ],
      ),
    );
  }
}
