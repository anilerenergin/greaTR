import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:greatr/models/Education.dart';
import 'package:greatr/models/Location.dart';

class UserModel {
  String? firstGraduateYear;
  String? secondGraduateYear;
  String name;
  String email;
  String username;
  dynamic registerDate;
  String id;
  String? imageUrl;
  String phoneNumber;
  Education education;
  Location location;
  String reference;
  bool kvkkApproved;
  bool comingBackToTurkey;
  int roleNumber;
  List<dynamic> privateChatRoomIds;
  List<dynamic> blockedUsers;
  List<dynamic>? likedPosts;
  List<dynamic> postList;
  String? userBio;
  UserModel({
    required this.firstGraduateYear,
    required this.secondGraduateYear,
    required this.name,
    required this.email,
    required this.username,
    required this.registerDate,
    required this.id,
    this.imageUrl,
    required this.kvkkApproved,
    required this.reference,
    required this.comingBackToTurkey,
    required this.phoneNumber,
    required this.education,
    required this.location,
    required this.roleNumber,
    required this.privateChatRoomIds,
    required this.blockedUsers,
    this.userBio,
    this.likedPosts,
    required this.postList,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstGraduateYear': firstGraduateYear,
      'secondGraduateYear': secondGraduateYear,
      'name': name,
      'email': email,
      'username': username,
      'registerDate': registerDate,
      'id': id,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber,
      'education': education.toMap(),
      'location': location.toMap(),
      'roleNumber': roleNumber,
      'privateChatRoomIds': privateChatRoomIds,
      'blockedUsers': blockedUsers,
      'userBio': userBio,
      'kvkkApproved': kvkkApproved,
      'reference': reference,
      'comingBackToTurkey': comingBackToTurkey,
      'likedPosts': likedPosts,
      'postList': postList,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        firstGraduateYear: map['firstGraduateYear'],
        secondGraduateYear: map['secondGraduateYear'],
        name: map['name'],
        email: map['email'],
        username: map['username'],
        registerDate: map['registerDate'],
        id: map['id'],
        imageUrl: map['imageUrl'] != null ? map['imageUrl'] : null,
        phoneNumber: map['phoneNumber'],
        education: Education.fromMap(map['education']),
        location: Location.fromMap(map['location']),
        roleNumber: map['roleNumber'],
        privateChatRoomIds: List<dynamic>.from(map['privateChatRoomIds']),
        blockedUsers: List<dynamic>.from(map['blockedUsers']),
        userBio: map['userBio'] != null ? map['userBio'] : null,
        kvkkApproved: map['kvkkApproved'] != null ? map['kvkkApproved'] : true,
        reference: map['reference'] != null ? map['reference'] : "boş",
        comingBackToTurkey: map['comingBackToTurkey'] != null
            ? map['comingBackToTurkey']
            : true,
        postList: List<dynamic>.from(map['postList']),
        likedPosts: List<dynamic>.from(map['likedPosts']));
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(firstGraduateYear: $firstGraduateYear,secondGraduateYear:$secondGraduateYear,name: $name, email: $email, username: $username, registerDate: $registerDate, id: $id, imageUrl: $imageUrl, phoneNumber: $phoneNumber, education: $education, location: $location, roleNumber: $roleNumber, privateChatRoomIds: $privateChatRoomIds, blockedUsers: $blockedUsers, userBio: $userBio,kvkkapproved:$kvkkApproved,reference:$reference,comingBackToTurkey:$comingBackToTurkey,likedPosts:$likedPosts,postList:$postList)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.firstGraduateYear == firstGraduateYear &&
        other.secondGraduateYear == secondGraduateYear &&
        other.name == name &&
        other.email == email &&
        other.username == username &&
        other.registerDate == registerDate &&
        other.id == id &&
        other.kvkkApproved == kvkkApproved &&
        other.comingBackToTurkey == comingBackToTurkey &&
        other.reference == reference &&
        other.imageUrl == imageUrl &&
        other.phoneNumber == phoneNumber &&
        other.education == education &&
        other.location == location &&
        other.roleNumber == roleNumber &&
        listEquals(other.privateChatRoomIds, privateChatRoomIds) &&
        listEquals(other.blockedUsers, blockedUsers) &&
        other.userBio == userBio &&
        other.likedPosts == likedPosts &&
        other.postList == postList;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        username.hashCode ^
        registerDate.hashCode ^
        id.hashCode ^
        imageUrl.hashCode ^
        phoneNumber.hashCode ^
        education.hashCode ^
        kvkkApproved.hashCode ^
        location.hashCode ^
        roleNumber.hashCode ^
        privateChatRoomIds.hashCode ^
        blockedUsers.hashCode ^
        userBio.hashCode ^
        firstGraduateYear.hashCode ^
        secondGraduateYear.hashCode ^
        likedPosts.hashCode ^
        postList.hashCode;
  }

  UserModel copyWith({
    String? firstGraduateYear,
    String? secondGraduateYear,
    String? name,
    String? email,
    String? username,
    dynamic registerDate,
    String? id,
    String? imageUrl,
    String? phoneNumber,
    Education? education,
    Location? location,
    int? roleNumber,
    List<dynamic>? privateChatRoomIds,
    List<dynamic>? blockedUsers,
    String? userBio,
    bool? kvkkApproved,
    String? reference,
    bool? comingBackToTurkey,
    List? likedPosts,
    List? postList,
  }) {
    return UserModel(
      firstGraduateYear: firstGraduateYear ?? this.firstGraduateYear,
      secondGraduateYear: secondGraduateYear ?? this.secondGraduateYear,
      name: name ?? this.name,
      email: email ?? this.email,
      username: username ?? this.username,
      registerDate: registerDate ?? this.registerDate,
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      education: education ?? this.education,
      location: location ?? this.location,
      roleNumber: roleNumber ?? this.roleNumber,
      privateChatRoomIds: privateChatRoomIds ?? this.privateChatRoomIds,
      blockedUsers: blockedUsers ?? this.blockedUsers,
      userBio: userBio ?? this.userBio,
      kvkkApproved: kvkkApproved ?? this.kvkkApproved,
      reference: reference ?? this.reference,
      comingBackToTurkey: comingBackToTurkey ?? this.comingBackToTurkey,
      likedPosts: likedPosts ?? this.likedPosts,
      postList: postList ?? this.postList,
    );
  }
}
