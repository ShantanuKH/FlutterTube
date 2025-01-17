import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/cores/screens/error_page.dart';
import 'package:youtube_clone/cores/screens/loader.dart';
import 'package:youtube_clone/features/content/Long_video/parts/posts.dart';
import 'package:youtube_clone/features/upload/long_video/videoModel.dart';

class LongVideoScreen extends StatelessWidget {
  const LongVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseFirestore.instance.collection("videos").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return ErrorPage();
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Loader();
        }
        final videoMaps = snapshot.data!.docs;
        final videos =  videoMaps.map((video) {
          return VideoModel.fromMap(video.data());
        }).toList();

        return ListView.builder(
            itemCount: videos.length,
            itemBuilder: (context, index) {
              return Posts(
                video: videos[index],
              );
            });
      },
    ));
  }
}
