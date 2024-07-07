// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:youtube_clone/cores/widgets/flat_button.dart';
import 'package:youtube_clone/features/auth/repository/user_data_service.dart';

final formkey = GlobalKey();

class UsernamePage extends ConsumerStatefulWidget {
  final String displayName;
  final String profilePic;
  final String email;

  const UsernamePage({
    required this.displayName,
    required this.profilePic,
    required this.email,
  });

  @override
  ConsumerState<UsernamePage> createState() => _UsernamePageState();
}

class _UsernamePageState extends ConsumerState<UsernamePage> {
  TextEditingController usernameController = TextEditingController();
  bool isValidate = true;

  // This method validates that no user should have same credential
  void validateUername() async {
    // We get access to the firebasefirestore using this line
    final usersMap = await FirebaseFirestore.instance.collection("user").get();

    // have acces to every single user in the collection "user" and also return user, Also changed it to list
    final users = usersMap.docs.map((user) => user).toList();

    String? targetedUsername;
    for (var user in users) {
      if (usernameController.text == user.data()["username"]) {
        targetedUsername = user.data()["username"];
        isValidate = false;
        setState(() {});
      }
      if (usernameController.text != targetedUsername) {
        isValidate = true;
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 26, horizontal: 14),
              child: Text(
                "Enter the username",
                style: TextStyle(
                  color: Colors.blueGrey,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                child: TextFormField(
                  onChanged: (username) {
                    validateUername();
                  },

                  // It chekc automatically we dont need to chekc the submit button
                  autovalidateMode: AutovalidateMode.always,
                  validator: (username) {
                    return isValidate ? null : "Username Already Exist";
                  },
                  key: formkey,
                  controller: usernameController,
                  decoration: InputDecoration(
                      suffixIcon: isValidate
                          ? Icon(Icons.verified_user_sharp)
                          : Icon(Icons.cancel_presentation_sharp),
                      suffixIconColor: isValidate ? Colors.green : Colors.red,
                      hintText: "Enter username",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.blue)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.blue)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.green))),
                ),
              ),
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 35, horizontal: 15),
                    child: FlatButton(
                        text: "Continue",
                        onPressed: () async {
                          // Add Userdata inisde database
                          isValidate
                              ? await ref
                                  .read(UserDataServiceProvider)
                                  .adduserDataToFirestore(
                                      displayName: widget.displayName,
                                      username: usernameController.text,
                                      email: widget.email,
                                      profilePic: widget.profilePic,
                                      subscriptions: [''],
                                      videos: 0,
                                      userId: "",
                                      description: "",
                                      type: "")
                              : null;
                        },
                        colour:
                            isValidate ? Colors.green : Colors.green.shade100)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
