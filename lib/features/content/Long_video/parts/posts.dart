// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/features/auth/models/user_model.dart';
import 'package:youtube_clone/features/auth/provider/user_provider.dart';
import 'package:youtube_clone/features/content/Long_video/parts/video.dart';

import 'package:youtube_clone/features/upload/long_video/videoModel.dart';

class Posts extends ConsumerWidget {
  final VideoModel video;

  const Posts({
    Key? key,
    required this.video,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<UserModel> userModel =
        ref.watch(anyUserDataProvider(video.userId));

    // whenData will just return the data and will not tell loading and all stuff
    final user = userModel.whenData((user) => user);

    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Video()));
        },
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl:
                  "https://www.shutterstock.com/image-illustration/abstract-wave-technology-background-blue-260nw-2152448863.jpg",
            ),
            Padding(
              padding: EdgeInsets.only(top: 5, left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey,
                    backgroundImage:
                        CachedNetworkImageProvider(user.value!.profilePic),
                  ),
                  SizedBox(
                    width: 13,
                  ),
                  Text(
                    video.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.more_vert_sharp))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.sizeOf(context).width * 0.15),
              child: Row(
                children: [
                  Text(
                    "${user.value!.displayName}• ",
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                  Text(
                      video.views == 0
                          ? "No Views • "
                          : " ${video.views.toString()} views • ",
                      style: TextStyle(color: Colors.blueGrey)),
                  Text("a moment ago", style: TextStyle(color: Colors.blueGrey))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
