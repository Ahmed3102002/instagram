import 'package:flutter/material.dart';
import 'package:social/providers/is_loading_provider.dart';
import 'package:social/providers/user_data_provider.dart';
import 'package:social/utils/methods/auth_methods.dart';
import 'package:social/widgets/auth/custom_auth_button.dart';

class CustomLogInButton extends StatelessWidget {
  const CustomLogInButton({
    super.key,
    required this.isLoading,
    required TextEditingController mailController,
    required TextEditingController passController,
    required GlobalKey<FormState> formKey,
    required this.userInfo,
  })  : _mailController = mailController,
        _passController = passController,
        _formKey = formKey;

  final IsLoadingProvider isLoading;
  final UserDataProvider userInfo;
  final TextEditingController _mailController;
  final TextEditingController _passController;
  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return CustomAuthButton(
      title: 'Log In',
      onPressed: () {
        AuthMethods.logInMethod(
          context,
          isLoading,
          userInfo,
          email: _mailController.text.trim(),
          password: _passController.text.trim(),
          formKey: _formKey,
        );
      },
    );
  }
}
