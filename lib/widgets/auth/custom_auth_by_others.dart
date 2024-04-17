import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';

class CustomAuthByOthers extends StatelessWidget {
  const CustomAuthByOthers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: GoogleAuthButton(
            onPressed: () {},
            style: const AuthButtonStyle(
              elevation: 5,
              buttonType: AuthButtonType.icon,
            ),
          ),
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: FacebookAuthButton(
            onPressed: () {},
            style: const AuthButtonStyle(
              elevation: 5,
              buttonType: AuthButtonType.icon,
              padding: EdgeInsets.all(5),
            ),
          ),
        ),
      ],
    );
  }
}
