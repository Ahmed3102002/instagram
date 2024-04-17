import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/pages/root_page.dart';
import 'package:social/providers/comment_provider.dart';
import 'package:social/providers/is_loading_provider.dart';
import 'package:social/providers/user_data_provider.dart';
import 'package:social/providers/user_image_provider.dart';
import 'package:social/utils/methods/firebase_methods.dart';
import 'package:social/widgets/others/custom_text.dart';

class TopAddPostPage extends StatelessWidget {
  const TopAddPostPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).dividerColor;

    final UserDataProvider userProvider =
        Provider.of<UserDataProvider>(context);
    final UserImageProvider userImageProvider =
        Provider.of<UserImageProvider>(context);
    final CommentProvider commentProvider =
        Provider.of<CommentProvider>(context);

    final IsLoadingProvider isLoading = Provider.of<IsLoadingProvider>(context);
    return Row(
      children: [
        IconButton(
          onPressed: () {
            isLoading.getIsLoading;
            if (userImageProvider.getUserImage != null) {
              userImageProvider.removeUserImage;
            }
            commentProvider.removeComment;
            isLoading.getIsLoading;
          },
          icon: Icon(
            Icons.cancel_outlined,
            color: color,
          ),
        ),
        const Spacer(),
        CustomText(
          title: 'Add New Post',
          color: color,
          fontSize: 20,
        ),
        const Spacer(),
        IconButton(
          onPressed: () async {
            isLoading.setIsLoading;
            await FirebaseMethods.upLoadPostToFirebase(context,
                userImageProvider, userProvider, commentProvider.getComment);

            isLoading.setIsLoading;
            if (context.mounted) {
              Navigator.pushReplacementNamed(context, RootPage.routName);
            }
          },
          icon: const Icon(
            Icons.add_circle_outline,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
