// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

import 'package:youtube_clone/cores/colors.dart';
import 'package:youtube_clone/cores/screens/error_page.dart';
import 'package:youtube_clone/cores/screens/loader.dart';
import 'package:youtube_clone/cores/widgets/flat_button.dart';
import 'package:youtube_clone/features/auth/models/user_model.dart';
import 'package:youtube_clone/features/auth/provider/user_provider.dart';
import 'package:youtube_clone/features/content/Long_video/parts/posts.dart';
import 'package:youtube_clone/features/content/Long_video/widgets/video_externel_buttons.dart';
import 'package:youtube_clone/features/upload/long_video/videoModel.dart';

class Video extends ConsumerStatefulWidget {
  final VideoModel video;
  const Video({
    Key? key,
    required this.video,
  }) : super(key: key);

  @override
  ConsumerState<Video> createState() => _VideoState();
}

class _VideoState extends ConsumerState<Video> {
  bool isShowIcons = false;
  bool isPlaying = false;

  // This is the inititlaization of the videoplayer which we took from the pub.dev
  VideoPlayerController? _controller;
  @override
  void initState() {
    _controller =
        VideoPlayerController.networkUrl(Uri.parse(widget.video.videoUrl))
          ..initialize().then((_) {
            setState(() {});
          });
    super.initState();
  }

// To play the video

  toogleVideoPLayer() {
    if (_controller!.value.isPlaying) {
      // Pause the Video
      _controller!.pause();
      isPlaying = false;
      setState(() {});
    } else {
      // Play the video
      _controller!.play();
      isPlaying = true;
      setState(() {});
    }
  }

  // To make the video go backward
  goBackward() {
    Duration position = _controller!.value.position;
    position = position - Duration(seconds: 1);
    _controller!.seekTo(position);
  }

  // To make the video go fordward
  goFordward() {
    Duration position = _controller!.value.position;
    position = position + Duration(seconds: 1);
    _controller!.seekTo(position);
  }

  @override
  @override
  Widget build(BuildContext context) {
    final AsyncValue<UserModel> user =
        ref.watch(anyUserDataProvider(widget.video.userId));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(185),
          child: _controller!.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: GestureDetector(
                    onTap: isShowIcons
                        ? () {
                            isShowIcons = false;
                            setState(() {});
                          }
                        : () {
                            isShowIcons = true;
                            setState(() {});
                          },
                    child: Stack(
                      children: [
                        // Display the video
                        VideoPlayer(_controller!),
                        isShowIcons
                            ? Positioned(
                                left: 165,
                                top: 84,
                                child: GestureDetector(
                                  onTap: () {
                                    toogleVideoPLayer();
                                  },
                                  child: SizedBox(
                                    height: 50,
                                    child: isPlaying
                                        ? Image.asset(
                                            "assets/images/pause.png",
                                            color: Colors.white,
                                          )
                                        : Image.asset(
                                            "assets/images/play.png",
                                            color: Colors.white,
                                          ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        isShowIcons
                            ? Positioned(
                                left: 45,
                                top: 84,
                                child: GestureDetector(
                                  onTap: () {
                                    goBackward();
                                  },
                                  child: SizedBox(
                                    height: 50,
                                    child: Image.asset(
                                      "assets/images/go_back_final.png",
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        isShowIcons
                            ? Positioned(
                                left: 270,
                                top: 84,
                                child: GestureDetector(
                                  onTap: () {
                                    goFordward();
                                  },
                                  child: SizedBox(
                                    height: 50,
                                    child: Image.asset(
                                      "assets/images/go ahead final.png",
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        isPlaying
                            ? Align(
                                alignment: Alignment.bottomCenter,
                                child: SizedBox(
                                  height: 8.2,
                                  child: VideoProgressIndicator(
                                    _controller!,
                                    allowScrubbing: true,
                                  ),
                                ),
                              )
                            : SizedBox(),

                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            height: 7.3,
                            child: VideoProgressIndicator(
                              _controller!,
                              allowScrubbing: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(bottom: 90),
                  child: Loader(),
                ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 8),
              child: Text(
                widget.video.title,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 7),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 6, right: 8),
                    child: Text(
                      widget.video.views == 0
                          ? "No Views"
                          : "${widget.video.views} views",
                      style: const TextStyle(
                        fontSize: 13.4,
                        color: Color(0xff5F5F5F),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4, right: 4),
                    child: Text(
                      "5 minutes ago",
                      style: const TextStyle(
                        fontSize: 13.4,
                        color: Color(0xff5F5F5F),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 12,
                top: 9,
                right: 9,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey,
                    backgroundImage:
                        CachedNetworkImageProvider(user.value!.profilePic),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.value!.displayName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          user.value!.subscriptions == 0
                              ? "No Subscriptions "
                              : "${user.value!.subscriptions.length} subscriptions ",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    height: 35,
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: FlatButton(
                        text: "Subscribe",
                        onPressed: () {},
                        colour: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 9,
                top: 10.5,
                right: 9,
              ),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 6,
                          ),
                          decoration: const BoxDecoration(
                            color: softBlueGreyBackGround,
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  Icons.thumb_up,
                                  size: 15.5,
                                ),
                              ),
                              const SizedBox(width: 20),
                              const Icon(
                                Icons.thumb_down,
                                size: 15.5,
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 9, right: 9),
                          child: VideoExtraButton(
                            text: "Share",
                            iconData: Icons.share,
                          ),
                        ),
                        const VideoExtraButton(
                          text: "Remix",
                          iconData: Icons.analytics_outlined,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 9, right: 9),
                          child: VideoExtraButton(
                            text: "Download",
                            iconData: Icons.download,
                          ),
                        ),
                      ],
                    ),
                  ],
                  
                ),
              ),
            ),
                                // "where" is used to specify that this specific video that is playing should not display in the list
       Expanded(
         child: StreamBuilder(
            stream: FirebaseFirestore.instance
                                .collection("videos")
                                .where("videoId",
                                    isNotEqualTo: widget.video.videoId)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData || snapshot.data == null) {
                                return ErrorPage();
                              } else if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Loader();
                              }
         
                              // Here, we have videomaop, we have to convert it into the videoModel and then convert it into list
                              final videosMap = snapshot.data!.docs;
                              final videos = videosMap
                                  .map(
                                    (video) => VideoModel.fromMap(video.data()),
                                  )
                                  .toList();
         
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    return Posts(
                                      video: videos[index],
                                    );
                                  });
                            }),
       ),
                 
          ],
        ),
      ),
    );
  }
}
