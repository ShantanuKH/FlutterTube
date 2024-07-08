import 'dart:io';

import 'package:flutter/material.dart';
import 'package:youtube_clone/cores/methods.dart';

class VideoDetailsPage extends StatefulWidget {
  const VideoDetailsPage({super.key});

  @override
  State<VideoDetailsPage> createState() => _VideoDetailsPageState();
}

class _VideoDetailsPageState extends State<VideoDetailsPage> {
  final titleController = TextEditingController();
  final desciptionController = TextEditingController();
  File? image;
  bool isThumbnailSelected = false;
  

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
                  onPressed: ()async {
                    image = await pickImage();
                    isThumbnailSelected = true;
                    setState(() {
                      
                    });
                  },
                  child: Text(
                    "Select Thumbnail",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 12,),

              // Display the thumbnail we picked from the gallery on to the screen 
              isThumbnailSelected ? Image.file(image!, cacheHeight: 160,cacheWidth: 400,):const SizedBox(),
              SizedBox(height: 10,),
                isThumbnailSelected ? Container(
                      margin: EdgeInsets.only(top: 17),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(11)),
                      child: TextButton(
                        onPressed: () {},
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
