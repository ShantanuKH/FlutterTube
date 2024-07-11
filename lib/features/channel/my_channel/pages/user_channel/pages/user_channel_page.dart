import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:youtube_clone/cores/screens/error_page.dart';
import 'package:youtube_clone/cores/screens/loader.dart';
import 'package:youtube_clone/cores/widgets/flat_button.dart';
import 'package:youtube_clone/features/auth/provider/user_provider.dart';
import 'package:youtube_clone/features/channel/provider/channel_provider.dart';
import 'package:youtube_clone/features/content/Long_video/parts/posts.dart';

class UserChannelPage extends StatefulWidget {
  final String userId;

  const UserChannelPage({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<UserChannelPage> createState() => _UserChannelPageState();
}

class _UserChannelPageState extends State<UserChannelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Consumer(builder: (context, ref, child) {
                      return ref.watch(anyUserDataProvider(widget.userId)).when(
                        data: (user) => Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Image.asset("assets/images/flutter background.png"),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 17),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 38,
                                    backgroundColor: Colors.grey,
                                    backgroundImage: CachedNetworkImageProvider(user.profilePic),
                                  ),
                                  SizedBox(width: 23),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user.displayName,
                                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        user.username,
                                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.blueGrey),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.blueGrey),
                                          children: [
                                            TextSpan(
                                              text: "${user.subscriptions.length} subscriptions • ",
                                            ),
                                            TextSpan(
                                              text: "${user.videos} Videos",
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 20),
                              child: FlatButton(
                                text: "SUBSCRIBE",
                                onPressed: () {},
                                colour: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),
                            user.videos == 0
                                ? Center(
                                    child: Text(
                                      "${user.displayName}'s Videos",
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : Center(child: Text("No Videos"))
                                
                                
                                
                          ],
                        ),
                        error: (error, stackTrace) => ErrorPage(),
                        loading: () => Loader(),
                      );
                    }),

                    // Second Consumer to show all the videos in the channel
                    Consumer(builder: (context, ref, child) {
                      return ref
                          .watch(eachChannelVideosProvider(widget.userId))
                          .when(
                            data: (videos) => Padding(
                              padding: EdgeInsets.only(top: 20, left: 8.0, right: 8.0),
                              child: videos.isEmpty
                                  ? Center(
                                      child: Text(
                                        "No Videos",
                                        style: TextStyle(
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  : GridView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 5,
                                        mainAxisSpacing: 8,
                                        childAspectRatio: 0.8,
                                      ),
                                      itemCount: videos.length,
                                      itemBuilder: (context, index) {
                                        return Posts(video: videos[index]);
                                      },
                                    ),
                            ),
                            error: (error, stackTrace) => ErrorPage(),
                            loading: () => Loader(),
                          );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
