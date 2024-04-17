import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:social/providers/comment_provider.dart';
import 'package:social/widgets/text_form/custom_text_form.dart';

class AddCommentTextForm extends StatelessWidget {
  const AddCommentTextForm(
      {super.key,
      required TextEditingController commentController,
      this.maxLines = 1,
      this.isCommentPage = false,
      this.onPressed})
      : _commentController = commentController;

  final TextEditingController _commentController;
  final int maxLines;
  final bool isCommentPage;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).dividerColor;
    final CommentProvider commentProvider =
        Provider.of<CommentProvider>(context);
    return CustomTextForm(
      suffixIcon: isCommentPage
          ? IconButton(
              onPressed: onPressed,
              icon: Icon(
                IconlyLight.send,
                color: color,
              ),
            )
          : null,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus();
        return commentProvider.setComment(_commentController);
      },
      hintText: 'add comment ....',
      controller: _commentController,
      maxLines: maxLines,
      filled: false,
    );
  }
}
