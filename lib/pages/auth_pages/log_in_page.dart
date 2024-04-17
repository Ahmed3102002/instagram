import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/providers/is_loading_provider.dart';
import 'package:social/providers/user_data_provider.dart';
import 'package:social/widgets/auth/custom_auth_by_others.dart';
import 'package:social/widgets/auth/custom_auth_page.dart';
import 'package:social/widgets/auth/custom_auth_question.dart';
import 'package:social/widgets/auth/custom_or.dart';
import 'package:social/widgets/auth/custom_title.dart';
import 'package:social/widgets/auth/log_in/custom_log_in_button.dart';
import 'package:social/widgets/auth/log_in/custom_rest_password.dart';
import 'package:social/widgets/text_form/email_text_form.dart';
import 'package:social/widgets/text_form/pass_text_form.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});
  static const String routName = '/log_in_page';

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final FocusNode _mailFocusNode = FocusNode();
  final FocusNode _passFocusNode = FocusNode();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _mailController.dispose();
    _passController.dispose();
    _mailFocusNode.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<UserDataProvider>(context);
    final IsLoadingProvider isLoading = Provider.of<IsLoadingProvider>(context);

    var height2 = MediaQuery.sizeOf(context).height * 0.02;
    return CustomAuthPage(
      formKey: _formKey,
      children: [
        const CustomTitle(
          title: 'Log In',
        ),
        SizedBox(
          height: height2,
        ),
        EmailTextForm(
          mailFocusNode: _mailFocusNode,
          mailController: _mailController,
          passwordFocusNode: _passFocusNode,
        ),
        PasswordTextForm(
          passwordFocusNode: _passFocusNode,
          passwordController: _passController,
        ),
        const CustomRestPassword(),
        CustomLogInButton(
            userInfo: userInfo,
            isLoading: isLoading,
            mailController: _mailController,
            passController: _passController,
            formKey: _formKey),
        const CustomAuthQuestion(),
        const CustomOR(),
        SizedBox(
          height: height2,
        ),
        const CustomAuthByOthers(),
      ],
    );
  }
}
