// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChatModel {
  String myUid;
  String friendUid;
  String docId;
  ChatModel({
    required this.myUid,
    required this.friendUid,
    required this.docId,
  });

  ChatModel copyWith({
    String? myUid,
    String? friendUid,
    String? docId,
  }) {
    return ChatModel(
      myUid: myUid ?? this.myUid,
      friendUid: friendUid ?? this.friendUid,
      docId: docId ?? this.docId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'myUid': myUid,
      'friendUid': friendUid,
      'docId': docId,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      myUid: map['myUid'] as String,
      friendUid: map['friendUid'] as String,
      docId: map['docId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ChatModel(myUid: $myUid, friendUid: $friendUid, docId: $docId)';

  @override
  bool operator ==(covariant ChatModel other) {
    if (identical(this, other)) return true;

    return other.myUid == myUid &&
        other.friendUid == friendUid &&
        other.docId == docId;
  }

  @override
  int get hashCode => myUid.hashCode ^ friendUid.hashCode ^ docId.hashCode;
}
