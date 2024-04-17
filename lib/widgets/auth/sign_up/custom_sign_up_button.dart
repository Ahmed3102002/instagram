import 'package:flutter/material.dart';
import 'package:social/providers/is_loading_provider.dart';
import 'package:social/providers/user_image_provider.dart';
import 'package:social/utils/methods/auth_methods.dart';
import 'package:social/widgets/auth/custom_auth_button.dart';

class CustomSignUpButton extends StatelessWidget {
  const CustomSignUpButton({
    super.key,
    required this.isLoading,
    required this.userImageProvider,
    required this.fontColor,
    required TextEditingController mailController,
    required TextEditingController passController,
    required GlobalKey<FormState> formKey,
    required TextEditingController nameController,
  })  : _mailController = mailController,
        _passController = passController,
        _formKey = formKey,
        _nameController = nameController;

  final IsLoadingProvider isLoading;
  final UserImageProvider userImageProvider;
  final Color fontColor;
  final TextEditingController _mailController;
  final TextEditingController _passController;
  final GlobalKey<FormState> _formKey;
  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return CustomAuthButton(
        onPressed: () {
          AuthMethods.signUpMethod(
            isLoading,
            userImageProvider,
            context,
            fontColor,
            email: _mailController.text.trim(),
            password: _passController.text.trim(),
            formKey: _formKey,
            name: _nameController.text.trim(),
          );
        },
        title: 'Sign Up');
  }
}
