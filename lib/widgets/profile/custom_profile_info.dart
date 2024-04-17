import 'package:flutter/material.dart';
import 'package:social/models/user_model.dart';
import 'package:social/widgets/story/add_current_user_story.dart';
import 'package:social/widgets/others/custom_text.dart';

class CustomProfileInfo extends StatelessWidget {
  const CustomProfileInfo({
    super.key,
    required this.userInfo,
  });
  final UserModel userInfo;
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).dividerColor;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              const AddCurrentUserStory(),
              CustomText(
                title: userInfo.name,
                fontSize: 12,
                color: color,
              ),
              CustomText(
                title: userInfo.email,
                fontSize: 10,
                color: color,
              ),
            ],
          ),
          Column(
            children: [
              CustomText(
                title: userInfo.posts.length.toString(),
                color: color,
              ),
              CustomText(
                title: 'Posts',
                color: color,
              )
            ],
          ),
          Column(
            children: [
              CustomText(
                title: userInfo.followers.length.toString(),
                color: color,
              ),
              CustomText(
                title: 'Followers',
                color: color,
              )
            ],
          ),
          Column(
            children: [
              CustomText(
                title: userInfo.following.length.toString(),
                color: color,
              ),
              CustomText(
                title: 'Following',
                color: color,
              )
            ],
          ),
        ],
      ),
    );
  }
}
