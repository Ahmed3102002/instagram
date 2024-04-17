import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social/providers/user_data_provider.dart';

class CustomMessage extends StatelessWidget {
  const CustomMessage({
    super.key,
    required this.userData,
    required this.userDataProvider,
    required this.message,
  });

  final Map<String, dynamic>? userData;
  final UserDataProvider userDataProvider;
  final String message;

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).dividerColor;
    return BubbleNormal(
      seen: FirebaseAuth.instance.currentUser!.uid == userData?['id'],
      delivered: FirebaseAuth.instance.currentUser!.uid == userData?['id'],
      text: message,
      isSender: FirebaseAuth.instance.currentUser!.uid == userData?['id'],
      sent: FirebaseAuth.instance.currentUser!.uid == userData?['id'],
      color: userDataProvider.getUserData.id == userData?['id']
          ? const Color.fromARGB(255, 13, 122, 108)
          : const Color(0xFF1B97F3),
      tail: true,
      textStyle: TextStyle(
        fontSize: 20,
        color: color,
      ),
    );
  }
}
