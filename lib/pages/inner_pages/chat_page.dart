import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social/pages/inner_pages/message_page.dart';
import 'package:social/utils/methods/app_methods.dart';
import 'package:social/widgets/others/custom_error_data.dart';
import 'package:social/widgets/others/custom_loading.dart';
import 'package:social/widgets/others/custom_text.dart';
import 'package:social/widgets/chats/custom_deleted_widget.dart';
import 'package:social/widgets/home/custom_user_image.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});
  static const String routeName = '/chat_page';

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).dividerColor;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: color,
        elevation: 0,
        title: CustomText(
          title: 'Chats',
          color: color,
          fontSize: 20,
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chats')
              .where('participants',
                  arrayContains: FirebaseAuth.instance.currentUser!.uid)
              .orderBy('date')
              .snapshots(),
          builder: (context, snapshots) {
            if (snapshots.connectionState == ConnectionState.waiting &&
                !snapshots.hasData) {
              return const CustomLoading();
            }
            if (!snapshots.hasData || snapshots.data!.docs.isEmpty) {
              return Center(
                child: CustomText(
                  title: 'No Chats Founded',
                  color: color,
                  fontSize: 20,
                ),
              );
            }
            if (snapshots.hasError) {
              return const CustomDataError();
            }
            return ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: snapshots.data!.docs.length,
                reverse: true,
                itemBuilder: (context, index) {
                  return CustomDeletedWidget(
                    chatRoomId: AppMethods.getChatroomId(
                        senderId: snapshots.data!.docs[index]['senderId'],
                        reciverId: snapshots.data!.docs[index]['reciverId']),
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(
                          context, MessagePage.routeName,
                          arguments: snapshots.data!.docs[index].data()),
                      child: ListTile(
                        leading: CustomUserImage(
                          image: snapshots.data!.docs[index]['reciverImage'],
                          color: Colors.transparent,
                          radius: 25,
                        ),
                        title: CustomText(
                          title: snapshots.data!.docs[index]['reciverName'],
                          color: color,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
