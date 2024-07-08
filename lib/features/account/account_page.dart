// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:youtube_clone/features/account/items.dart';
import 'package:youtube_clone/features/auth/models/user_model.dart';

class AccountPage extends StatelessWidget {
  final UserModel user;
  const AccountPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.only(top: 8.0),
          child: Column(
            children:  [
              Container( 
                alignment:Alignment.centerLeft,
                child: IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.arrow_back_ios_new)),),
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey,
                backgroundImage: CachedNetworkImageProvider(user.profilePic)
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                user.displayName,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                user.username,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.blueGrey),
              ),
              SizedBox(
                height: 20,
              ),
              Items()
            ],
          ),
        ),
      ),
    );
  }
}
