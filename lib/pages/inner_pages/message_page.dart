import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/providers/user_data_provider.dart';
import 'package:social/utils/methods/app_methods.dart';
import 'package:social/widgets/chats/custom_all_messages.dart';
import 'package:social/widgets/chats/custom_message_bar.dart';
import 'package:social/widgets/chats/custom_reciver_data.dart';
import 'package:social/widgets/others/custom_error_data.dart';
import 'package:social/widgets/others/custom_loading.dart';
import 'package:social/widgets/others/custom_text.dart';

class MessagePage extends StatelessWidget {
  MessagePage({super.key});
  static const String routeName = '/message_page';

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).dividerColor;
    final Map<String, dynamic>? userData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final UserDataProvider userDataProvider =
        Provider.of<UserDataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: color,
        elevation: 0,
        title: CustomReciverData(
          userData: userData,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('chats')
                    .doc(AppMethods.getChatroomId(
                        senderId: userDataProvider.getUserData.id,
                        reciverId: userData?['reciverId'] ?? userData?['id']))
                    .collection('messages')
                    .orderBy('date', descending: true)
                    .snapshots(),
                builder: (context, snapshots) {
                  if (snapshots.connectionState == ConnectionState.waiting &&
                      !snapshots.hasData) {
                    return const CustomLoading();
                  }
                  if (!snapshots.hasData || snapshots.data!.docs.isEmpty) {
                    return CustomText(
                      title: 'No Chats Founded',
                      color: color,
                    );
                  }
                  if (snapshots.hasError) {
                    return const CustomDataError();
                  }
                  return ListView.builder(
                      itemCount: snapshots.data!.docs.length,
                      reverse: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CustomAllMessages(
                          userDataProvider: userDataProvider,
                          userData: userData,
                          messageData: snapshots.data!.docs[index].data(),
                        );
                      });
                }),
          ),
          CustomMessageBar(
            textController: _textController,
            userDataProvider: userDataProvider,
            userData: userData,
          ),
        ],
      ),
    );
  }
}
