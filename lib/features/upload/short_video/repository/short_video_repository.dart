import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/features/upload/short_video/model/short_video_model.dart';

final shortVideoProvider = Provider((ref) => ShortVideoRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class ShortVideoRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  
  ShortVideoRepository({
    required this.auth,
    required this.firestore,
  });

  Future<void> addShortVideoToFirestore({
    required String caption,
    required String video,
    required DateTime datePublished,
  }) async {
    try {
      // Ensure the user is authenticated
      if (auth.currentUser == null) {
        throw Exception("User not authenticated");
      }

      ShortVideoModel shortVideo = ShortVideoModel(
        caption: caption,
        userId: auth.currentUser!.uid,
        shortVideo: video,
        datePublished: datePublished,
      );

      // Add the short video to Firestore
      await firestore.collection("shorts").add(shortVideo.toMap());
      print("Short video added successfully");
    } catch (e) {
      print("Failed to add short video to Firestore: $e");
    }
  }
}
