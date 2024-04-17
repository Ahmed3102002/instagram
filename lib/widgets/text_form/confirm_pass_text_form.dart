import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:social/providers/show_pass_provider.dart';
import 'package:social/utils/colors/app_colors.dart';
import 'package:social/widgets/text_form/custom_text_form.dart';

class ConfirmPasswordTextForm extends StatelessWidget {
  const ConfirmPasswordTextForm({
    super.key,
    required TextEditingController passwordController,
    required FocusNode confirmPasswordFocusNode,
    required TextEditingController confirmPasswordController,
  })  : _passwordController = passwordController,
        _confirmPasswordFocusNode = confirmPasswordFocusNode,
        _confirmPasswordController = confirmPasswordController;

  final TextEditingController _passwordController;
  final FocusNode _confirmPasswordFocusNode;
  final TextEditingController _confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).scaffoldBackgroundColor;
    final ShowPassProvider showPass = Provider.of<ShowPassProvider>(context);
    return CustomTextForm(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password again';
        }
        if (value.trim() != _passwordController.text.trim()) {
          return 'Passwords do`nt match';
        } else {
          return null;
        }
      },
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus;
      },
      obscureText: showPass.showPassValue,
      keyboardType: TextInputType.visiblePassword,
      focusNode: _confirmPasswordFocusNode,
      color: color,
      hintText: 'Enter your password again',
      controller: _confirmPasswordController,
      prefixIcon: Icon(
        IconlyBroken.password,
        color: AppColors.lightPrimaryColor,
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
