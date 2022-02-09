import 'dart:convert';

class EventApplication {
  String applicationId;
  String userId;
  String eventId;
  DateTime applicationDate;
  EventApplication({
    required this.applicationId,
    required this.userId,
    required this.eventId,
    required this.applicationDate,
  });

  EventApplication copyWith({
    String? applicationId,
    String? userId,
    String? eventId,
    DateTime? applicationDate,
  }) {
    return EventApplication(
      applicationId: applicationId ?? this.applicationId,
      userId: userId ?? this.userId,
      eventId: eventId ?? this.eventId,
      applicationDate: applicationDate ?? this.applicationDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'applicationId': applicationId,
      'userId': userId,
      'eventId': eventId,
      'applicationDate': applicationDate.millisecondsSinceEpoch,
    };
  }

  factory EventApplication.fromMap(Map<String, dynamic> map) {
    return EventApplication(
      applicationId: map['applicationId'],
      userId: map['userId'],
      eventId: map['eventId'],
      applicationDate:
          DateTime.fromMillisecondsSinceEpoch(map['applicationDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EventApplication.fromJson(String source) =>
      EventApplication.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EventApplication(applicationId: $applicationId, userId: $userId, eventId: $eventId, applicationDate: $applicationDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EventApplication &&
        other.applicationId == applicationId &&
        other.userId == userId &&
        other.eventId == eventId &&
        other.applicationDate == applicationDate;
  }

  @override
  int get hashCode {
    return applicationId.hashCode ^
        userId.hashCode ^
        eventId.hashCode ^
        applicationDate.hashCode;
  }
}
