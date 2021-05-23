import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String userId;
  String userName;
  String email;
  String profileImage;
  Timestamp dateSignedUp;
  UserModel({
    this.userId,
    this.userName,
    this.email,
    this.profileImage,
    this.dateSignedUp,
  });

  UserModel copyWith({
    String userId,
    String userName,
    String email,
    String profileImage,
    Timestamp dateSignedUp,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      dateSignedUp: dateSignedUp ?? this.dateSignedUp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'email': email,
      'profileImage': profileImage,
      'dateSignedUp': dateSignedUp,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'],
      userName: map['userName'],
      email: map['email'],
      profileImage: map['profileImage'],
      dateSignedUp: map['dateSignedUp'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(userId: $userId, userName: $userName, email: $email, profileImage: $profileImage, dateSignedUp: $dateSignedUp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.userId == userId &&
        other.userName == userName &&
        other.email == email &&
        other.profileImage == profileImage &&
        other.dateSignedUp == dateSignedUp;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        userName.hashCode ^
        email.hashCode ^
        profileImage.hashCode ^
        dateSignedUp.hashCode;
  }
}
