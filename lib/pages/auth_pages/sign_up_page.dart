import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/providers/is_loading_provider.dart';
import 'package:social/providers/user_image_provider.dart';
import 'package:social/widgets/auth/custom_auth_by_others.dart';
import 'package:social/widgets/auth/custom_auth_page.dart';
import 'package:social/widgets/auth/custom_auth_question.dart';
import 'package:social/widgets/auth/custom_or.dart';
import 'package:social/widgets/auth/custom_title.dart';
import 'package:social/widgets/auth/sign_up/custom_sign_up_button.dart';
import 'package:social/widgets/auth/sign_up/new_user_image.dart';
import 'package:social/widgets/text_form/confirm_pass_text_form.dart';
import 'package:social/widgets/text_form/email_text_form.dart';
import 'package:social/widgets/text_form/pass_text_form.dart';

import '../../widgets/text_form/name_text_form.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  static const String routName = '/sign_up_page';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FocusNode _mailFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _passFocusNode = FocusNode();
  final FocusNode _comPassFocusNode = FocusNode();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _comPassController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _mailFocusNode.dispose();
    _nameFocusNode.dispose();
    _mailController.dispose();
    _passFocusNode.dispose();
    _comPassFocusNode.dispose();
    _passController.dispose();
    _comPassController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color fontColor = Theme.of(context).scaffoldBackgroundColor;
    final UserImageProvider userImageProvider =
        Provider.of<UserImageProvider>(context);
    final IsLoadingProvider isLoading = Provider.of<IsLoadingProvider>(context);
    final double height = MediaQuery.sizeOf(context).height;
    return CustomAuthPage(
      formKey: _formKey,
      children: [
        const CustomTitle(
          title: 'Create an account',
        ),
        const NewUserImage(),
        NameTextForm(
          mailFocusNode: _mailFocusNode,
          nameFocusNode: _nameFocusNode,
          nameController: _nameController,
        ),
        EmailTextForm(
          mailFocusNode: _mailFocusNode,
          mailController: _mailController,
          passwordFocusNode: _passFocusNode,
        ),
        PasswordTextForm(
          passwordFocusNode: _passFocusNode,
          passwordController: _passController,
          confirmPasswordFocusNode: _comPassFocusNode,
        ),
        ConfirmPasswordTextForm(
          passwordController: _passController,
          confirmPasswordFocusNode: _comPassFocusNode,
          confirmPasswordController: _comPassController,
        ),
        CustomSignUpButton(
            isLoading: isLoading,
            userImageProvider: userImageProvider,
            fontColor: fontColor,
            mailController: _mailController,
            passController: _passController,
            formKey: _formKey,
            nameController: _nameController),
        SizedBox(
          height: height * 0.001,
        ),
        const CustomAuthQuestion(
          isLogIn: false,
        ),
        const CustomOR(),
        SizedBox(
          height: height * 0.02,
        ),
        const CustomAuthByOthers(),
      ],
    );
  }
}
