import 'package:chat_bubbles/date_chips/date_chip.dart';
import 'package:flutter/material.dart';
import 'package:social/providers/user_data_provider.dart';
import 'package:social/utils/methods/app_methods.dart';
import 'package:social/widgets/chats/custom_message.dart';
import 'package:social/widgets/chats/custom_deleted_widget.dart';

class CustomAllMessages extends StatelessWidget {
  const CustomAllMessages({
    super.key,
    required this.userDataProvider,
    required this.userData,
    required this.messageData,
  });

  final UserDataProvider userDataProvider;
  final Map<String, dynamic>? userData;
  final Map<String, dynamic> messageData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DateChip(
          color: Theme.of(context).scaffoldBackgroundColor,
          date: messageData['date'].toDate() ?? 'No Name',
        ),
        CustomDeletedWidget(
          chatRoomId: AppMethods.getChatroomId(
              senderId: userDataProvider.getUserData.id,
              reciverId: userData?['reciverId'] ?? userData?['id']),
          messageId: messageData['id'],
          child: CustomMessage(
            userData: userData,
            userDataProvider: userDataProvider,
            message: messageData['message'] ?? 'No Name',
          ),
        ),
      ],
    );
  }
}
