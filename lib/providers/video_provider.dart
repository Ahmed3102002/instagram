import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class VideoProvider extends ChangeNotifier {
  late VideoPlayerController videoPlayerController;
  bool isVideo = false;
  bool get getIsVideo => isVideo;
  void get setIsVideo {
    isVideo = !isVideo;
    notifyListeners();
  }

  File? video;
  File? get getVideo => video;
  void get setVideoFromCamera async {
    XFile? newVideo = await ImagePicker().pickVideo(source: ImageSource.camera);
    File selectedVideo = File(newVideo!.path);
    video = selectedVideo;
    videoPlayerController = VideoPlayerController.file(video!);

    videoPlayerController.initialize();
    videoPlayerController.play();
    notifyListeners();
  }

  void get setVideoFromGallery async {
    XFile? newVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    File selectedVideo = File(newVideo!.path);
    video = selectedVideo;
    videoPlayerController = VideoPlayerController.file(video!);
    videoPlayerController.initialize();
    videoPlayerController.play();
    notifyListeners();
  }

  void get removeVideo {
    if (video != null) {
      video = null;
      videoPlayerController.pause();
    }
    notifyListeners();
  }
}
