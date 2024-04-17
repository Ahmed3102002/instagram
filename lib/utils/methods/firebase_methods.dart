import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:social/models/chat_room_model.dart';
import 'package:social/models/comment_model.dart';
import 'package:social/models/message_model.dart';
import 'package:social/models/post_model.dart';
import 'package:social/models/story_model.dart';
import 'package:social/models/user_model.dart';
import 'package:social/providers/user_data_provider.dart';
import 'package:social/providers/user_image_provider.dart';
import 'package:social/providers/video_provider.dart';
import 'package:social/utils/constants.dart';
import 'package:social/utils/methods/app_methods.dart';
import 'package:uuid/uuid.dart';

class FirebaseMethods {
  static Future<Map<String, dynamic>?> getUserDatabyId(String userId) async {
    try {
      // تحميل بيانات المستخدم
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userSnapshot.exists) {
        return userSnapshot.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (error) {
      log(error.toString());
    }
    return null;
  }

  static Future<void> upLoadUserDataToFirebase(BuildContext context,
      UserImageProvider userImageProvider, String name, String email) async {
    try {
      final Reference ref = FirebaseStorage.instance
          .ref()
          .child(ConstantVariables.path)
          .child(ConstantVariables.imagePath);
      await ref.putFile(
        userImageProvider.getUserImage!,
      );
      final image = await ref.getDownloadURL();
      final userdata = UserModel(
          stories: [],
          posts: [],
          followers: [],
          following: [],
          name: name,
          email: email,
          imageUrl: image);

      await FirebaseFirestore.instance
          .collection(ConstantVariables.collectionPath)
          .doc(ConstantVariables.uid2)
          .set(userdata.toJson(userdata));
      log('done');
    } on FirebaseException catch (error) {
      if (context.mounted) {
        AppMethods.showFirebaseAuthException(context, error);
      }
    }
  }

  static Future<UserModel> getUserDataFromFirebase(
      {required String userId}) async {
    DocumentSnapshot<Map<String, dynamic>>? snapshot = await FirebaseFirestore
        .instance
        .collection(ConstantVariables.collectionPath)
        .doc(userId)
        .get();

    try {
      return UserModel.fromJson(snapshot.data()!);
    } on FirebaseException catch (e) {
      throw Exception('User data not found! ${e.code}');
    }
  }

  static Future<void> upLoadPostToFirebase(
    BuildContext context,
    UserImageProvider userImageProvider,
    UserDataProvider userProvider,
    TextEditingController descriptonOfPost,
  ) async {
    try {
      final Reference ref = FirebaseStorage.instance
          .ref()
          .child('all_posts')
          .child(ConstantVariables.imagePath);
      await ref.putFile(
        userImageProvider.getUserImage!,
      );
      final postImageUrl = await ref.getDownloadURL();
      final PostModel postModel = PostModel(
          dateOfPost: Timestamp.now(),
          descriptonOfPost: descriptonOfPost.text,
          userName: userProvider.getUserData.name,
          userImage: userProvider.getUserData.imageUrl,
          postImageUrl: postImageUrl,
          userId: userProvider.getUserData.id,
          isLike: false,
          likesCount: 0);
      await FirebaseFirestore.instance
          .collection('all_posts')
          .doc(postModel.postId)
          .set(postModel.toJson(postModel));
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userProvider.getUserData.id)
          .update({
        'posts': FieldValue.arrayUnion([postModel.postId]),
      });
      userImageProvider.removeUserImage;
      descriptonOfPost.clear();
    } on FirebaseException catch (e) {
      if (context.mounted) AppMethods.showUserImageError(context, e);
    }
  }

  static Future<void> upDatePostData(
      BuildContext context, String postId, int likesCount, bool isLike) async {
    try {
      await FirebaseFirestore.instance
          .collection('all_posts')
          .doc(postId)
          .update({
        'islike': isLike,
        'likesCount': isLike ? likesCount + 1 : likesCount - 1
      });
    } on FirebaseException catch (e) {
      if (context.mounted) AppMethods.showUserImageError(context, e);
    }
  }

