import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social/pages/auth_pages/forget_pass_page.dart';
import 'package:social/pages/auth_pages/log_in_page.dart';
import 'package:social/pages/auth_pages/sign_up_page.dart';
import 'package:social/pages/basic_pages/add_new_post.dart';
import 'package:social/pages/basic_pages/home_page.dart';
import 'package:social/pages/basic_pages/profile_page.dart';
import 'package:social/pages/basic_pages/search_page.dart';
import 'package:social/pages/inner_pages/add_story_page.dart';
import 'package:social/pages/inner_pages/chat_page.dart';
import 'package:social/pages/inner_pages/comments_page.dart';
import 'package:social/pages/inner_pages/message_page.dart';
import 'package:social/pages/inner_pages/view_story_page.dart';
import 'package:social/pages/root_page.dart';
import 'package:social/widgets/others/custom_text.dart';

class ConstantVariables {
  static const String collectionPath = 'users';
  static String uid2 = FirebaseAuth.instance.currentUser!.uid;
  static const String path = 'usersImages';
  static String imagePath = '${uid2}_jpg';
  static const String selectImageValue = 'image';
  static const String selectVideoValue = 'video';
  static const BorderRadiusGeometry borderRadius = BorderRadius.all(
    Radius.circular(20),
  );

  static List<Widget> pages = [
    const HomePage(),
    SearchPage(),
    AddNewPost(),
    const ProfilePage()
  ];

  static Map<String, Widget Function(dynamic context)> routes = {
    LogInPage.routName: (context) => const LogInPage(),
    SignUpPage.routName: (context) => const SignUpPage(),
    HomePage.routName: (context) => const HomePage(),
    ForgetPasswordPage.routName: (context) => const ForgetPasswordPage(),
    RootPage.routName: (context) => const RootPage(),
    CommentsPage.routName: (context) => CommentsPage(),
    ProfilePage.routeName: (context) => const ProfilePage(),
    AddStoryPage.routeName: (context) => const AddStoryPage(),
    ViewStoryPage.routeName: (context) => const ViewStoryPage(),
    ChatPage.routeName: (context) => const ChatPage(),
    MessagePage.routeName: (context) => MessagePage(),
  };
  static List<PopupMenuEntry<String>> list = <PopupMenuEntry<String>>[
    const PopupMenuItem<String>(
      value: ConstantVariables.selectImageValue,
      child: CustomText(
        title: 'Add Image',
        color: Colors.black,
      ),
    ),
    const PopupMenuItem<String>(
      value: ConstantVariables.selectVideoValue,
      child: CustomText(
        title: 'Add Video',
        color: Colors.black,
      ),
    ),
  ];
}
