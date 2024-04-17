import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/pages/basic_pages/profile_page.dart';
import 'package:social/providers/is_loading_provider.dart';
import 'package:social/providers/show_posts_provider.dart';
import 'package:social/providers/user_data_provider.dart';
import 'package:social/utils/methods/firebase_methods.dart';
import 'package:social/widgets/others/custom_text.dart';
import 'package:social/widgets/home/custom_user_image.dart';

class CustomLittleUserInfo extends StatelessWidget {
  const CustomLittleUserInfo({
    super.key,
    required this.index,
  });
  final int index;
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).dividerColor;
    final List<Map<String, dynamic>> postsProvider =
        Provider.of<ShowPostsProvider>(context).getPosts;
    final IsLoadingProvider isLoading = Provider.of<IsLoadingProvider>(context);
    final UserDataProvider userDataProvider =
        Provider.of<UserDataProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async {
          isLoading.setIsLoading;
          userDataProvider.fetchUserData(
              userId: postsProvider[index]['userId']);
          isLoading.setIsLoading;
          if (context.mounted) {
            await Navigator.pushNamed(context, ProfilePage.routeName,
                arguments: userDataProvider.getUserData);
          }
        },
        child: Row(
          children: [
            CustomUserImage(
              color: Colors.transparent,
              image: postsProvider[index]['userImage'],
              radius: 25,
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.02,
            ),
            CustomText(
              title: postsProvider[index]['userName'],
              color: color,
            ),
            const Spacer(),
            if (postsProvider[index]['userId'] ==
                FirebaseAuth.instance.currentUser?.uid)
              IconButton(
                onPressed: () async {
                  if (postsProvider[index]['userId'] ==
                      FirebaseAuth.instance.currentUser!.uid) {
                    await FirebaseMethods.deletePost(
                      postId: postsProvider[index]['postId'],
                    );
                  }
                },
                icon: Icon(
                  Icons.delete_outlined,
                  color: color,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