  static Future<void> addComment(
    BuildContext context,
    String postId,
    UserDataProvider userProvider,
    TextEditingController commentController,
  ) async {
    try {
      final CommentModel commentModel = CommentModel(
          dateOfComment: Timestamp.now(),
          isLike: false,
          likesCount: 0,
          comment: commentController.text,
          userName: userProvider.getUserData.name,
          userImage: userProvider.getUserData.imageUrl,
          userId: userProvider.getUserData.id,
          postId: postId);
      if (commentController.text.trim().isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('all_posts')
            .doc(postId)
            .collection('comments')
            .doc(commentModel.commentId)
            .set(
              commentModel.toJson(commentModel),
            );
        commentController.clear();
      }
    } on FirebaseException catch (e) {
      if (context.mounted) AppMethods.showUserImageError(context, e);
    }
  }

  static Future<void> deletePost({required String postId}) async {
    await FirebaseFirestore.instance
        .collection('all_posts')
        .doc(postId)
        .delete();
  }

  static Future<void> deleteStory({required Map story}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(story['userId'])
        .update({
      'stories': FieldValue.arrayRemove([story])
    });
  }

  static Future<void> deleteStoryAfter24({required Map story}) async {
    if (DateTime.now().difference(story['dateOfStory'].toDate).inHours > 24) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(story['userId'])
          .update({
        'stories': FieldValue.arrayRemove([story])
      });
    }
  }

  static Future<void> addFollow({required String userId}) async {
    if (userId != FirebaseAuth.instance.currentUser!.uid) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'following': FieldValue.arrayUnion([userId]),
      });
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'followers':
            FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid]),
      });
    }
  }

  static Future<void> unFollow({required String userId}) async {
    if (userId != FirebaseAuth.instance.currentUser!.uid) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'following': FieldValue.arrayRemove([userId]),
      });
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'followers':
            FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid]),
      });
    }
  }

  static Future<void> addStory(
    UserImageProvider userImageProvider, {
    required VideoProvider videoProvider,
    required UserDataProvider userDataProvider,
  }) async {
    String uuid = const Uuid().v4();
    final Reference ref =
        FirebaseStorage.instance.ref().child('stories').child(uuid);
    await ref.putFile(
      videoProvider.getIsVideo
          ? videoProvider.getVideo!
          : userImageProvider.getUserImage!,
    );
    final storyUrl = await ref.getDownloadURL();
    StoryModel storyModel = StoryModel(
        type: videoProvider.getIsVideo ? 'video' : 'image',
        storyId: uuid,
        userName: userDataProvider.getUserData.name,
        userImage: userDataProvider.getUserData.imageUrl,
        storyUrl: storyUrl,
        userId: userDataProvider.getUserData.id,
        dateOfStory: Timestamp.now(),
        viewers: []);
    videoProvider.getIsVideo
        ? videoProvider.removeVideo
        : userImageProvider.removeUserImage;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'stories': FieldValue.arrayUnion([storyModel.toJson(storyModel)]),
    });
  }

  static Future<StoryModel> getStoryFromFirebase(
      {required String userId}) async {
    DocumentSnapshot<Map<String, dynamic>>? snapshot = await FirebaseFirestore
        .instance
        .collection(ConstantVariables.collectionPath)
        .doc(userId)
        .get();

    try {
      return StoryModel.fromJson(snapshot.data()!['stories']);
    } on FirebaseException catch (e) {
      throw Exception('User data not found! ${e.code}');
    }
  }

  static Future<void> upLoadChatToFirebase(
      UserDataProvider userDataProvider,
      Map<String, dynamic>? userData,
      TextEditingController textController) async {
    if (textController.text.trim().isNotEmpty) {
      ChatRoomModel chatRoomModel = ChatRoomModel(
          chatroomId: AppMethods.getChatroomId(
              senderId: userDataProvider.getUserData.id,
              reciverId: userData!['id']),
          reciverName: userData['name'],
          reciverId: userData['id'],
          reciverImage: userData['imageUrl'],
          senderName: userDataProvider.getUserData.name,
          date: Timestamp.now(),
          senderId: userDataProvider.getUserData.id);
      MessageModel messageModel = MessageModel(
          message: textController.text,
          date: Timestamp.now(),
          senderId: FirebaseAuth.instance.currentUser!.uid);
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(chatRoomModel.chatroomId)
          .set(chatRoomModel.toJson(chatRoomModel));
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(chatRoomModel.chatroomId)
          .collection('messages')
          .doc(messageModel.id)
          .set(messageModel.toJson(messageModel));
    }
  }

  static Future<void> deleteChat({required String chatRoomId}) async {
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatRoomId)
        .delete();
  }

  static Future<void> deleteMessage({
    required String chatRoomId,
    required String messageId,
  }) async {
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .doc(messageId)
        .delete();
  }
}
