import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:social/providers/is_loading_provider.dart';
import 'package:social/providers/user_data_provider.dart';
import 'package:social/providers/user_image_provider.dart';
import 'package:social/providers/video_provider.dart';
import 'package:social/utils/methods/firebase_methods.dart';
import 'package:social/widgets/others/custom_basic_page.dart';
import 'package:social/widgets/others/custom_text.dart';
import 'package:social/widgets/auth/sign_up/custom_uploaded_image.dart';
import 'package:social/widgets/profile/custom_appbar.dart';

class AddStoryPage extends StatelessWidget {
  const AddStoryPage({super.key});

  static const String routeName = '/add_story_page';
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).dividerColor;

    final UserDataProvider userProvider =
        Provider.of<UserDataProvider>(context);
    final UserImageProvider userImageProvider =
        Provider.of<UserImageProvider>(context);
    final VideoProvider videoProvider = Provider.of<VideoProvider>(context);

    final IsLoadingProvider isLoading = Provider.of<IsLoadingProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: isLoading.getIsLoading,
      child: CustomBasicPage(
        appBar: const CustomAppbar(title: 'Add Story'),
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  videoProvider.getIsVideo
                      ? videoProvider.removeVideo
                      : userImageProvider.removeUserImage;
                },
                icon: Icon(
                  Icons.cancel_outlined,
                  color: color,
                ),
              ),
              const Spacer(),
              CustomText(
                title: 'Add New Story',
                color: color,
                fontSize: 20,
              ),
              const Spacer(),
              IconButton(
                onPressed: () async {
                  isLoading.setIsLoading;
                  await FirebaseMethods.addStory(userImageProvider,
                      videoProvider: videoProvider,
                      userDataProvider: userProvider);
                  videoProvider.setIsVideo;

                  userProvider.fetchUserData(
                      userId: userProvider.getUserData.id);
                  isLoading.setIsLoading;
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(
                  Icons.add_circle_outline,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          CustomUpLoadedMedia(
            mediaProvider: videoProvider.getIsVideo
                ? videoProvider.getVideo
                : userImageProvider.getUserImage,
          )
        ],
      ),
    );
  }
}
