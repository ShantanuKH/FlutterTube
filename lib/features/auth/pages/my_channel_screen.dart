import 'package:flutter/material.dart';
import 'package:youtube_clone/features/auth/channel/my_channel/parts/buttons.dart';
import 'package:youtube_clone/features/auth/channel/my_channel/parts/tab_bar.dart';
import 'package:youtube_clone/features/auth/channel/my_channel/parts/tab_bar_view.dart';
import 'package:youtube_clone/features/auth/channel/my_channel/parts/top_header.dart';

class MyChannelScreen extends StatelessWidget {
  bool isScrollable = false;

  MyChannelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 7,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              children: [
                // Top Header
                TopHeader(),

                Text("More about the channel"),

                // Buttons on the Page
                Buttons(),

                // Create a tab bar
                const CustomTabBar(),

                const TabPages()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
