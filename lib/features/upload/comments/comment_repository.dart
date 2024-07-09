// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:youtube_clone/features/upload/comments/comment_model.dart';

final commentProvider =
    Provider((ref) => CommentRepository(
      firestore: FirebaseFirestore.instance)
      );

class CommentRepository {
  final FirebaseFirestore firestore;
  CommentRepository({
    required this.firestore,
  });

// To upload comments in the firestore
  Future<void> uploadCommentToFireStore({
    required String commentText,
    required String videoId,
    required String profilePic,
    required String displayName,
  }) async {
    String commentId = Uuid().v4();
    CommentModel comment = CommentModel(
        commentText: commentText,
        videoId: videoId,
        commentId: commentId,
        displayName: displayName,
        profilePic: profilePic);
    await firestore.collection("comments").doc(commentId).set(comment.toMap());
  }
}
