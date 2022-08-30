// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MessageModel {
  String theSendersName;
  String theSenderUid;
  String message;
  MessageModel({
    required this.theSendersName,
    required this.theSenderUid,
    required this.message,
  });

  MessageModel copyWith({
    String? theSendersName,
    String? theSenderUid,
    String? message,
  }) {
    return MessageModel(
      theSendersName: theSendersName ?? this.theSendersName,
      theSenderUid: theSenderUid ?? this.theSenderUid,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'theSendersName': theSendersName,
      'theSenderUid': theSenderUid,
      'message': message,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      theSendersName: map['theSendersName'] as String,
      theSenderUid: map['theSenderUid'] as String,
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'MessageModel(theSendersName: $theSendersName, theSenderUid: $theSenderUid, message: $message)';

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;

    return other.theSendersName == theSendersName &&
        other.theSenderUid == theSenderUid &&
        other.message == message;
  }

  @override
  int get hashCode =>
      theSendersName.hashCode ^ theSenderUid.hashCode ^ message.hashCode;
}
