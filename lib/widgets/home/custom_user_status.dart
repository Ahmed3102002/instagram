import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social/pages/inner_pages/view_story_page.dart';
import 'package:social/widgets/story/add_current_user_story.dart';
import 'package:social/widgets/others/custom_error_data.dart';
import 'package:social/widgets/others/custom_loading.dart';
import 'package:social/widgets/others/custom_text.dart';
import 'package:social/widgets/home/custom_user_image.dart';

class CustomUserStatus extends StatelessWidget {
  const CustomUserStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).dividerColor;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('stories', isNotEqualTo: [])
              .where('followers',
                  arrayContains: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshots) {
            if (snapshots.connectionState == ConnectionState.waiting &&
                !snapshots.hasData) {
              return const CustomLoading();
            }
            if (!snapshots.hasData || snapshots.data!.docs.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AddCurrentUserStory(),
                  ],
                ),
              );
            }
            if (snapshots.hasError) {
              return const CustomDataError();
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          await Navigator.pushNamed(
                              context, ViewStoryPage.routeName,
                              arguments: snapshots.data!.docs[index]
                                  .data()['stories']);
                        },
                        child: CustomUserImage(
                          color: Colors.pink,
                          radius: 40,
                          image: snapshots.data!.docs[index]['imageUrl'],
                        ),
                      ),
                      CustomText(
                        title: snapshots.data!.docs[index]['name'],
                        color: color,
                        fontSize: 10,
                      ),
                    ],
                  ),
                );
              },
              itemCount: snapshots.data!.docs.length,
            );
          }),
    );
  }
}
