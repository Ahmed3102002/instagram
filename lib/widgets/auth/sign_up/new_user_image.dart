import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/providers/user_image_provider.dart';
import 'package:social/widgets/auth/sign_up/custom_uploaded_image.dart';

class NewUserImage extends StatelessWidget {
  const NewUserImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final UserImageProvider userImageProvider =
        Provider.of<UserImageProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.sizeOf(context).height * 0.02,
      ),
      child: CustomUpLoadedMedia(
        mediaProvider: userImageProvider.getUserImage,
      ),
    );
  }
}
