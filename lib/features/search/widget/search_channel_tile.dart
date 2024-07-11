// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:youtube_clone/cores/widgets/flat_button.dart';
import 'package:youtube_clone/features/channel/my_channel/pages/user_channel/pages/user_channel_page.dart';
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
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UserChannelPage(userId: user.userId)));
        },
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: Colors.grey[300],
                backgroundImage: CachedNetworkImageProvider(user.profilePic),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.displayName,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      user.username,
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      user.subscriptions.toString() == '0'
                          ?  "${user.subscriptions} Subscribers"
                          : "No Subscribers",
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "SUBSCRIBE",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
