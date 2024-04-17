import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

String uuid = const Uuid().v4();

class CommentModel {
  final String userName, postId, commentId, userImage, comment, userId;
  final Timestamp dateOfComment;
  final bool isLike;
  final int likesCount;
  CommentModel({
    required this.isLike,
    required this.likesCount,
    required this.dateOfComment,
    required this.comment,
    required this.userName,
    required this.userImage,
    required this.userId,
    required this.postId,
  }) : commentId = uuid;

  factory CommentModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return CommentModel(
        userName: json['userName'],
        userImage: json['userImage'],
        comment: json['comment'],
        userId: json['userId'],
        dateOfComment: json['dateOfComment'],
        postId: json['postId'],
        isLike: json['isLike'],
        likesCount: json['likesCount']);
  }
  Map<String, dynamic> toJson(CommentModel commentModel) {
    return {
      'userId': commentModel.userId,
      'userName': commentModel.userName,
      'userImage': commentModel.userImage,
      'comment': commentModel.comment,
      'postId': commentModel.postId,
      'dateOfComment': commentModel.dateOfComment,
      'commentId': commentModel.commentId,
      'likesCount': commentModel.likesCount,
      'isLike': commentModel.isLike
    };
  }
}
