import 'package:flutter/material.dart';
import 'package:social/pages/auth_pages/forget_pass_page.dart';
import 'package:social/widgets/others/custom_text.dart';

class CustomRestPassword extends StatelessWidget {
  const CustomRestPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).scaffoldBackgroundColor;
    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: TextButton(
        onPressed: () =>
            Navigator.pushNamed(context, ForgetPasswordPage.routName),
        child: CustomText(
          decoration: TextDecoration.underline,
          title: 'Forget Password !',
          color: color,
        ),
      ),
    );
  }
}
