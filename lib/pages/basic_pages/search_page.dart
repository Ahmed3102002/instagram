import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/pages/basic_pages/profile_page.dart';
import 'package:social/pages/inner_pages/message_page.dart';
import 'package:social/providers/search_provider.dart';
import 'package:social/providers/user_data_provider.dart';
import 'package:social/widgets/others/custom_basic_page.dart';
import 'package:social/widgets/others/custom_error_data.dart';
import 'package:social/widgets/others/custom_loading.dart';
import 'package:social/widgets/others/custom_text.dart';
import 'package:social/widgets/home/custom_user_image.dart';
import 'package:social/widgets/others/no_data_founded.dart';
import 'package:social/widgets/text_form/search_text_form.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).dividerColor;
    final SearchProvider searchProvider = Provider.of<SearchProvider>(context);
    return CustomBasicPage(
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).width * 0.05,
        ),
        SearchTextForm(
          searchController: _searchController,
          onChanged: (newValue) {
            searchProvider.setSearchText(newValue);
          },
        ),
        FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('users')
                .where(
                  'name',
                  isNull: false,
                  isEqualTo: searchProvider.getSearchText,
                )
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CustomLoading();
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const NoDataFounded(
                  message: 'No Users Found',
                );
              }
              if (snapshot.hasError) {
                return const CustomDataError();
              }
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return snapshot.data!.docs[index]['id'] !=
                            FirebaseAuth.instance.currentUser!.uid
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () async {
                                if (context.mounted) {
                                  Provider.of<UserDataProvider>(context,
                                          listen: false)
                                      .fetchUserData(
                                          userId: snapshot.data!.docs[index]
                                              ['id']);
                                }
                                if (context.mounted) {
                                  await Navigator.pushNamed(
                                      context, ProfilePage.routeName,
                                      arguments:
                                          snapshot.data!.docs[index].data());
                                }
                                _searchController.clear();
                              },
                              child: Row(
                                children: [
                                  CustomUserImage(
                                    color: Colors.pink,
                                    image: snapshot.data!.docs[index]
                                        ['imageUrl'],
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.02,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        title: snapshot.data!.docs[index]
                                            ['name'],
                                        color: color,
                                      ),
                                      CustomText(
                                        title: snapshot.data!.docs[index]
                                            ['email'],
                                        color: color,
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () async {
                                      await Navigator.pushNamed(
                                          context, MessagePage.routeName,
                                          arguments: snapshot.data!.docs[index]
                                              .data());
                                    },
                                    icon: Icon(
                                      Icons.message_outlined,
                                      color: color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : null;
                  });
            })
      ],
    );
  }
}
