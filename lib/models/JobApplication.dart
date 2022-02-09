import 'dart:convert';

class JobApplication {
  String applicationId;
  String userId;
  String jobId;
  DateTime applicationDate;
  JobApplication({
    required this.applicationId,
    required this.userId,
    required this.jobId,
    required this.applicationDate,
  });

  JobApplication copyWith({
    String? applicationId,
    String? userId,
    String? jobId,
    DateTime? applicationDate,
  }) {
    return JobApplication(
      applicationId: applicationId ?? this.applicationId,
      userId: userId ?? this.userId,
      jobId: jobId ?? this.jobId,
      applicationDate: applicationDate ?? this.applicationDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'applicationId': applicationId,
      'userId': userId,
      'jobId': jobId,
      'applicationDate': applicationDate.millisecondsSinceEpoch,
    };
  }

  factory JobApplication.fromMap(Map<String, dynamic> map) {
    return JobApplication(
      applicationId: map['applicationId'],
      userId: map['userId'],
      jobId: map['jobId'],
      applicationDate:
          DateTime.fromMillisecondsSinceEpoch(map['applicationDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory JobApplication.fromJson(String source) =>
      JobApplication.fromMap(json.decode(source));

  @override
  String toString() {
    return 'JobApplication(applicationId: $applicationId, userId: $userId, jobId: $jobId, applicationDate: $applicationDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is JobApplication &&
        other.applicationId == applicationId &&
        other.userId == userId &&
        other.jobId == jobId &&
        other.applicationDate == applicationDate;
  }

  @override
  int get hashCode {
    return applicationId.hashCode ^
        userId.hashCode ^
        jobId.hashCode ^
        applicationDate.hashCode;
  }
}
