import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/providers/user_data_provider.dart';
import 'package:social/providers/video_provider.dart';
import 'package:social/widgets/others/custom_text.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    required this.title,
  });

  final String title;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).dividerColor;
    final VideoProvider videoProvider = Provider.of<VideoProvider>(context);

    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        title: CustomText(
          title: title,
          color: color,
          fontSize: 20,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.pop(context);
            if (videoProvider.getIsVideo) {
              videoProvider.removeVideo;
              videoProvider.setIsVideo;
            }
            if (context.mounted) {
              Provider.of<UserDataProvider>(context, listen: false)
                  .fetchUserData(
                      userId: FirebaseAuth.instance.currentUser!.uid);
            }
          },
        ),
        foregroundColor: Theme.of(context).dividerColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
    );
  }
}
