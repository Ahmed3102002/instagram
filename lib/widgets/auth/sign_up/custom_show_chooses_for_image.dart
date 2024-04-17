import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/providers/user_image_provider.dart';
import 'package:social/providers/video_provider.dart';
import 'package:social/widgets/others/custom_text.dart';

class CustomShowChoosesForImage extends StatelessWidget {
  const CustomShowChoosesForImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color fontColor = Theme.of(context).dividerColor;
    final UserImageProvider userImageProvider =
        Provider.of<UserImageProvider>(context);
    final VideoProvider videoProvider = Provider.of<VideoProvider>(context);
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Column(
        children: [
          TextButton.icon(
            icon: Icon(
              Icons.camera_alt_outlined,
              color: fontColor,
            ),
            onPressed: () async {
              videoProvider.getIsVideo
                  ? videoProvider.setVideoFromCamera
                  : userImageProvider.setUserImageFromCamera;
            },
            label: CustomText(
              title: 'Choose From Camera',
              color: fontColor,
            ),
          ),
          TextButton.icon(
            icon: Icon(
              Icons.browse_gallery_outlined,
              color: fontColor,
            ),
            onPressed: () async {
              videoProvider.getIsVideo
                  ? videoProvider.setVideoFromGallery
                  : userImageProvider.setUserImageFromGallery;
            },
            label: CustomText(
              title: 'Choose From Gallery',
              color: fontColor,
            ),
          ),
          TextButton.icon(
            icon: Icon(
              Icons.delete_outline_outlined,
              color: fontColor,
            ),
            onPressed: () async {
              videoProvider.getIsVideo
                  ? videoProvider.removeVideo
                  : userImageProvider.removeUserImage;
            },
            label: CustomText(
              title: 'Remove Current media',
              color: fontColor,
            ),
          ),
        ],
      ),
    );
  }
}
