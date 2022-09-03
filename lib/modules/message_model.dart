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
  FieldValue sentAt;
  MessageModel({
    required this.message,
    required this.senderUid,
    required this.senderName,
    required this.recieverUid,
    required this.recieverName,
    required this.messageType,
    required this.sentAt,
  });

  MessageModel copyWith({
    String? message,
    String? senderUid,
    String? senderName,
    String? recieverUid,
    String? recieverName,
    String? messageType,
    FieldValue? sentAt,
  }) {
    return MessageModel(
      message: message ?? this.message,
      senderUid: senderUid ?? this.senderUid,
      senderName: senderName ?? this.senderName,
      recieverUid: recieverUid ?? this.recieverUid,
      recieverName: recieverName ?? this.recieverName,
      messageType: messageType ?? this.messageType,
      sentAt: sentAt ?? this.sentAt,
    );
  }

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

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      message: map['message'] as String,
      senderUid: map['senderUid'] as String,
      senderName: map['senderName'] as String,
      recieverUid: map['recieverUid'] as String,
      recieverName: map['recieverName'] as String,
      messageType: map['messageType'] as String,
      sentAt: map['sentAt'] as FieldValue,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

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
