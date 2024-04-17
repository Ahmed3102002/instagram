import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/models/user_model.dart';
import 'package:social/pages/inner_pages/add_story_page.dart';
import 'package:social/pages/inner_pages/view_story_page.dart';
import 'package:social/providers/user_data_provider.dart';
import 'package:social/providers/video_provider.dart';
import 'package:social/utils/constants.dart';
import 'package:social/utils/methods/app_methods.dart';
import 'package:social/widgets/home/custom_user_image.dart';

class AddCurrentUserStory extends StatelessWidget {
  const AddCurrentUserStory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final VideoProvider videoProvider = Provider.of<VideoProvider>(context);

    final UserModel userInfo =
        Provider.of<UserDataProvider>(context).getUserData;
    Color color = Theme.of(context).dividerColor;
    return Stack(
      children: [
        InkWell(
          onTap: () async {
            if (userInfo.stories.isNotEmpty) {
              await Navigator.pushNamed(context, ViewStoryPage.routeName,
                  arguments: userInfo.stories);
            } else {
              log('empty');
            }
          },
          child: CustomUserImage(
            color: userInfo.stories.isEmpty ? color : Colors.pink,
            image: userInfo.imageUrl,
            radius: 40,
          ),
        ),
        if (userInfo.id == FirebaseAuth.instance.currentUser!.uid)
          Positioned(
            bottom: -MediaQuery.of(context).size.width * 0.03, // -14,
            right: -MediaQuery.of(context).size.width * 0.03,
            child: PopupMenuButton<String>(
                offset: const Offset(1, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: AppMethods.boderRadius(radius: 20),
                ),
                position: PopupMenuPosition.under,
                icon: const Icon(
                  Icons.add_circle,
                  color: Colors.blue,
                ),
                onSelected: (value) {
                  if (value == 'video') {
                    videoProvider.setIsVideo;
                  }
                  Navigator.pushNamed(context, AddStoryPage.routeName);
                },
                itemBuilder: (context) {
                  return ConstantVariables.list;
                }),
          ),
      ],
    );
  }
}
