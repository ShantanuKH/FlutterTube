// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:youtube_clone/cores/widgets/flat_button.dart';
import 'package:youtube_clone/features/upload/short_video/repository/short_video_repository.dart';

class ShortVideoDetailsPage extends ConsumerStatefulWidget {
  final File video;
  const ShortVideoDetailsPage({
    Key? key,
    required this.video,
  }) : super(key: key);
  @override
  ConsumerState<ShortVideoDetailsPage> createState() =>
      _ShortVideoDetailsPageState();
}

class _ShortVideoDetailsPageState extends ConsumerState<ShortVideoDetailsPage> {
  final captionController = TextEditingController();
  final DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Video Details",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: captionController,
                decoration: InputDecoration(
                    hintText: "Enter Caption",
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(15))),
              ),
              Spacer(),
              FlatButton(
                  text: "PUBLISH",
                  onPressed: ()async {
                    await ref.watch(shortVideoProvider).addShortVideoToFirestore(
                        caption: captionController.text,
                        video: widget.video.path,
                        datePublished: date);
                  },
                  colour: Colors.green)
            ],
          ),
        ),
      ),
    );
  }
}
