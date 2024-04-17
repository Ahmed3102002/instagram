import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:social/widgets/text_form/custom_text_form.dart';

class EmailTextForm extends StatelessWidget {
  const EmailTextForm({
    super.key,
    FocusNode? passwordFocusNode,
    required FocusNode mailFocusNode,
    required TextEditingController mailController,
  })  : _passwordFocusNode = passwordFocusNode,
        _mailFocusNode = mailFocusNode,
        _mailController = mailController;

  final FocusNode? _passwordFocusNode;
  final FocusNode _mailFocusNode;
  final TextEditingController _mailController;
  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).scaffoldBackgroundColor;
    return CustomTextForm(
      validator: (value) {
        const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
            r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
            r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
            r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
            r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
            r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
            r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
        final regex = RegExp(pattern);
        if (value == null || value.isEmpty) {
          return 'Please enter your e_mail';
        }
        if (!regex.hasMatch(value)) {
          return 'Please enter a valid e_mail';
        } else {
          return null;
        }
      },
      onFieldSubmitted: (value) {
        _passwordFocusNode == null
            ? FocusScope.of(context).requestFocus()
            : FocusScope.of(context).requestFocus(_passwordFocusNode);
      },
      keyboardType: TextInputType.emailAddress,
      focusNode: _mailFocusNode,
      hintText: 'Enter your e_mail',
      color: color,
      controller: _mailController,
      prefixIcon: Icon(
        IconlyBroken.login,
        color: color,
      ),
    );
  }
}
