import 'package:flutter/material.dart';
import 'package:youtube_clone/features/content/Long_video/long_video_screen.dart';
import 'package:youtube_clone/features/content/shortVideo/pages/short_video_page.dart';
import 'package:youtube_clone/features/search/pages/search_screen.dart';

List pages = [
  SearchScreen(),
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
