// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/cores/screens/error_page.dart';
import 'package:youtube_clone/cores/screens/loader.dart';
import 'package:youtube_clone/features/auth/provider/user_provider.dart';
import 'package:youtube_clone/features/content/commet/comment_tile.dart';
import 'package:youtube_clone/features/upload/comments/comment_model.dart';

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

          // To show comments in the screen...also we want to specify comments on the specific video so we used where condition
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("comments")
                  .where("videoId", isEqualTo: widget.video.videoId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return ErrorPage();
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Loader();
                }

                final commentsMap = snapshot.data!.docs;
                final List<CommentModel> comments = commentsMap
                    .map((comment) => CommentModel.fromMap(comment.data()))
                    .toList();
                return Expanded(
                  child: ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        return CommentTile(comment: comments[index]);
                      }),
                );
              }),

          
          Row(
            children: [
               CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey,
               backgroundImage: CachedNetworkImageProvider(
                    user.value!.profilePic
                  ),
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
                          onTap: () async {
                            await ref
                                .watch(commentProvider)
                                .uploadCommentToFireStore(
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
