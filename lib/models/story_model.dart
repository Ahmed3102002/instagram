import 'package:cloud_firestore/cloud_firestore.dart';

class StoryModel {
  final String userName, storyId, storyUrl, userImage, userId, type;
  final Timestamp dateOfStory;
  final List viewers;
  StoryModel({
    required this.type,
    required this.userName,
    required this.userImage,
    required this.storyUrl,
    required this.userId,
    required this.dateOfStory,
    required this.viewers,
    required this.storyId,
  });

  factory StoryModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return StoryModel(
      type: json['type'],
      storyId: json['storyId'],
      userName: json['userName'],
      userImage: json['userImage'],
      storyUrl: json['storyUrl'],
      userId: json['userId'],
      dateOfStory: json['dateOfStory'],
      viewers: json['viewers'],
    );
  }
  Map<String, dynamic> toJson(StoryModel storyModel) {
    return {
      'type': storyModel.type,
      'storyId': storyModel.storyId,
      'userId': storyModel.userId,
      'userName': storyModel.userName,
      'userImage': storyModel.userImage,
      'storyUrl': storyModel.storyUrl,
      'dateOfStory': storyModel.dateOfStory,
      'viewers': storyModel.viewers,
    };
  }
}
