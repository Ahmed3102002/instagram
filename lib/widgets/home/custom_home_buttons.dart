import 'package:flutter/material.dart';
import 'package:social/pages/inner_pages/chat_page.dart';
import 'package:social/widgets/others/custom_text.dart';

class CustomHomeButtons extends StatelessWidget {
  const CustomHomeButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).dividerColor;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            title: 'instagram',
            color: color,
            fontSize: 20,
          ),
          const Spacer(),
          IconButton(
            onPressed: () async {
              await Navigator.pushNamed(context, ChatPage.routeName);
            },
            icon: Icon(
              Icons.message_outlined,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
