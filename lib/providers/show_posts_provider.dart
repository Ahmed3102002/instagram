import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ShowPostsProvider with ChangeNotifier {
  late List<Map<String, dynamic>> posts = [];

  List<Map<String, dynamic>> get getPosts => posts;

  void setPosts(List<Map<String, dynamic>> newPosts) {
    posts = newPosts;
    Future.microtask(() {
      notifyListeners();
    });
  }

  void deletePost(Map<String, dynamic> newPosts) {
    newPosts['userId'] == FirebaseAuth.instance.currentUser!.uid;
    Future.microtask(() {
      notifyListeners();
    });
  }
}
