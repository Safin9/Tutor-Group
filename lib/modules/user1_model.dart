// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserModel {
  String name;
  String? surName;
  String? imageUrl;
  DateTime createdAt;
  DateTime birthDate;
  String? shortBio;
  String currentCity;
  String? phone;
  String uid;
  List<String>? languages;
  DocumentReference? reference;
  UserModel({
    required this.name,
    this.surName,
    this.imageUrl,
    required this.createdAt,
    required this.birthDate,
    required this.currentCity,
    this.phone,
    required this.uid,
    this.languages,
  });

  UserModel copyWith({
    String? name,
    String? surName,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? birthDate,
    String? currentCity,
    String? phone,
    String? uid,
    List<String>? languages,
  }) {
    return UserModel(
      name: name ?? this.name,
      surName: surName ?? this.surName,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      birthDate: birthDate ?? this.birthDate,
      currentCity: currentCity ?? this.currentCity,
      phone: phone ?? this.phone,
      uid: uid ?? this.uid,
      languages: languages ?? this.languages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'surName': surName,
      'imageUrl': imageUrl,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'birthDate': birthDate.millisecondsSinceEpoch,
      'currentCity': currentCity,
      'phone': phone,
      'uid': uid,
      'languages': languages,
    };
  }

  factory UserModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    return UserModel.fromMap(documentSnapshot.data() as Map<String, dynamic>,
        reference: documentSnapshot.reference);
  }
  factory UserModel.fromMap(Map<String, dynamic> map,
      {DocumentReference? reference}) {
    return UserModel(
      name: map['name'] as String,
      surName: map['surName'] != null ? map['surName'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      birthDate: DateTime.fromMillisecondsSinceEpoch(map['birthDate'] as int),
      currentCity: map['currentCity'] as String,
      phone: map['phone'] != null ? map['phone'] as String : null,
      uid: map['uid'] as String,
      languages: map['languages'] != null
          ? List<String>.from((map['languages'] as List<String>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, surName: $surName, imageUrl: $imageUrl, createdAt: $createdAt, birthDate: $birthDate, currentCity: $currentCity, phone: $phone, uid: $uid, languages: $languages)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.surName == surName &&
        other.imageUrl == imageUrl &&
        other.createdAt == createdAt &&
        other.birthDate == birthDate &&
        other.currentCity == currentCity &&
        other.phone == phone &&
        other.uid == uid &&
        listEquals(other.languages, languages);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        surName.hashCode ^
        imageUrl.hashCode ^
        createdAt.hashCode ^
        birthDate.hashCode ^
        currentCity.hashCode ^
        phone.hashCode ^
        uid.hashCode ^
        languages.hashCode;
  }
}
