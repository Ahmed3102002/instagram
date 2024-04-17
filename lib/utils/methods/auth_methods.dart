import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/pages/auth_pages/log_in_page.dart';
import 'package:social/pages/root_page.dart';
import 'package:social/providers/is_loading_provider.dart';
import 'package:social/providers/user_data_provider.dart';
import 'package:social/providers/user_image_provider.dart';
import 'package:social/utils/methods/app_methods.dart';
import 'package:social/utils/methods/firebase_methods.dart';

class AuthMethods {
  static void signUpMethod(
      IsLoadingProvider isLoading,
      UserImageProvider userImageProvider,
      BuildContext context,
      Color fontColor,
      {required String name,
      required String email,
      required String password,
      required GlobalKey<FormState> formKey}) async {
    if (formKey.currentState!.validate() &&
        userImageProvider.getUserImage != null) {
      isLoading.setIsLoading;
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        if (context.mounted) {
          await FirebaseMethods.upLoadUserDataToFirebase(
              context, userImageProvider, name, email);
        }
        if (userImageProvider.getUserImage != null) {
          userImageProvider.removeUserImage;
        }
        isLoading.setIsLoading;
        if (context.mounted) {
          await Navigator.pushReplacementNamed(context, LogInPage.routName);
        }
      } on FirebaseAuthException catch (e) {
        isLoading.setIsLoading;
        if (context.mounted) AppMethods.showFirebaseAuthException(context, e);
      }
    }
    if (formKey.currentState!.validate() &&
        userImageProvider.getUserImage == null) {
      if (context.mounted) {
        await AppMethods.showUserImageError(context, null);
      }
    }
  }

  static void logInMethod(BuildContext context, IsLoadingProvider isLoading,
      UserDataProvider userInfo,
      {required String email,
      required String password,
      required GlobalKey<FormState> formKey}) async {
    if (formKey.currentState!.validate()) {
      isLoading.setIsLoading;
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        await FirebaseAuth.instance.currentUser!.reload();
        userInfo.fetchUserData(userId: FirebaseAuth.instance.currentUser!.uid);
        if (context.mounted) {
          if (Provider.of<UserImageProvider>(context, listen: false)
                  .getUserImage !=
              null) {
            Provider.of<UserImageProvider>(context, listen: false)
                .removeUserImage;
          }
        }

        if (context.mounted) {
          await Navigator.pushReplacementNamed(context, RootPage.routName);
        }

        isLoading.setIsLoading;
      } on FirebaseAuthException catch (e) {
        isLoading.setIsLoading;
        if (context.mounted) AppMethods.showFirebaseAuthException(context, e);
      }
    }
  }

  static void restPasswordMethod(
      BuildContext context, IsLoadingProvider isLoading,
      {required String email, required GlobalKey<FormState> formKey}) async {
    if (formKey.currentState!.validate()) {
      isLoading.setIsLoading;
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: email,
        );
        isLoading.setIsLoading;
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, LogInPage.routName);
        }
      } on FirebaseAuthException catch (e) {
        isLoading.setIsLoading;
        if (context.mounted) AppMethods.showFirebaseAuthException(context, e);
      }
    }
  }
}
