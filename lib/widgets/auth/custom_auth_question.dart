import 'package:flutter/material.dart';
import 'package:social/pages/auth_pages/log_in_page.dart';
import 'package:social/pages/auth_pages/sign_up_page.dart';
import 'package:social/widgets/others/custom_text.dart';

class CustomAuthQuestion extends StatelessWidget {
  const CustomAuthQuestion({
    super.key,
    this.isLogIn = true,
  });
  final bool isLogIn;
  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).scaffoldBackgroundColor;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          title: isLogIn
              ? 'I don`t have an account yet ?'
              : 'Already I have an account !',
          color: color,
        ),
        TextButton(
          onPressed: () async {
            await Navigator.pushReplacementNamed(
                context, isLogIn ? SignUpPage.routName : LogInPage.routName);
          },
          child: CustomText(
            title: isLogIn ? 'Sign Up' : 'Log In',
            color: color,
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }
}
