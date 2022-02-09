import 'dart:convert';

import 'package:flutter/foundation.dart';

class News {
  List<dynamic> paragraphs;
  List<dynamic> images;
  String id;
  String creatorId;
  dynamic time;
  String newsTitle;
  News({
    required this.paragraphs,
    required this.images,
    required this.id,
    required this.creatorId,
    required this.time,
    required this.newsTitle,
  });

  Map<String, dynamic> toMap() {
    return {
      'paragraphs': paragraphs,
      'images': images,
      'id': id,
      'creatorId': creatorId,
      'time': time,
      'newsTitle': newsTitle,
    };
  }

  factory News.fromMap(Map<String, dynamic> map) {
    return News(
      paragraphs: List<dynamic>.from(map['paragraphs']),
      images: List<dynamic>.from(map['images']),
      id: map['id'],
      creatorId: map['creatorId'],
      time: map['time'],
      newsTitle: map['newsTitle'],
    );
  }

  String toJson() => json.encode(toMap());

  factory News.fromJson(String source) => News.fromMap(json.decode(source));

  @override
  String toString() {
    return 'News(paragraphs: $paragraphs, images: $images, id: $id, creatorId: $creatorId, time: $time, newsTitle: $newsTitle)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is News &&
        listEquals(other.paragraphs, paragraphs) &&
        listEquals(other.images, images) &&
        other.id == id &&
        other.creatorId == creatorId &&
        other.time == time &&
        other.newsTitle == newsTitle;
  }

  @override
  int get hashCode {
    return paragraphs.hashCode ^
        images.hashCode ^
        id.hashCode ^
        creatorId.hashCode ^
        time.hashCode ^
        newsTitle.hashCode;
  }
}
