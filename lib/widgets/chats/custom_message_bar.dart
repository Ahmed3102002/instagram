import 'package:flutter/material.dart';
import 'package:social/providers/user_data_provider.dart';
import 'package:social/utils/methods/firebase_methods.dart';
import 'package:social/widgets/text_form/custom_text_form.dart';

class CustomMessageBar extends StatelessWidget {
  const CustomMessageBar({
    super.key,
    required TextEditingController textController,
    required this.userDataProvider,
    required this.userData,
  }) : _textController = textController;

  final TextEditingController _textController;
  final UserDataProvider userDataProvider;
  final Map<String, dynamic>? userData;

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).dividerColor;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: InkWell(
              child: Icon(
                Icons.add,
                color: color,
              ),
              onTap: () {},
            ),
          ),
          InkWell(
            child: Icon(
              Icons.camera_alt_outlined,
              color: color,
            ),
            onTap: () {},
          ),
          Expanded(
            child: CustomTextForm(
              hintText: 'hintText',
              controller: _textController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: InkWell(
              child: Icon(
                Icons.send,
                color: color,
                size: 24,
              ),
              onTap: () async {
                await FirebaseMethods.upLoadChatToFirebase(
                    userDataProvider, userData, _textController);
                _textController.clear();
              },
            ),
          ),
        ],
      ),
    );
  }
}
