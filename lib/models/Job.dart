import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:greatr/models/Location.dart';

class Job {
  String id;
  String applicationUrl;
  List<String> reqs;
  String salaryDescription;
  String companyId;
  String companyName;
  Location location;
  String image;
  String jobTitle;
  dynamic lastApplicationDate;
  dynamic time;
  String jobDescription;
  Job({
    required this.id,
    required this.applicationUrl,
    required this.reqs,
    required this.salaryDescription,
    required this.companyId,
    required this.companyName,
    required this.location,
    required this.image,
    required this.jobTitle,
    required this.lastApplicationDate,
    required this.time,
    required this.jobDescription,
  });

  Job copyWith({
    String? id,
    String? applicationUrl,
    List<String>? reqs,
    String? salaryDescription,
    String? companyId,
    String? companyName,
    Location? location,
    String? image,
    String? jobTitle,
    dynamic? lastApplicationDate,
    dynamic? time,
    String? jobDescription,
  }) {
    return Job(
      id: id ?? this.id,
      applicationUrl: applicationUrl ?? this.applicationUrl,
      reqs: reqs ?? this.reqs,
      salaryDescription: salaryDescription ?? this.salaryDescription,
      companyId: companyId ?? this.companyId,
      companyName: companyName ?? this.companyName,
      location: location ?? this.location,
      image: image ?? this.image,
      jobTitle: jobTitle ?? this.jobTitle,
      lastApplicationDate: lastApplicationDate ?? this.lastApplicationDate,
      time: time ?? this.time,
      jobDescription: jobDescription ?? this.jobDescription,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'applicationUrl': applicationUrl,
      'reqs': reqs,
      'salaryDescription': salaryDescription,
      'companyId': companyId,
      'companyName': companyName,
      'location': location.toMap(),
      'image': image,
      'jobTitle': jobTitle,
      'lastApplicationDate': lastApplicationDate,
      'time': time,
      'jobDescription': jobDescription,
    };
  }

  factory Job.fromMap(Map<String, dynamic> map) {
    return Job(
      id: map['id'],
      applicationUrl: map['applicationUrl'],
      reqs: List<String>.from(map['reqs']),
      salaryDescription: map['salaryDescription'],
      companyId: map['companyId'],
      companyName: map['companyName'],
      location: Location.fromMap(map['location']),
      image: map['image'],
      jobTitle: map['jobTitle'],
      lastApplicationDate: map['lastApplicationDate'],
      time: map['time'],
      jobDescription: map['jobDescription'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Job.fromJson(String source) => Job.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Job(id: $id, applicationUrl: $applicationUrl, reqs: $reqs, salaryDescription: $salaryDescription, companyId: $companyId, companyName: $companyName, location: $location, image: $image, jobTitle: $jobTitle, lastApplicationDate: $lastApplicationDate, time: $time, jobDescription: $jobDescription)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Job &&
        other.id == id &&
        other.applicationUrl == applicationUrl &&
        listEquals(other.reqs, reqs) &&
        other.salaryDescription == salaryDescription &&
        other.companyId == companyId &&
        other.companyName == companyName &&
        other.location == location &&
        other.image == image &&
        other.jobTitle == jobTitle &&
        other.lastApplicationDate == lastApplicationDate &&
        other.time == time &&
        other.jobDescription == jobDescription;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        applicationUrl.hashCode ^
        reqs.hashCode ^
        salaryDescription.hashCode ^
        companyId.hashCode ^
        companyName.hashCode ^
        location.hashCode ^
        image.hashCode ^
        jobTitle.hashCode ^
        lastApplicationDate.hashCode ^
        time.hashCode ^
        jobDescription.hashCode;
  }
}
