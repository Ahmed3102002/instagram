import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImageProvider extends ChangeNotifier {
  File? userImage;
  File? get getUserImage => userImage;
  void get setUserImageFromCamera async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    File selectedImage = File(image!.path);

    userImage = selectedImage;
    notifyListeners();
  }

  void get setUserImageFromGallery async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    File selectedImage = File(image!.path);
    userImage = selectedImage;
    notifyListeners();
  }

  void get removeUserImage {
    if (userImage != null) {
      userImage = null;
    }
    notifyListeners();
  }
}
