import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: TabBar(
        isScrollable: true,
        labelStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorPadding: const EdgeInsets.only(top: 13),
        tabs: const [
          Text("Home"),
          Text("Videos"),
          Text("Shorts"),
          Text("Community"),
          Text("Playlist"),
          Text("Channel"),
          Text("About"),
        ],
      ),
    );
  }
}
