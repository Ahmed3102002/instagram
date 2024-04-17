import 'package:flutter/material.dart';
import 'package:social/widgets/others/custom_basic_page.dart';
import 'package:social/widgets/home/custom_home_buttons.dart';
import 'package:social/widgets/home/custom_list_of_posts.dart';
import 'package:social/widgets/home/custom_user_status.dart';

class HomePage extends StatelessWidget {
  static const String routName = '/home_page';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomBasicPage(
      children: [
        CustomHomeButtons(),
        CustomUserStatus(),
        CustomListOfPosts(),
      ],
    );
  }
}
