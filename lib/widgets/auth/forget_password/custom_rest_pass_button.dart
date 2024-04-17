import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:social/providers/is_loading_provider.dart';
import 'package:social/utils/methods/auth_methods.dart';
import 'package:social/widgets/others/custom_elevated_button_with_icon.dart';

class CustomRestPassButton extends StatelessWidget {
  const CustomRestPassButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.isLoading,
    required TextEditingController mailController,
  })  : _formKey = formKey,
        _mailController = mailController;

  final GlobalKey<FormState> _formKey;
  final IsLoadingProvider isLoading;
  final TextEditingController _mailController;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButtonWithIcon(
      title: 'Rest Password',
      onPressed: () {
        AuthMethods.restPasswordMethod(
          formKey: _formKey,
          context,
          isLoading,
          email: _mailController.text.trim(),
        );
      },
      icon: IconlyBroken.send,
    );
  }
}
