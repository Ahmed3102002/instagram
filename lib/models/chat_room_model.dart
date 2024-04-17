import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomModel {
  final String senderName,
      senderId,
      reciverName,
      reciverId,
      reciverImage,
      chatroomId;
  final List<String> participants;
  final Timestamp date;
  ChatRoomModel({
    required this.reciverName,
    required this.reciverId,
    required this.reciverImage,
    required this.senderName,
    required this.date,
    required this.senderId,
    required this.chatroomId,
  }) : participants = [senderId, reciverId];

  factory ChatRoomModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ChatRoomModel(
      senderName: json['senderName'],
      date: json['date'],
      senderId: json['senderId'],
      reciverName: json['reciverName'],
      reciverId: json['reciverId'],
      reciverImage: json['reciverImage'],
      chatroomId: json['chatroomId'],
    );
  }
  Map<String, dynamic> toJson(ChatRoomModel chatRoomModel) {
    return {
      'chatroomId': chatRoomModel.chatroomId,
      'senderName': chatRoomModel.senderName,
      'senderId': chatRoomModel.senderId,
      'reciverId': chatRoomModel.reciverId,
      'reciverName': chatRoomModel.reciverName,
      'reciverImage': chatRoomModel.reciverImage,
      'participants': chatRoomModel.participants,
      'date': chatRoomModel.date,
    };
  }
}
