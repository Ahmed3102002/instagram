import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:social/providers/show_pass_provider.dart';
import 'package:social/widgets/text_form/custom_text_form.dart';

class PasswordTextForm extends StatelessWidget {
  const PasswordTextForm({
    super.key,
    FocusNode? confirmPasswordFocusNode,
    required FocusNode passwordFocusNode,
    required TextEditingController passwordController,
  })  : _confirmPasswordFocusNode = confirmPasswordFocusNode,
        _passwordFocusNode = passwordFocusNode,
        _passwordController = passwordController;
  final FocusNode? _confirmPasswordFocusNode;
  final FocusNode _passwordFocusNode;

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).scaffoldBackgroundColor;
    final ShowPassProvider showPass = Provider.of<ShowPassProvider>(context);
    return CustomTextForm(
      onFieldSubmitted: (value) {
        _confirmPasswordFocusNode == null
            ? FocusScope.of(context).requestFocus
            : FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        if (value.trim().length < 8) {
          return 'Password must be at least 8 characters';
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.visiblePassword,
      focusNode: _passwordFocusNode,
      obscureText: showPass.showPassValue,
      hintText: 'Enter your password',
      controller: _passwordController,
      color: color,
      prefixIcon: Icon(
        IconlyBroken.password,
        color: color,
      ),
      suffixIcon: IconButton(
        onPressed: () {
          showPass.setShowPassValue();
        },
        icon: Icon(
          showPass.showPassValue ? IconlyBroken.show : IconlyBroken.hide,
          color: color,
        ),
      ),
    );
  }
}
