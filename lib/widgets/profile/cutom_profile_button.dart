import 'package:flutter/material.dart';
import 'package:social/widgets/others/custom_text.dart';

class CutomProfileButton extends StatelessWidget {
  const CutomProfileButton({
    super.key,
    required this.title,
    required this.iconData,
  });

  final IconData iconData;
  final String title;

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).dividerColor;
    return Row(
      children: [
        Icon(
          iconData,
          color: color,
        ),
        const Spacer(),
        CustomText(
          title: title,
          color: color,
        ),
      ],
    );
  }
}
