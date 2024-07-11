// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:youtube_clone/features/account/items.dart';
import 'package:youtube_clone/features/auth/models/user_model.dart';
import 'package:youtube_clone/features/channel/my_channel/pages/my_channel_screen.dart';

class AccountPage extends StatelessWidget {
  final UserModel user;
  const AccountPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 8.0,bottom: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyChannelScreen()));
            },
            child: Column(
             
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios_new)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:20.0),
                  child: Row(
                    
                    children: [
                      CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey,
                          backgroundImage:
                              CachedNetworkImageProvider(user.profilePic)),
                  
                  
                        SizedBox(width: 20,),
                        Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                   Text(
                    "Manage Your Google Account",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.lightBlue),
                  ),
                          ],
                        )
                    ],
                  ),
                ),
               
               
                SizedBox(
                  height: 20,
                ),
                Items(),


                Text("Privacy Policy .  Terms of Services", style: TextStyle(color: Colors.blueGrey,
                fontSize: 13.5),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
