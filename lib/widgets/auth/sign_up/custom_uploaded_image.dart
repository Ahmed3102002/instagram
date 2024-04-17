import 'dart:io';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/providers/video_provider.dart';
import 'package:social/utils/methods/app_methods.dart';
import 'package:social/widgets/auth/sign_up/custom_show_chooses_for_image.dart';
import 'package:video_player/video_player.dart';

class CustomUpLoadedMedia extends StatelessWidget {
  const CustomUpLoadedMedia({
    super.key,
    required this.mediaProvider,
  });

  final File? mediaProvider;

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).dividerColor;
    final VideoProvider videoProvider = Provider.of<VideoProvider>(context);

    return Center(
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Material(
            elevation: 5,
            borderRadius: AppMethods.boderRadius(radius: 50),
            shadowColor: color,
            child: ClipRRect(
              borderRadius: AppMethods.boderRadius(radius: 50),
              child: mediaProvider == null
                  ? FancyShimmerImage(
                      height: MediaQuery.sizeOf(context).height * 0.4,
                      width: MediaQuery.sizeOf(context).height * 0.4,
                      imageUrl:
                          'https://assets-global.website-files.com/5babb9f91ab233ff5f53ce10/608fb6511982b87e6f4b46ed_Untitled-design-20-1.jpeg',
                    )
                  : videoProvider.getIsVideo
                      ? SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.4,
                          width: MediaQuery.sizeOf(context).height * 0.4,
                          child:
                              VideoPlayer(videoProvider.videoPlayerController))
                      : Image.file(
                          fit: BoxFit.fill,
                          height: MediaQuery.sizeOf(context).height * 0.4,
                          width: MediaQuery.sizeOf(context).height * 0.4,
                          mediaProvider!,
                        ),
            ),
          ),
          Material(
            elevation: 5,
            borderRadius: const BorderRadius.all(
              Radius.circular(50),
            ),
            color: Theme.of(context).dividerColor,
            child: IconButton(
              color: Theme.of(context).scaffoldBackgroundColor,
              onPressed: () {
                showAdaptiveDialog(
                    context: context,
                    builder: (context) {
                      return const CustomShowChoosesForImage();
                    });
              },
              icon: Icon(mediaProvider == null
                  ? Icons.upload_outlined
                  : Icons.image_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
