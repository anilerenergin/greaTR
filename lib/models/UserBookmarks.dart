import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:greatr/models/BookmarkModel.dart';

class UserBookmark {
  String userId;
  List<BookmarkModel> bookmarks;
  UserBookmark({
    required this.userId,
    required this.bookmarks,
  });

  UserBookmark copyWith({
    String? userId,
    List<BookmarkModel>? bookmarks,
  }) {
    return UserBookmark(
      userId: userId ?? this.userId,
      bookmarks: bookmarks ?? this.bookmarks,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'bookmarks': bookmarks.map((x) => x.toMap()).toList(),
    };
  }

  factory UserBookmark.fromMap(Map<String, dynamic> map) {
    return UserBookmark(
      userId: map['userId'],
      bookmarks: List<BookmarkModel>.from(
          map['bookmarks']?.map((x) => BookmarkModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserBookmark.fromJson(String source) =>
      UserBookmark.fromMap(json.decode(source));

  @override
  String toString() => 'UserBookmark(userId: $userId, bookmarks: $bookmarks)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserBookmark &&
        other.userId == userId &&
        listEquals(other.bookmarks, bookmarks);
  }

  @override
  int get hashCode => userId.hashCode ^ bookmarks.hashCode;
}
