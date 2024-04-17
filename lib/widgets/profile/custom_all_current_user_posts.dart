import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/providers/is_loading_provider.dart';
import 'package:social/widgets/others/custom_error_data.dart';
import 'package:social/widgets/others/custom_loading.dart';
import 'package:social/widgets/others/no_data_founded.dart';

class CustomAllCurrentUserPosts extends StatelessWidget {
  const CustomAllCurrentUserPosts({
    super.key,
    required this.userId,
  });
  final String userId;
  @override
  Widget build(BuildContext context) {
    final IsLoadingProvider isLoading = Provider.of<IsLoadingProvider>(context);

    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('all_posts')
            .where('userId', isNull: false, isEqualTo: userId)
            .get(),
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting &&
              isLoading.getIsLoading != true) {
            return const CustomLoading();
          }
          if (!snapshots.hasData || snapshots.data!.docs.isEmpty) {
            log(FirebaseAuth.instance.currentUser!.uid);
            return const NoDataFounded(message: 'No Posts Found');
          }
          if (snapshots.hasError) {
            return const CustomDataError();
          }
          return GridView.builder(
            reverse: true,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshots.data!.docs.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 1,
              crossAxisSpacing: 2,
              childAspectRatio: 0.75,
              crossAxisCount: 3,
            ),
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                child: FancyShimmerImage(
                  imageUrl: snapshots.data!.docs[index]['postImageUrl'],
                ),
              );
            },
          );
        });
  }
}
