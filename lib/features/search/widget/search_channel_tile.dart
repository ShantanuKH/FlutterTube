// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:youtube_clone/cores/widgets/flat_button.dart';
import 'package:youtube_clone/features/auth/models/user_model.dart';

class SearchChannelTile extends StatelessWidget {
  final UserModel user;
  const SearchChannelTile({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.grey,
            backgroundImage: CachedNetworkImageProvider(user.profilePic),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0, right: 8),
            child: Column(
              children: [
                Text(
                  user.displayName,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                ),
                Text(
                  user.username,
                  style: TextStyle(color: Colors.blueGrey, fontSize: 13),
                ),

                
                user.subscriptions.toString()==0 ? Text(
                 user.subscriptions.toString(),
                  style: TextStyle(color: Colors.blueGrey, fontSize: 13),
                ):
                Text(
                 "No Subscribers",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 13),
                ),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                    height: 40,
                    width: 120,
                    child: FlatButton(
                        text: "SUBSCRIBE",
                        onPressed: () {},
                        colour: Colors.black))
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
