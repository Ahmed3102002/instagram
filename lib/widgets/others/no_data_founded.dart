import 'package:flutter/material.dart';
import 'package:social/widgets/others/custom_text.dart';

class NoDataFounded extends StatelessWidget {
  const NoDataFounded({
    super.key,
    required this.message,
  });
  final String message;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/forgot_password.png',
          fit: BoxFit.fill,
        ),
        CustomText(
          textAlign: TextAlign.center,
          title: message,
          fontSize: 20,
          color: Theme.of(context).dividerColor,
        )
      ],
    );
  }
}
