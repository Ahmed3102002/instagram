import 'package:flutter/material.dart';
import 'package:social/widgets/others/custom_text.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    Color fontColor = Theme.of(context).scaffoldBackgroundColor;

    return CustomText(
      textAlign: TextAlign.center,
      title: title,
      fontSize: 20,
      color: fontColor,
    );
  }
}
