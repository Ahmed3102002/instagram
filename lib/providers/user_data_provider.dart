import 'package:flutter/material.dart';
import 'package:social/models/user_model.dart';
import 'package:social/utils/methods/firebase_methods.dart';

class UserDataProvider with ChangeNotifier {
  late UserModel user;
  UserModel get getUserData => user;
  void fetchUserData({required String userId}) async {
    user = await FirebaseMethods.getUserDataFromFirebase(userId: userId);
    notifyListeners();
  }

  void deleteStory({required Map story}) async {
    user.stories.removeWhere((element) => element == story);
    notifyListeners();
  }
}
