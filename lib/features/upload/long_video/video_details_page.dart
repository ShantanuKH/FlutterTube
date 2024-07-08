// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'package:youtube_clone/cores/methods.dart';
import 'package:youtube_clone/features/upload/long_video/video_repository.dart';

class VideoDetailsPage extends ConsumerStatefulWidget {
  final File? video;
  VideoDetailsPage({
    this.video,
  });

  @override
  ConsumerState<VideoDetailsPage> createState() => _VideoDetailsPageState();
}

class _VideoDetailsPageState extends ConsumerState<VideoDetailsPage> {
  final titleController = TextEditingController();
  final desciptionController = TextEditingController();
  File? image;
  bool isThumbnailSelected = false;
  String randomNumber = const Uuid().v4();
  String videoIdR = const Uuid().v4();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Enter the title ",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
              const SizedBox(
                height: 7,
              ),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                    hintText: "Enter Title",
                    prefixIcon: Icon(Icons.title),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.blue))),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Enter the description ",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
              const SizedBox(
                height: 7,
              ),
              TextField(
                controller: desciptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                    hintText: "Enter Description",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.blue))),
              ),

              // Select Thumbnail

              Container(
                margin: EdgeInsets.only(top: 17),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(11)),
                child: TextButton(
                  onPressed: () async {
                    image = await pickImage();
                    isThumbnailSelected = true;
                    setState(() {});
                  },
                  child: Text(
                    "Select Thumbnail",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),

              // Display the thumbnail we picked from the gallery on to the screen
              isThumbnailSelected
                  ? Image.file(
                      image!,
                      cacheHeight: 160,
                      cacheWidth: 400,
                    )
                  : const SizedBox(),
              SizedBox(
                height: 10,
              ),
              isThumbnailSelected
                  ? Container(
                      margin: EdgeInsets.only(top: 17),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(11)),
                      child: TextButton(
                        onPressed: () {
                          // Publish the thumbnail
                          String thumbnail =
                              putFileInStorage(image, randomNumber, "image");
                          // Put the video inside the storage nad put urldata path and put inisde database
                          String videoUrl = putFileInStorage(
                              widget.video, randomNumber, "video");

                          ref.watch(longVideoProvider).uuploadVideoToFirestore(
                              videoUrl: widget.video!.path,
                              thumbnail: thumbnail,
                              title: titleController.text,
                              videoId: videoIdR,
                              datePublished: DateTime.now(),
                              userId: FirebaseAuth.instance.currentUser!.uid);
                        },
                        child: Text(
                          "PUBLISH",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
