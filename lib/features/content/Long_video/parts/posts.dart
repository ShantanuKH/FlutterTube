import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.only(bottom: 10),
          child: GestureDetector(
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Video(
                            video: video,
                          )));
              await FirebaseFirestore.instance
                  .collection("videos")
                  .doc(video.videoId)
                  .update({"views": FieldValue.increment(1)});
            },
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: "${video.thumbnail}",
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
                      Text("a moment ago",
                          style: TextStyle(color: Colors.blueGrey))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
