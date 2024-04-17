import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social/providers/like_provider.dart';
import 'package:social/utils/methods/firebase_methods.dart';
import 'package:social/widgets/others/custom_text.dart';

class AppMethods {
  static BorderRadius boderRadius({required double radius}) =>
      BorderRadius.all(Radius.circular(radius));
  static void showFirebaseAuthException(
      BuildContext context, FirebaseException e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          width: null,
          shape: RoundedRectangleBorder(
            borderRadius: AppMethods.boderRadius(radius: 50),
          ),
          content: CustomText(
            textAlign: TextAlign.center,
            title: e.code,
            color: Theme.of(context).dividerColor,
          ),
        ),
      );
    }
  }

  static Future<dynamic> showUserImageError(
      BuildContext context, FirebaseException? e,
      {String? error}) {
    Color fontColor = Theme.of(context).scaffoldBackgroundColor;
    return showAdaptiveDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).dividerColor,
            title: Column(
              children: [
                Image.asset('assets/images/error.png'),
                CustomText(
                  title: e == null
                      ? error ?? 'you must select an image for user profile'
                      : e.code,
                  color: fontColor,
                )
              ],
            ),
            content: OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: AppMethods.boderRadius(radius: 50),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: CustomText(
                title: 'Ok',
                color: fontColor,
              ),
            ),
          );
        });
  }

  static Future<void> isLikePostMethod(
      IsLikeProvider isLikeProvider,
      List<Map<String, dynamic>> postsProvider,
      int index,
      BuildContext context) async {
    isLikeProvider.setIsLike(postsProvider[index]['islike']);
    await FirebaseMethods.upDatePostData(
        context,
        postsProvider[index]['postId'],
        postsProvider[index]['likesCount'],
        isLikeProvider.getIsLike);
  }

  static String getChatroomId(
      {required String senderId, required String reciverId}) {
    final List<String> users = [senderId, reciverId];
    users.sort();
    return users[0] + users[1];
  }
}
