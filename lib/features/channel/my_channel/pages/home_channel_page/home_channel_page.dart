import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/cores/screens/error_page.dart';
import 'package:youtube_clone/cores/screens/loader.dart';
import 'package:youtube_clone/features/channel/provider/channel_provider.dart';
import 'package:youtube_clone/features/content/Long_video/parts/posts.dart';

class HomeChannelPage extends StatelessWidget {
  const HomeChannelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, ref, child) {
        return ref
            .watch(eachChannelVideosProvider(
                FirebaseAuth.instance.currentUser!.uid))
            .when(
              data: (videos) => Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.sizeOf(context).height * 0.2),
                child: Column(
                  children: [
                    if (videos.isEmpty)
                      Center(
                        child: Text(
                          "No Videos",
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    else
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: videos.length,
                          itemBuilder: (context, index) {
                            return Posts(video: videos[index]);
                          },
                        ),
                      ),
                  ],
                ),
              ),
              error: (error, stackTrace) => ErrorPage(),
              loading: () => Loader(),
            );
      }),
    );
  }
}
