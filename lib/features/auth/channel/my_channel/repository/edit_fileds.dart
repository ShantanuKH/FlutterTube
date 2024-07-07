// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final editSettingsProvider = Provider((ref) => EditSettingsFields(
    firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance));

class EditSettingsFields {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  EditSettingsFields({
    required this.firestore,
    required this.auth,
  });

  editDisplayName(displayName) async {
    firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .update({"displayName": displayName});
  }

  editusername(username) async {
    firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .update({"username": username});
  }

  editDescription(description) async {
    firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .update({"description": description});
  }
}
