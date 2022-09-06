// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String message;
  String senderUid;
  String senderName;
  String recieverUid;
  String recieverName;
  String messageType;
  Timestamp sentAt;
  MessageModel({
    required this.message,
    required this.senderUid,
    required this.senderName,
    required this.recieverUid,
    required this.recieverName,
    required this.messageType,
    required this.sentAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'senderUid': senderUid,
      'senderName': senderName,
      'recieverUid': recieverUid,
      'recieverName': recieverName,
      'messageType': messageType,
      'sentAt': sentAt,
    };
  }

  factory MessageModel.fromSnapShot(
      QuerySnapshot<Map<String, dynamic>> snapshot, int index) {
    return MessageModel.fromMap(snapshot, index);
  }
  factory MessageModel.fromMap(
      QuerySnapshot<Map<String, dynamic>> map, int index,
      {DocumentReference? reference}) {
    return MessageModel(
      message: map.docs[index]['message'] as String,
      senderUid: map.docs[index]['senderUid'] as String,
      senderName: map.docs[index]['senderName'] as String,
      recieverUid: map.docs[index]['recieverUid'] as String,
      recieverName: map.docs[index]['recieverName'] as String,
      messageType: map.docs[index]['messageType'] as String,
      sentAt: map.docs[index]['sentAt'] as Timestamp,
    );
  }

  String toJson() => json.encode(toMap());

  // factory MessageModel.fromJson(String source) =>
  //     MessageModel.fromMap(json.decode(source) as Map<String, dynamic> );

  @override
  String toString() {
    return 'MessageModel(message: $message, senderUid: $senderUid, senderName: $senderName, recieverUid: $recieverUid, recieverName: $recieverName, messageType: $messageType, sentAt: $sentAt)';
  }

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;

    return other.message == message &&
        other.senderUid == senderUid &&
        other.senderName == senderName &&
        other.recieverUid == recieverUid &&
        other.recieverName == recieverName &&
        other.messageType == messageType &&
        other.sentAt == sentAt;
  }

  @override
  int get hashCode {
    return message.hashCode ^
        senderUid.hashCode ^
        senderName.hashCode ^
        recieverUid.hashCode ^
        recieverName.hashCode ^
        messageType.hashCode ^
        sentAt.hashCode;
  }
}
