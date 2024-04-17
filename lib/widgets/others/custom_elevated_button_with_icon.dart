import 'package:flutter/material.dart';
import 'package:social/utils/methods/app_methods.dart';
import 'package:social/widgets/others/custom_text.dart';

class CustomElevatedButtonWithIcon extends StatelessWidget {
  const CustomElevatedButtonWithIcon(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPressed,
      this.color});

  final String title;
  final Color? color;
  final IconData icon;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    Color secondColor = Theme.of(context).dividerColor;
    Color xColor = Theme.of(context).scaffoldBackgroundColor;
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? secondColor,
        shape: RoundedRectangleBorder(
          borderRadius: AppMethods.boderRadius(radius: 50),
        ),
      ),
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: xColor,
      ),
      label: CustomText(
        title: title,
        color: xColor,
      ),
    );
  }
}
