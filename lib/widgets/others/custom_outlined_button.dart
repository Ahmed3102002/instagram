import 'package:flutter/material.dart';
import 'package:social/utils/methods/app_methods.dart';
import 'package:social/widgets/others/custom_text.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.title,
    this.onPressed,
  });
  final String title;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Theme.of(context).scaffoldBackgroundColor),
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(
          borderRadius: AppMethods.boderRadius(radius: 20),
        ),
      ),
      onPressed: onPressed,
      child: CustomText(
        title: title,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
