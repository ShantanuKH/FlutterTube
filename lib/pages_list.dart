import 'package:flutter/material.dart';
import 'package:youtube_clone/features/content/Long_video/long_video_screen.dart';
import 'package:youtube_clone/features/content/shortVideo/pages/short_video_page.dart';

List pages = [
  LongVideoScreen(),
  ShortVideoPage(),
   Center(
    child: Text("Shorts"),
  ),
   Center(
    child: Text("Upload"),
  ),
   Center(
    child: Text("Search"),
  ),
   Center(
    child: Text("Log Out"),
  ),

];
