import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  String? sender, receiver, message;
  Timestamp? timestamp;

  Chat(
      {required this.sender,
        required this.receiver,
        required this.message,
        required this.timestamp});

  factory Chat.fromMap(Map m1) {
    return Chat(
        sender: m1['sender'],
        receiver: m1['receiver'],
        message: m1['message'],
        timestamp: m1['timestamp']);
  }

  Map<String, dynamic> toMap(Chat chat) {
    return {
      'sender': chat.sender,
      'receiver': chat.receiver,
      'message': chat.message,
      'timestamp': chat.timestamp,
    };
  }
}