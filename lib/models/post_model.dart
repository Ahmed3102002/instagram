import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

String uuid = const Uuid().v4();

class PostModel {
  final String userName,
      postId,
      postImageUrl,
      userImage,
      descriptonOfPost,
      userId;
  final Timestamp dateOfPost;
  final bool isLike;
  final int likesCount;
  PostModel({
    required this.descriptonOfPost,
    required this.userName,
    required this.userImage,
    required this.postImageUrl,
    required this.userId,
    required this.dateOfPost,
    required this.isLike,
    required this.likesCount,
  }) : postId = uuid;

  factory PostModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return PostModel(
      userName: json['userName'],
      userImage: json['userImage'],
      postImageUrl: json['postImageUrl'],
      descriptonOfPost: json['descriptonOfPost'],
      userId: json['userId'],
      dateOfPost: json['dateOfPost'],
      isLike: json['islike'],
      likesCount: json['likesCount'],
    );
  }
  Map<String, dynamic> toJson(PostModel postModel) {
    return {
      'userId': postModel.userId,
      'userName': postModel.userName,
      'userImage': postModel.userImage,
      'postImageUrl': postModel.postImageUrl,
      'descriptonOfPost': postModel.descriptonOfPost,
      'dateOfPost': postModel.dateOfPost,
      'islike': postModel.isLike,
      'likesCount': postModel.likesCount,
      'postId': postModel.postId,
    };
  }
}
