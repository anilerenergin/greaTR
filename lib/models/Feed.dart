import 'dart:convert';

class Feed {
  String feedObjectId;
  String feedObjectType;
  dynamic feedObjectDate;
  Feed({
    required this.feedObjectId,
    required this.feedObjectType,
    required this.feedObjectDate,
  });

  Feed copyWith({
    String? feedObjectId,
    String? feedObjectType,
    dynamic? feedObjectDate,
  }) {
    return Feed(
      feedObjectId: feedObjectId ?? this.feedObjectId,
      feedObjectType: feedObjectType ?? this.feedObjectType,
      feedObjectDate: feedObjectDate ?? this.feedObjectDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'feedObjectId': feedObjectId,
      'feedObjectType': feedObjectType,
      'feedObjectDate': feedObjectDate,
    };
  }

  factory Feed.fromMap(Map<String, dynamic> map) {
    return Feed(
      feedObjectId: map['feedObjectId'],
      feedObjectType: map['feedObjectType'],
      feedObjectDate: map['feedObjectDate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Feed.fromJson(String source) => Feed.fromMap(json.decode(source));

  @override
  String toString() =>
      'Feed(feedObjectId: $feedObjectId, feedObjectType: $feedObjectType, feedObjectDate: $feedObjectDate)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Feed &&
        other.feedObjectId == feedObjectId &&
        other.feedObjectType == feedObjectType &&
        other.feedObjectDate == feedObjectDate;
  }

  @override
  int get hashCode =>
      feedObjectId.hashCode ^ feedObjectType.hashCode ^ feedObjectDate.hashCode;
}
