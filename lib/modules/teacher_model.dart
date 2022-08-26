// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

class TeacherModel {
  String name;
  String surname;
  String email;
  String lessonType;
  String currentCity;
  String gender;
  String uid;
  String imageUrl;
  String? shortbio;
  String phoneNumber;
  List<String> languages;
  TeacherModel({
    required this.name,
    required this.surname,
    required this.email,
    required this.lessonType,
    required this.currentCity,
    required this.gender,
    required this.uid,
    required this.imageUrl,
    this.shortbio,
    required this.phoneNumber,
    required this.languages,
  });

  TeacherModel copyWith({
    String? name,
    String? surname,
    String? email,
    String? lessonType,
    String? currentCity,
    String? gender,
    String? uid,
    String? imageUrl,
    String? shortbio,
    String? phoneNumber,
    List<String>? languages,
  }) {
    return TeacherModel(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      lessonType: lessonType ?? this.lessonType,
      currentCity: currentCity ?? this.currentCity,
      gender: gender ?? this.gender,
      uid: uid ?? this.uid,
      imageUrl: imageUrl ?? this.imageUrl,
      shortbio: shortbio ?? this.shortbio,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      languages: languages ?? this.languages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'surname': surname,
      'email': email,
      'lessonType': lessonType,
      'currentCity': currentCity,
      'gender': gender,
      'uid': uid,
      'imageUrl': imageUrl,
      'shortbio': shortbio,
      'phoneNumber': phoneNumber,
      'languages': languages,
    };
  }

  factory TeacherModel.fromMap(Map<String, dynamic> map) {
    return TeacherModel(
        name: map['name'] as String,
        surname: map['surname'] as String,
        email: map['email'] as String,
        lessonType: map['lessonType'] as String,
        currentCity: map['currentCity'] as String,
        gender: map['gender'] as String,
        uid: map['uid'] as String,
        imageUrl: map['imageUrl'] as String,
        shortbio: map['shortbio'] != null ? map['shortbio'] as String : null,
        phoneNumber: map['phoneNumber'] as String,
        languages: List<String>.from(
          (map['languages'] as List<String>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory TeacherModel.fromJson(String source) =>
      TeacherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TeacherModel(name: $name, surname: $surname, email: $email, lessonType: $lessonType, currentCity: $currentCity, gender: $gender, uid: $uid, imageUrl: $imageUrl, shortbio: $shortbio, phoneNumber: $phoneNumber, languages: $languages)';
  }

  @override
  bool operator ==(covariant TeacherModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.name == name &&
        other.surname == surname &&
        other.email == email &&
        other.lessonType == lessonType &&
        other.currentCity == currentCity &&
        other.gender == gender &&
        other.uid == uid &&
        other.imageUrl == imageUrl &&
        other.shortbio == shortbio &&
        other.phoneNumber == phoneNumber &&
        listEquals(other.languages, languages);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        surname.hashCode ^
        email.hashCode ^
        lessonType.hashCode ^
        currentCity.hashCode ^
        gender.hashCode ^
        uid.hashCode ^
        imageUrl.hashCode ^
        shortbio.hashCode ^
        phoneNumber.hashCode ^
        languages.hashCode;
  }
}
