import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/providers/is_loading_provider.dart';
import 'package:social/widgets/auth/custom_auth_page.dart';
import 'package:social/widgets/auth/custom_title.dart';
import 'package:social/widgets/auth/forget_password/custom_rest_pass_button.dart';
import 'package:social/widgets/text_form/email_text_form.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});
  static const String routName = '/forget_password_page';

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final FocusNode _mailFocusNode = FocusNode();
  final TextEditingController _mailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _mailController.dispose();
    _mailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final IsLoadingProvider isLoading = Provider.of<IsLoadingProvider>(context);
    var height = MediaQuery.sizeOf(context).height;
    return CustomAuthPage(
      formKey: _formKey,
      children: [
        const CustomTitle(
          title: 'Forget Password',
        ),
        SizedBox(
          height: height * 0.02,
        ),
        EmailTextForm(
          mailFocusNode: _mailFocusNode,
          mailController: _mailController,
        ),
        CustomRestPassButton(
          formKey: _formKey,
          isLoading: isLoading,
          mailController: _mailController,
        ),
      ],
    );
  }
}
