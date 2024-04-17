import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/models/user_model.dart';
import 'package:social/providers/is_loading_provider.dart';
import 'package:social/providers/user_data_provider.dart';
import 'package:social/utils/methods/firebase_methods.dart';
import 'package:social/widgets/others/custom_elevated_button_with_icon.dart';

class CustomEditProfileButton extends StatelessWidget {
  CustomEditProfileButton({
    super.key,
    required this.userId,
  });
  final String userId;

  final String currentId = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    final UserModel? userInfo =
        Provider.of<UserDataProvider>(context).getUserData;
    final IsLoadingProvider isLoading = Provider.of<IsLoadingProvider>(context);

    bool contains = userInfo!.followers.contains(currentId);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomElevatedButtonWithIcon(
        color: contains ? Colors.redAccent : Colors.blue,
        title: userId == currentId
            ? 'Edit Profile'
            : contains
                ? 'unFollow'
                : 'Follow',
        icon: contains ? Icons.cancel_outlined : Icons.add_circle,
        onPressed: () async {
          isLoading.setIsLoading;
          userInfo.followers.contains(currentId)
              ? await FirebaseMethods.unFollow(userId: userId)
              : await FirebaseMethods.addFollow(userId: userId);
          if (context.mounted) {
            Provider.of<UserDataProvider>(context, listen: false)
                .fetchUserData(userId: userId);
          }
          isLoading.setIsLoading;
        },
      ),
    );
  }
}
