import 'dart:convert';

import 'package:flutter/foundation.dart';

class Company {
  String name;
  String id;
  List<dynamic> jobOfferIds;
  List<dynamic> newsIds;
  List<dynamic> eventsIds;
  String info;
  String about;
  List<Map<dynamic, dynamic>> social;
  List<String> gallery;
  String logo;
  String cover;
  Company({
    required this.name,
    required this.id,
    required this.jobOfferIds,
    required this.newsIds,
    required this.eventsIds,
    required this.info,
    required this.about,
    required this.social,
    required this.gallery,
    required this.logo,
    required this.cover,
  });

  Company copyWith({
    String? name,
    String? id,
    List<dynamic>? jobOfferIds,
    List<dynamic>? newsIds,
    List<dynamic>? eventsIds,
    String? info,
    String? about,
    List<Map<String, String>>? social,
    List<String>? gallery,
    String? logo,
    String? cover,
  }) {
    return Company(
      name: name ?? this.name,
      id: id ?? this.id,
      jobOfferIds: jobOfferIds ?? this.jobOfferIds,
      newsIds: newsIds ?? this.newsIds,
      eventsIds: eventsIds ?? this.eventsIds,
      info: info ?? this.info,
      about: about ?? this.about,
      social: social ?? this.social,
      gallery: gallery ?? this.gallery,
      logo: logo ?? this.logo,
      cover: cover ?? this.cover,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'jobOfferIds': jobOfferIds,
      'newsIds': newsIds,
      'eventsIds': eventsIds,
      'info': info,
      'about': about,
      'social': social,
      'gallery': gallery,
      'logo': logo,
      'cover': cover,
    };
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      name: map['name'],
      id: map['id'],
      jobOfferIds: List<dynamic>.from(map['jobOfferIds']),
      newsIds: List<dynamic>.from(map['newsIds']),
      eventsIds: List<dynamic>.from(map['eventsIds']),
      info: map['info'],
      about: map['about'],
      social: List<Map<dynamic, dynamic>>.from(map['social']?.map((x) => x)),
      gallery: List<String>.from(map['gallery']),
      logo: map['logo'],
      cover: map['cover'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Company.fromJson(String source) =>
      Company.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Company(name: $name, id: $id, jobOfferIds: $jobOfferIds, newsIds: $newsIds, eventsIds: $eventsIds, info: $info, about: $about, social: $social, gallery: $gallery, logo: $logo, cover: $cover)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Company &&
        other.name == name &&
        other.id == id &&
        listEquals(other.jobOfferIds, jobOfferIds) &&
        listEquals(other.newsIds, newsIds) &&
        listEquals(other.eventsIds, eventsIds) &&
        other.info == info &&
        other.about == about &&
        listEquals(other.social, social) &&
        listEquals(other.gallery, gallery) &&
        other.logo == logo &&
        other.cover == cover;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        id.hashCode ^
        jobOfferIds.hashCode ^
        newsIds.hashCode ^
        eventsIds.hashCode ^
        info.hashCode ^
        about.hashCode ^
        social.hashCode ^
        gallery.hashCode ^
        logo.hashCode ^
        cover.hashCode;
  }
}
