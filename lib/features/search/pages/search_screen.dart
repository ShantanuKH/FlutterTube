import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/features/auth/models/user_model.dart';
import 'package:youtube_clone/features/content/Long_video/parts/posts.dart';
import 'package:youtube_clone/features/search/providers/search_provider.dart';
import 'package:youtube_clone/features/search/widget/search_channel_tile.dart';
import 'package:youtube_clone/features/upload/long_video/videoModel.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  List foundItems = [];

  Future<void> filterList(String keyWordSelected) async {
    List<UserModel> users = await ref.watch(allChannelsProvider);

    List result = [];

    final foundChannels = users.where((user) {
      return user.displayName
          .toString()
          .toLowerCase()
          .contains(keyWordSelected);
    }).toList();

    // addAll means adding one list into another list
    result.addAll(foundChannels);

     List<VideoModel> videos = await ref.watch(allVideosProvider);

    final foundVideos = videos.where((video) {
      return video.title
          .toString()
          .toLowerCase()
          .contains(keyWordSelected);
    }).toList();

    result.addAll(foundVideos);

    // This will shuffle the channel and videos
    setState(() {
      result.shuffle();
      foundItems = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_back_ios_new_sharp),
                  ),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.sizeOf(context).width / 1.2,
                    child: TextFormField(
                      onChanged: (value) async {
                        await filterList(value);
                      },
                      decoration: InputDecoration(
                          suffixIcon: Container(
                              width: 2,
                              margin: EdgeInsets.only(right: 2),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      bottomRight: Radius.circular(30))),
                              child: const Icon(Icons.search_sharp)),
                          hintText: "Search Youtube... ",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blueGrey,
                              ),
                              borderRadius: BorderRadius.circular(30))),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: foundItems.length,
                    itemBuilder: (context, index) {
                      List<Widget> itemsWidget = [];
                      final selectedItems = foundItems[index];

                      if (selectedItems.type == "video") {
                        itemsWidget.add(Posts(video: selectedItems));
                      }  if (selectedItems.type == "user") {
                        itemsWidget.add(
                          SearchChannelTile(
                            user: selectedItems,
                          ),
                        );
                      }  if (foundItems.isEmpty) {
                        return Container(child: Text("No such field found"));
                      }

                      return itemsWidget[0];
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
