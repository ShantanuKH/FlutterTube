// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/features/auth/provider/user_provider.dart';

import 'package:youtube_clone/features/upload/comments/comment_repository.dart';
import 'package:youtube_clone/features/upload/long_video/videoModel.dart';

class CommentSheet extends ConsumerStatefulWidget {
  final VideoModel video;
  const CommentSheet({
    required this.video,
  });

  @override
  ConsumerState<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends ConsumerState<CommentSheet> {
  final TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // To use the user data
    final user = ref.watch(currentUserProvider).whenData((user) => user);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Comments",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close_sharp),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
            ),
            child: const Text(
                "Remember to keep comments respectful and to follow our community guidelines"),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: commentController,
                  decoration: InputDecoration(
                      hintText: "Add a comment...",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      suffixIcon: InkWell(
                          onTap: ()async {
                           await ref.watch(commentProvider).uploadCommentToFireStore(
                                commentText: commentController.text,
                                videoId: widget.video.videoId,
                                profilePic: user.value!.profilePic,
                                displayName: user.value!.displayName);
                          },
                          child: Icon(Icons.send))),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
