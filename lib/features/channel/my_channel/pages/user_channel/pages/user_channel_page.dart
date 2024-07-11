// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
          children: [
            Consumer(builder: (context, ref, child) {
              return ref.watch(anyUserDataProvider(widget.userId)).when(
                  data: (user) => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.asset("assets/images/flutter background.png"),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 17),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 38,
                                  backgroundColor: Colors.grey,
                                  backgroundImage: CachedNetworkImageProvider(
                                      user.profilePic),
                                ),
                                SizedBox(
                                  width: 23,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(user.displayName,
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold)),
                                    Text(user.username,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blueGrey)),
                                    RichText(
                                        text: TextSpan(
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.blueGrey),
                                      children: [
                                        TextSpan(
                                          text:
                                              "${user.subscriptions.length} subscriptions • ",
                                        ),
                                        TextSpan(
                                          text: "${user.videos} Videos",
                                        )
                                      ],
                                    ))
                                  ],
                                )
                              ],
                            ),
                          ),
                         
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 20),
                            child: FlatButton(
                                text: "SUBSCRIBE",
                                onPressed: () {},
                                colour: Colors.black),
                          ),
                          SizedBox(height: 10,),
                           user.videos==0? Center(child: Text("No Video")):Center(
                      child: Text("",
                             style: TextStyle(
                              fontSize: 2,
                              fontWeight: FontWeight.bold
                             ),
                             ),
                           ),
                        ],
                      ),
                  error: (error, stackTrace) => ErrorPage(),
                  loading: () => Loader());
            }),

            // Second Consumer to show all the videos in the channel

            Consumer(builder: (context, ref, child) {
              return ref.watch(eachChannelVideosProvider(widget.userId)).when(
                  data: (videos) => Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.sizeOf(context).height * 0.2),
                      child: SizedBox(
                        height: 80,
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8,
                                    mainAxisExtent: 8),
                            itemCount: videos.length,
                            itemBuilder: (context, index) {
                              if (videos.isNotEmpty) {
                                return Posts(video: videos[index]);
                              }
                              return Container(
                                child: Text("No Videos"),
                              );
                            }),
                      )),
                  error: (error, stackTrace) => ErrorPage(),
                  loading: () => Loader());
            })
          ],
        ),
      ),
    );
  }
}
