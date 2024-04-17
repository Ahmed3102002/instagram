import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:social/models/user_model.dart';
import 'package:social/providers/is_loading_provider.dart';
import 'package:social/providers/user_data_provider.dart';
import 'package:social/widgets/others/custom_basic_page.dart';
import 'package:social/widgets/others/custom_loading.dart';
import 'package:social/widgets/others/custom_text.dart';
import 'package:social/widgets/profile/custom_all_current_user_posts.dart';
import 'package:social/widgets/profile/custom_edit_profile_button.dart';
import 'package:social/widgets/profile/custom_appbar.dart';
import 'package:social/widgets/profile/custom_profile_info.dart';
import 'package:social/widgets/profile/profile_buttons.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  static const String routeName = '/profile_page';
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).dividerColor;
    Map<String, dynamic>? userData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final IsLoadingProvider isLoading = Provider.of<IsLoadingProvider>(context);

    final UserModel? userInfo =
        Provider.of<UserDataProvider>(context).getUserData;
    return ModalProgressHUD(
      progressIndicator: const CustomLoading(),
      inAsyncCall: isLoading.getIsLoading,
      child: CustomBasicPage(
        appBar: userData != null
            ? CustomAppbar(title: userData['name'])
            : AppBar(
                elevation: 0,
                title: CustomText(
                  title: userInfo!.name,
                  color: color,
                  fontSize: 20,
                ),
                actions: const [
                  ProfileButtons(),
                ],
              ),
        children: [
          CustomProfileInfo(
            userInfo: userInfo!,
          ),
          CustomEditProfileButton(
            userId: userData?['id'] ?? FirebaseAuth.instance.currentUser!.uid,
          ),
          Divider(
            color: color,
            thickness: 2,
            indent: 5,
            endIndent: 10,
          ),
          CustomAllCurrentUserPosts(
            userId: userData?['id'] ?? FirebaseAuth.instance.currentUser!.uid,
          ),
        ],
      ),
    );
  }
}
