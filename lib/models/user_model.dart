import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

String uuid = const Uuid().v4();

class UserModel {
  final String name, id, imageUrl, email;
  final List followers, following, posts, stories;

  UserModel({
    required this.stories,
    required this.posts,
    required this.followers,
    required this.following,
    required this.name,
    required this.email,
    required this.imageUrl,
  }) : id = FirebaseAuth.instance.currentUser!.uid;

  factory UserModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return UserModel(
      stories: json['stories'],
      posts: json['posts'],
      following: json['following'],
      followers: json['followers'],
      name: json['name'],
      email: json['email'],
      imageUrl: json['imageUrl'],
    );
  }
  Map<String, dynamic> toJson(UserModel userModel) {
    return {
      'id': userModel.id,
      'name': userModel.name,
      'email': userModel.email,
      'imageUrl': userModel.imageUrl,
      'posts': userModel.posts,
      'followers': userModel.followers,
      'following': userModel.following,
      'stories': userModel.stories,
    };
  }
}
