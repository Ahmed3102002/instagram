import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:social/widgets/text_form/custom_text_form.dart';

class NameTextForm extends StatelessWidget {
  const NameTextForm({
    super.key,
    required FocusNode mailFocusNode,
    required FocusNode nameFocusNode,
    required TextEditingController nameController,
  })  : _mailFocusNode = mailFocusNode,
        _nameFocusNode = nameFocusNode,
        _nameController = nameController;

  final FocusNode _mailFocusNode;
  final FocusNode _nameFocusNode;
  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).scaffoldBackgroundColor;
    return CustomTextForm(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your name';
        }
        if (value.trim().length < 3) {
          return 'Name must be at least 3 characters';
        } else {
          return null;
        }
      },
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_mailFocusNode);
      },
      keyboardType: TextInputType.text,
      focusNode: _nameFocusNode,
      hintText: 'Enter your name',
      controller: _nameController,
      color: color,
      prefixIcon: Icon(
        IconlyBroken.user2,
        color: color,
      ),
    );
  }
}
