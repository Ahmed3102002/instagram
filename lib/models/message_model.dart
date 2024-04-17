import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

String uuid = const Uuid().v4();

class MessageModel {
  final String message, id, senderId;
  final Timestamp date;

  MessageModel({
    required this.message,
    required this.date,
    required this.senderId,
  }) : id = uuid;

  factory MessageModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return MessageModel(
      message: json['message'],
      date: json['date'],
      senderId: json['senderId'],
    );
  }
  Map<String, dynamic> toJson(MessageModel messageModel) {
    return {
      'id': messageModel.id,
      'message': messageModel.message,
      'senderId': messageModel.senderId,
      'date': messageModel.date,
    };
  }
}
