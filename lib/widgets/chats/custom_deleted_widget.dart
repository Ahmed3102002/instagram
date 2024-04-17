import 'package:flutter/material.dart';
import 'package:social/utils/methods/app_methods.dart';
import 'package:social/utils/methods/firebase_methods.dart';
import 'package:social/widgets/others/custom_outlined_button.dart';
import 'package:social/widgets/others/custom_text.dart';

class CustomDeletedWidget extends StatelessWidget {
  const CustomDeletedWidget({
    super.key,
    this.child,
    required this.chatRoomId,
    this.messageId,
  });

  final Widget? child;
  final String chatRoomId;
  final String? messageId;
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).dividerColor;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: InkWell(
        onLongPress: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: AppMethods.boderRadius(radius: 20),
                  ),
                  backgroundColor: color,
                  title: CustomText(
                    textAlign: TextAlign.center,
                    title: 'Are you sure ?',
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomOutlinedButton(
                          title: 'No',
                          onPressed: () => Navigator.pop(context),
                        ),
                        CustomOutlinedButton(
                          title: 'Yes',
                          onPressed: () async {
                            messageId != null
                                ? await FirebaseMethods.deleteMessage(
                                    chatRoomId: chatRoomId,
                                    messageId: messageId!)
                                : await FirebaseMethods.deleteChat(
                                    chatRoomId: chatRoomId,
                                  );
                            if (context.mounted) Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                );
              });
        },
        child: child,
      ),
    );
  }
}
