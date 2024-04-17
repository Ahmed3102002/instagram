import 'package:flutter/material.dart';
import 'package:social/widgets/others/custom_text.dart';
import 'package:social/widgets/home/custom_user_image.dart';

class CustomReciverData extends StatelessWidget {
  const CustomReciverData({
    super.key,
    required this.userData,
  });

  final Map<String, dynamic>? userData;

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).dividerColor;
    return Row(
      children: [
        CustomUserImage(
            radius: 15,
            image: userData?['reciverImage'] ?? userData?['imageUrl'],
            color: color),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.04,
        ),
        CustomText(
          title: userData?['reciverName'] ?? userData?['name'],
          color: color,
          fontSize: 20,
        ),
      ],
    );
  }
}
