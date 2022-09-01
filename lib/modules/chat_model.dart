// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChatModel {
  String myUid;
  String myName;
  String friendUid;
  String friendName;
  String docId;
  ChatModel({
    required this.myUid,
    required this.myName,
    required this.friendUid,
    required this.friendName,
    required this.docId,
  });

  ChatModel copyWith({
    String? myUid,
    String? myName,
    String? friendUid,
    String? friendName,
    String? docId,
  }) {
    return ChatModel(
      myUid: myUid ?? this.myUid,
      myName: myName ?? this.myName,
      friendUid: friendUid ?? this.friendUid,
      friendName: friendName ?? this.friendName,
      docId: docId ?? this.docId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'myUid': myUid,
      'myName': myName,
      'friendUid': friendUid,
      'friendName': friendName,
      'docId': docId,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      myUid: map['myUid'] as String,
      myName: map['myName'] as String,
      friendUid: map['friendUid'] as String,
      friendName: map['friendName'] as String,
      docId: map['docId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatModel(myUid: $myUid, myName: $myName, friendUid: $friendUid, friendName: $friendName, docId: $docId)';
  }

  @override
  bool operator ==(covariant ChatModel other) {
    if (identical(this, other)) return true;

    return other.myUid == myUid &&
        other.myName == myName &&
        other.friendUid == friendUid &&
        other.friendName == friendName &&
        other.docId == docId;
  }

  @override
  int get hashCode {
    return myUid.hashCode ^
        myName.hashCode ^
        friendUid.hashCode ^
        friendName.hashCode ^
        docId.hashCode;
  }
}
