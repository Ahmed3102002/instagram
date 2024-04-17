import 'package:flutter/material.dart';

class CommentProvider extends ChangeNotifier {
  TextEditingController comment = TextEditingController();
  late List<Map<String, dynamic>> comments = [];
  List<Map<String, dynamic>> get getComments => comments;
  TextEditingController get getComment => comment;

  void setComment(TextEditingController? newComment) {
    newComment == null ? comment.text = '' : comment = newComment;
  }

  void setComments(List<Map<String, dynamic>> newComments) {
    comments = newComments;
    notifyListeners(); // Notify listeners outside the StreamBuilder
  }

  void get removeComment {
    comment.clear();
    notifyListeners();
  }
}
