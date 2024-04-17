import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/providers/user_data_provider.dart';
import 'package:social/utils/methods/firebase_methods.dart';
import 'package:social/widgets/others/custom_text.dart';
import 'package:social/widgets/home/custom_user_image.dart';
import 'package:story_view/story_view.dart';

class ViewStoryPage extends StatelessWidget {
  const ViewStoryPage({super.key});
  static const String routeName = '/view_story_page';

  @override
  Widget build(BuildContext context) {
    final UserDataProvider userData = Provider.of<UserDataProvider>(context);
    List data = ModalRoute.of(context)!.settings.arguments as List;
    Color color = Theme.of(context).dividerColor;
    Map<String, dynamic> storyData = {};
    final StoryController controller = StoryController();
    return Scaffold(
      body: Stack(children: [
        StoryView(
          storyItems: (data).map<StoryItem?>((story) {
            storyData = story;
            if (story['type'] == 'image') {
              return StoryItem.pageImage(
                  url: story['storyUrl'], controller: controller);
            }
            if (story['type'] == 'video') {
              return StoryItem.pageVideo(story['storyUrl'],
                  controller: controller);
            }
            return null;
          }).toList(),
          controller: controller,
          onComplete: () {
            userData.fetchUserData(
                userId: FirebaseAuth.instance.currentUser!.uid);
            Navigator.pop(context);
          },
        ),
        Positioned(
          top: 60,
          left: 20,
          child: Row(
            children: [
              CustomUserImage(
                color: color,
                image: storyData['userImage'],
                radius: 20,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.02,
              ),
              CustomText(
                title: storyData['userName'],
                color: color,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.55,
              ),
              if (storyData['userId'] == FirebaseAuth.instance.currentUser!.uid)
                IconButton(
                  onPressed: () async {
                    await FirebaseMethods.deleteStory(story: storyData);
                    if (context.mounted) Navigator.pop(context);
                    userData.deleteStory(story: storyData);
                    userData.fetchUserData(
                        userId: FirebaseAuth.instance.currentUser!.uid);
                    // Future.delayed(const Duration(milliseconds: 100));
                    //if (context.mounted) Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.delete_outlined,
                    color: color,
                  ),
                ),
            ],
          ),
        ),
      ]),
    );
  }
}
