import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:greatr/models/Message.dart';

class PrivateChatRoom {
  List<String> participants;
  String? roomId;
  List<String> participantNames;
  List<String?> participantImages;
  Message lastMessage;
  PrivateChatRoom({
    required this.participants,
    this.roomId,
    required this.participantNames,
    required this.participantImages,
    required this.lastMessage,
  });

  PrivateChatRoom copyWith({
    List<String>? participants,
    String? roomId,
    List<String>? participantNames,
    List<String?>? participantImages,
    Message? lastMessage,
  }) {
    return PrivateChatRoom(
      participants: participants ?? this.participants,
      roomId: roomId ?? this.roomId,
      participantNames: participantNames ?? this.participantNames,
      participantImages: participantImages ?? this.participantImages,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'participants': participants,
      'roomId': roomId,
      'participantNames': participantNames,
      'participantImages': participantImages,
      'lastMessage': lastMessage.toMap(),
    };
  }

  factory PrivateChatRoom.fromMap(Map<String, dynamic> map) {
    return PrivateChatRoom(
      participants: List<String>.from(map['participants']),
      roomId: map['roomId'] != null ? map['roomId'] : null,
      participantNames: List<String>.from(map['participantNames']),
      participantImages: List<String?>.from(map['participantImages']),
      lastMessage: Message.fromMap(map['lastMessage']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PrivateChatRoom.fromJson(String source) =>
      PrivateChatRoom.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PrivateChatRoom(participants: $participants, roomId: $roomId, participantNames: $participantNames, participantImages: $participantImages, lastMessage: $lastMessage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PrivateChatRoom &&
        listEquals(other.participants, participants) &&
        other.roomId == roomId &&
        listEquals(other.participantNames, participantNames) &&
        listEquals(other.participantImages, participantImages) &&
        other.lastMessage == lastMessage;
  }

  @override
  int get hashCode {
    return participants.hashCode ^
        roomId.hashCode ^
        participantNames.hashCode ^
        participantImages.hashCode ^
        lastMessage.hashCode;
  }
}
