import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:social/providers/comment_provider.dart';
import 'package:social/providers/user_data_provider.dart';
import 'package:social/utils/methods/firebase_methods.dart';
import 'package:social/widgets/others/custom_error_data.dart';
import 'package:social/widgets/others/custom_text.dart';
import 'package:social/widgets/home/custom_user_image.dart';
import 'package:social/widgets/add_new_post/add_comment_text_form.dart';
import 'package:social/widgets/others/no_data_founded.dart';

class CommentsPage extends StatelessWidget {
  CommentsPage({super.key});
  final TextEditingController _commentController = TextEditingController();
  static const String routName = '/comments_page';
  final String image =
      'https://media.istockphoto.com/id/1413735503/photo/social-media-social-media-marketing-thailand-social-media-engagement-post-structure.jpg?s=2048x2048&w=is&k=20&c=i6oJR_ptHv1Yf6NeZ6ncHpS-OX04GUotOhB2Mug20n4=';
  @override
  Widget build(BuildContext context) {
    final UserDataProvider userProvider =
        Provider.of<UserDataProvider>(context);
    final CommentProvider commentProvider =
        Provider.of<CommentProvider>(context);
    Color backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    Color color = Theme.of(context).dividerColor;
    String postId = ModalRoute.of(context)!.settings.arguments as String;
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          foregroundColor: color,
          backgroundColor: backgroundColor,
          elevation: 0,
          title: CustomText(
            title: 'Comments',
            color: color,
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('all_posts')
                .doc(postId)
                .collection('comments')
                .orderBy('dateOfComment')
                .snapshots(),
            builder: (context, snapshots) {
              if (!snapshots.hasData || snapshots.data!.docs.isEmpty) {
                return const NoDataFounded(message: 'No Comments yet');
              }
              if (snapshots.hasError) {
                return const CustomDataError();
              }
              Future.microtask(() {
                commentProvider.setComments(snapshots.data!.docs
                    .map((e) => e.data() as Map<String, dynamic>)
                    .toList());
              });
              return ListView.builder(
                shrinkWrap: true,
                reverse: true,
                physics: const BouncingScrollPhysics(),
                itemCount: commentProvider.getComments.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CustomUserImage(
                      color: Colors.pink,
                      image: commentProvider.getComments[index]['userImage'],
                      radius: 20,
                    ),
                    title: CustomText(
                      title: commentProvider.getComments[index]['userName'],
                      color: color,
                    ),
                    subtitle: CustomText(
                      title: commentProvider.getComments[index]['comment'],
                      color: color,
                      fontSize: 12,
                    ),
                    trailing: CustomText(
                      title: DateFormat.jm().format(commentProvider
                          .getComments[index]['dateOfComment']
                          .toDate()),
                      color: color,
                    ),
                  );
                },
              );
            }),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              CustomUserImage(
                image: userProvider.getUserData.imageUrl,
                color: Colors.pink,
              ),
              Expanded(
                child: AddCommentTextForm(
                  isCommentPage: true,
                  commentController: _commentController,
                  maxLines: 1,
                  onPressed: () {
                    FocusScope.of(context).requestFocus();
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      FirebaseMethods.addComment(
                          context, postId, userProvider, _commentController);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
