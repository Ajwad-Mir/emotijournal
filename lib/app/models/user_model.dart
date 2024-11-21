import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userID;
  final String fullName;
  final String emailAddress;
  final String password;
  final String profileImageLink;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  UserModel({
    required this.userID,
    required this.fullName,
    required this.emailAddress,
    required this.password,
    required this.profileImageLink,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.empty() {
    return UserModel(
      userID: "",
      fullName: "",
      emailAddress: "",
      password: "",
      profileImageLink: "",
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    );
  }

  factory UserModel.createNewUser({
    required String fullName,
    required String emailAddress,
    required String password,
    required String profileImageLink,
  }) {
    return UserModel(
      userID: "",
      fullName: fullName,
      emailAddress: emailAddress,
      password: password,
      profileImageLink: profileImageLink,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    );
  }

  factory UserModel.fromMap({required DocumentSnapshot document}) {
    return UserModel(
      userID: document['userID'],
      fullName: document['fullName'],
      emailAddress: document['emailAddress'],
      password: document['password'],
      profileImageLink: document['profileImageLink'],
      createdAt: document['createdAt'],
      updatedAt: document['updatedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'fullName': fullName,
      'emailAddress': emailAddress,
      'password': password,
      'profileImageLink': profileImageLink,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  UserModel copyWith({String? userID, String? fullName, String? emailAddress, String? password, String? profileImageLink}) {
    return UserModel(
      userID: userID ?? this.userID,
      fullName: fullName ?? this.fullName,
      emailAddress: emailAddress ?? this.emailAddress,
      password: password ?? this.password,
      profileImageLink: profileImageLink ?? this.profileImageLink,
      createdAt: createdAt,
      updatedAt: Timestamp.now(),
    );
  }
}
