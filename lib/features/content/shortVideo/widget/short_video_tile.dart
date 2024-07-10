// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:youtube_clone/features/upload/short_video/model/short_video_model.dart';

class ShortVideoTile extends StatefulWidget {
  final ShortVideoModel shortVideo;
  const ShortVideoTile({
    Key? key,
    required this.shortVideo,
  }) : super(key: key);

  @override
  State<ShortVideoTile> createState() => _ShortVideoTileState();
}

class _ShortVideoTileState extends State<ShortVideoTile> {
  VideoPlayerController? shortVideoController;

  @override
  void initState() {
    super.initState();
    shortVideoController = VideoPlayerController.networkUrl(
        Uri.parse(widget.shortVideo.shortVideo))
      ..initialize().then((_) {
        
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Shorts")
      ),
      body: Padding(
      
          padding: const EdgeInsets.only(top: 20),
          child: shortVideoController!.value.isInitialized
              ? Column(
                  children: [
                    
                    GestureDetector(
                        onTap: () {
                          if (!shortVideoController!.value.isPlaying) {
                            shortVideoController!.play();
                          } else {
                            shortVideoController!.pause();
                          }
                        },
                        child: AspectRatio(
                          aspectRatio: 11 / 20,
                          child: VideoPlayer(shortVideoController!),
                        )),
                    Material(
                      borderRadius: BorderRadius.circular(20),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.shortVideo.caption,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(timeago.format(widget.shortVideo.datePublished))
                          ],
                        ),
                      ),
                    )
                  ],
                )
              : SizedBox(
                  height: MediaQuery.sizeOf(context).height,
                  child: Center(child: Text("No videos 😔")))),
    );
  }
}
