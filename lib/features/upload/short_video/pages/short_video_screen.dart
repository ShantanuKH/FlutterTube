// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:flutter/material.dart';
import 'package:video_editor/video_editor.dart';
import 'package:youtube_clone/cores/methods.dart';

import 'package:youtube_clone/features/upload/short_video/model/short_video_model.dart';
import 'package:youtube_clone/features/upload/short_video/pages/short_video_details.dart';
import 'package:youtube_clone/features/upload/short_video/widgets/trim_slinder.dart';

class ShortVideoScreen extends StatefulWidget {
  final File shortVideo;
  const ShortVideoScreen({
    Key? key,
    required this.shortVideo,
  }) : super(key: key);

  @override
  State<ShortVideoScreen> createState() => _ShortVideoScreenState();
}

class _ShortVideoScreenState extends State<ShortVideoScreen> {
  // We are initializing the editor controller here,We can refer to  documentation

  VideoEditorController? editorController;

  // ValueNotifier is used to display in the UI, diplay real value(Exporting process say) in UI
  final isExporting = ValueNotifier<bool>(false);
  final exportingProgress = ValueNotifier<double>(0.0);

  @override
  void initState() {
    editorController = VideoEditorController.file(
      // To have the actual video
      widget.shortVideo,
      minDuration: const Duration(seconds: 2),
      maxDuration: const Duration(seconds: 60),
    );
    editorController!
        .initialize(aspectRatio:4/3.6 )
        .then((_) => setState(() {}));
  }

// To export the video
  Future <void> exportVideo() async {
    isExporting.value = true;
    final config = VideoFFmpegVideoEditorConfig(editorController!);
    final execute = await config.getExecuteConfig();
    final String command = execute.command;

    // This will actually export the video
    // This all parameters are provided by the package itself
    FFmpegKit.executeAsync(
      command,
      (session) async {
        // this return code will tell if the conditions are met or not or say the export is sucessfull or not
        final ReturnCode? code = await session.getReturnCode();
        if (ReturnCode.isSuccess(code)) {
          // Export the video
          isExporting.value = false;
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ShortVideoDetailsPage()));
        } else {
          // Show Error
          showErrorSnackBar("Failed, video cannot be exported", context);
        }
      },
      null,
      (status) {
        // This will show the actual calue of the progress
        exportingProgress.value =
            config.getFFmpegProgress(status.getTime().toInt());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.only(top: 20),

            // If the editing controler is initialized then only we will show all this
            child: editorController!.initialized
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.white,
                                )),
                            Text(
                              "Edit Your Video",
                              style: TextStyle(color: Colors.white),
                            ),
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.blueGrey,
                            )
                          ],
                        ),
                      ),
                      Spacer(),

                      // This class from the video_editor displays the video
                      CropGridViewer.preview(controller: editorController!),
                      Spacer(),
                      MyTrimSlider(controller: editorController!, height: 45),

                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18)),
                          child: TextButton(
                            onPressed: exportVideo,
                            child: Text("DONE"),
                          ),
                        ),
                      )
                    ],
                  )
                : const Center(child: Text("Data is not initialized yet !"))),
      ),
    );
  }
}
