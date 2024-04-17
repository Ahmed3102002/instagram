import 'dart:io';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:social/providers/is_loading_provider.dart';
import 'package:social/providers/user_image_provider.dart';
import 'package:social/widgets/add_new_post/top_add_post_page.dart';
import 'package:social/widgets/others/custom_basic_page.dart';
import 'package:social/widgets/auth/sign_up/custom_uploaded_image.dart';
import 'package:social/widgets/add_new_post/add_comment_text_form.dart';

class AddNewPost extends StatelessWidget {
  AddNewPost({super.key});

  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    final File? userImageProvider =
        Provider.of<UserImageProvider>(context).getUserImage;

    final IsLoadingProvider isLoading = Provider.of<IsLoadingProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: isLoading.getIsLoading,
      child: CustomBasicPage(
        children: [
          const TopAddPostPage(),
          SizedBox(
            height: height * 0.05,
          ),
          CustomUpLoadedMedia(mediaProvider: userImageProvider),
          SizedBox(
            height: height * 0.05,
          ),
          AddCommentTextForm(commentController: _commentController),
        ],
      ),
    );
  }
}
