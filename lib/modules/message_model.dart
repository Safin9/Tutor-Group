// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MessageModel {
  String theSendersName;
  String theSenderUid;
  String message;
  DateTime sendAt;
  MessageModel({
    required this.theSendersName,
    required this.theSenderUid,
    required this.message,
    required this.sendAt,
  });

  MessageModel copyWith({
    String? theSendersName,
    String? theSenderUid,
    String? message,
    DateTime? sendAt,
  }) {
    return MessageModel(
      theSendersName: theSendersName ?? this.theSendersName,
      theSenderUid: theSenderUid ?? this.theSenderUid,
      message: message ?? this.message,
      sendAt: sendAt ?? this.sendAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'theSendersName': theSendersName,
      'theSenderUid': theSenderUid,
      'message': message,
      'sendAt': sendAt.millisecondsSinceEpoch,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      theSendersName: map['theSendersName'] as String,
      theSenderUid: map['theSenderUid'] as String,
      message: map['message'] as String,
      sendAt: DateTime.fromMillisecondsSinceEpoch(map['sendAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageModel(theSendersName: $theSendersName, theSenderUid: $theSenderUid, message: $message, sendAt: $sendAt)';
  }

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;

    return other.theSendersName == theSendersName &&
        other.theSenderUid == theSenderUid &&
        other.message == message &&
        other.sendAt == sendAt;
  }

  @override
  int get hashCode {
    return theSendersName.hashCode ^
        theSenderUid.hashCode ^
        message.hashCode ^
        sendAt.hashCode;
  }
}
