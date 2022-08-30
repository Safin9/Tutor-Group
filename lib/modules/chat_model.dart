// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:tutor_group/modules/message_model.dart';

class ChatModel {
  String myUid;
  String myName;
  String friendUid;
  String friendName;
  List<MessageModel> message;
  ChatModel({
    required this.myUid,
    required this.myName,
    required this.friendUid,
    required this.friendName,
    required this.message,
  });

  ChatModel copyWith({
    String? myUid,
    String? myName,
    String? friendUid,
    String? friendName,
    List<MessageModel>? message,
  }) {
    return ChatModel(
      myUid: myUid ?? this.myUid,
      myName: myName ?? this.myName,
      friendUid: friendUid ?? this.friendUid,
      friendName: friendName ?? this.friendName,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'myUid': myUid,
      'myName': myName,
      'friendUid': friendUid,
      'friendName': friendName,
      'message': message.map((x) => x.toMap()).toList(),
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      myUid: map['myUid'] as String,
      myName: map['myName'] as String,
      friendUid: map['friendUid'] as String,
      friendName: map['friendName'] as String,
      message: List<MessageModel>.from(
        (map['message'] as List<int>).map<MessageModel>(
          (x) => MessageModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatModel(myUid: $myUid, myName: $myName, friendUid: $friendUid, friendName: $friendName, message: $message)';
  }

  @override
  bool operator ==(covariant ChatModel other) {
    if (identical(this, other)) return true;

    return other.myUid == myUid &&
        other.myName == myName &&
        other.friendUid == friendUid &&
        other.friendName == friendName &&
        listEquals(other.message, message);
  }

  @override
  int get hashCode {
    return myUid.hashCode ^
        myName.hashCode ^
        friendUid.hashCode ^
        friendName.hashCode ^
        message.hashCode;
  }
}
