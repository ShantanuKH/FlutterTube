import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/cores/screens/error_page.dart';
import 'package:youtube_clone/cores/screens/loader.dart';
import 'package:youtube_clone/features/auth/channel/my_channel/parts/buttons.dart';
import 'package:youtube_clone/features/auth/channel/my_channel/parts/tab_bar.dart';
import 'package:youtube_clone/features/auth/channel/my_channel/parts/tab_bar_view.dart';
import 'package:youtube_clone/features/auth/channel/my_channel/parts/top_header.dart';
import 'package:youtube_clone/features/auth/models/user_model.dart';
import 'package:youtube_clone/features/auth/provider/user_provider.dart';

class MyChannelScreen extends ConsumerWidget {
  
  bool isScrollable = false;

  MyChannelScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(currentUserProvider).when(
        data: (currentUser) =>  DefaultTabController(
              length: 7,
              child: Scaffold(
                body: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        // Top Header
                        TopHeader(user: currentUser,),

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
            ),
        error: (error, StackTrace) => const ErrorPage(),
        loading: () => const Loader());
  }
}
