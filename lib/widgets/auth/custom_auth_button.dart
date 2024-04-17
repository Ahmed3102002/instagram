import 'package:flutter/material.dart';
import 'package:social/utils/methods/app_methods.dart';
import 'package:social/widgets/others/custom_text.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({
    super.key,
    this.onPressed,
    required this.title,
  });

  final void Function()? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).scaffoldBackgroundColor;
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5,
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: AppMethods.boderRadius(radius: 50),
          ),
        ),
        onPressed: onPressed,
        child: CustomText(
          title: title,
          color: Theme.of(context).dividerColor,
        ),
      ),
    );
  }
}
