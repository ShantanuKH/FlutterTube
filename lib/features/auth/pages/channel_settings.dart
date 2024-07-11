import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/cores/screens/error_page.dart';
import 'package:youtube_clone/cores/screens/loader.dart';
import 'package:youtube_clone/features/channel/my_channel/repository/edit_fileds.dart';
import 'package:youtube_clone/features/channel/my_channel/wigdets/edit_setting_dialog.dart';
import 'package:youtube_clone/features/channel/my_channel/wigdets/setting_field_item.dart';
import 'package:youtube_clone/features/auth/provider/user_provider.dart';

class MyChannelSettings extends ConsumerStatefulWidget {
  const MyChannelSettings({super.key});

  @override
  ConsumerState<MyChannelSettings> createState() => _MyChannelSettingsState();
}

class _MyChannelSettingsState extends ConsumerState<MyChannelSettings> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return ref.watch(currentUserProvider).when(
        data: (currentUser) => Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                              height: 170,
                              width: MediaQuery.of(context).size.width,
                              child: Image.asset(
                                "assets/images/flutter background.png",
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.low,
                              )),
                          Container(
                            height: MediaQuery.of(context).size.height / 4.5,
                            child: Center(
                              child: CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.blueGrey,
                                backgroundImage: CachedNetworkImageProvider(currentUser.profilePic),
                              ),
                            ),
                          ),
                          Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(top: 15, right: 10),
                              child: Image.asset(
                                "assets/icons/camera.png",
                                height: 20,
                                color: Colors.white,
                              ))
                        ],
                      ),

                      // Second Part
                      const SizedBox(
                        height: 15,
                      ),
                      SettingsItem(
                            identifier: "Name",
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => SettingsDialog(
                                  identifier: "Edit Display Name",
                                  onSave: (name) {
                                    ref.watch(editSettingsProvider).editDisplayName(name);
                                  },
                                ),
                              );
                            },
                            value: currentUser.displayName,
                          ),

                      const SizedBox(
                        height: 15,
                      ),
                      SettingsItem(
                          identifier: "Handle",
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => SettingsDialog(
                                  identifier: "Edit Username",
                                  onSave: (username) {
                                    ref.watch(editSettingsProvider).editusername(username);
                                  },
                                ),
                              );
                          },
                          value: currentUser.username),
                      const SizedBox(
                        height: 15,
                      ),
                      SettingsItem(
                          identifier: "Description",
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => SettingsDialog(
                                  identifier: "Edit Description",
                                  onSave: (description) {
                                    ref.watch(editSettingsProvider).editDescription(description);
                                  },
                                ),
                              );
                          },
                          value: currentUser.description),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Keep all my subscriber private"),
                            Switch(
                              value: isSwitched,
                              onChanged: (value) {
                                isSwitched = value;
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),

                      const Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10, top: 25),
                        child: const Text(
                          "Changes made on your names and profile pictures are visible only to youtube and not other Google Services",
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
        error: (error, stacktree) => ErrorPage(),
        loading: () => Loader());
  }
}
