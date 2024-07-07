// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/features/auth/models/user_model.dart';

// Using the provider we will be able to handle the set
final UserDataServiceProvider = Provider(
  (ref) => UserDataService(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

// To add the user data to the firebase firestore
class UserDataService {
  FirebaseAuth auth;
  FirebaseFirestore firestore;
  UserDataService({
    required this.auth,
    required this.firestore,
  });

  adduserDataToFirestore({
    required String displayName,
    required String username,
    required String email,
    required String profilePic,
    required List<String> subscriptions,
    required int videos,
    required String userId,
    required String description,
    required String type,
  }) async {
    UserModel user = UserModel(
        displayName: displayName,
        username: username,
        email: email,
        profilePic: profilePic,
        subscriptions: [],
        videos: 0,
        userId: auth.currentUser!.uid,
        description: description,
        type: "user");

    // We have user model, Now creating a collection to add the user data to the collection

    await firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .set(user.toMap());
  }

// To fetch the data form the firestore

  Future<UserModel>fetchCurrentUserData() async {
    final currentUserMap =
        await firestore.collection("users").doc(auth.currentUser!.uid).get();

    // Now, We have to convert the currentUserMap into the usermodel
    UserModel user = UserModel.fromMap(currentUserMap.data()!);
    return user;
  }
}
