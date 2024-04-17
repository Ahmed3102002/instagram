import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/providers/show_posts_provider.dart';
import 'package:social/widgets/others/custom_error_data.dart';
import 'package:social/widgets/others/custom_loading.dart';
import 'package:social/widgets/home/custom_post.dart';
import 'package:social/widgets/others/no_data_founded.dart';

class CustomListOfPosts extends StatelessWidget {
  const CustomListOfPosts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ShowPostsProvider postsProvider =
        Provider.of<ShowPostsProvider>(context);

    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('all_posts')
            .orderBy('dateOfPost', descending: true)
            .snapshots(),
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting &&
              !snapshots.hasData) {
            return const CustomLoading();
          }
          if (!snapshots.hasData || snapshots.data!.docs.isEmpty) {
            return const NoDataFounded(message: 'No Posts Found');
          }
          if (snapshots.hasError) {
            return const CustomDataError();
          }
          postsProvider.setPosts(snapshots.data!.docs
              .map((e) => e.data() as Map<String, dynamic>)
              .toList());

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return CustomPost(
                index: index,
              );
            },
            itemCount: snapshots.data!.docs.length,
          );
        });
  }
}
