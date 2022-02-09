import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:greatr/models/Location.dart';

class Event {
  String id;
  String organizerId;
  String organizerName;
  dynamic time;
  int maxApplicationCount;
  List<dynamic> attendedUsers;
  String eventText;
  List<dynamic> images;
  Location location;
  String eventTitle;
  Event({
    required this.id,
    required this.organizerId,
    required this.organizerName,
    required this.time,
    required this.maxApplicationCount,
    required this.attendedUsers,
    required this.eventText,
    required this.images,
    required this.location,
    required this.eventTitle,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'organizerId': organizerId,
      'organizerName': organizerName,
      'time': time,
      'maxApplicationCount': maxApplicationCount,
      'attendedUsers': attendedUsers,
      'eventText': eventText,
      'location': location.toMap(),
      'images': images,
      'eventTitle': eventTitle,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      organizerId: map['organizerId'],
      organizerName: map['organizerName'],
      time: map['time'],
      maxApplicationCount: map['maxApplicationCount'],
      attendedUsers: List<String>.from(map['attendedUsers']),
      eventText: map['eventText'],
      location: Location.fromMap(map['location']),
      images: map['images'],
      eventTitle: map['eventTitle'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Event(id: $id, organizerId: $organizerId, organizerName: $organizerName, time: $time, maxApplicationCount: $maxApplicationCount, attendedUsers: $attendedUsers, eventText: $eventText, location: $location)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Event &&
        other.id == id &&
        other.organizerId == organizerId &&
        other.organizerName == organizerName &&
        other.time == time &&
        other.maxApplicationCount == maxApplicationCount &&
        listEquals(other.attendedUsers, attendedUsers) &&
        other.eventText == eventText &&
        other.location == location;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        organizerId.hashCode ^
        organizerName.hashCode ^
        time.hashCode ^
        maxApplicationCount.hashCode ^
        attendedUsers.hashCode ^
        eventText.hashCode ^
        location.hashCode;
  }
}
