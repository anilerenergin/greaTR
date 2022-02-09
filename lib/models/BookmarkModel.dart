import 'dart:convert';

class BookmarkModel {
  String bookMarkId;
  String bookmarkType;
  BookmarkModel({
    required this.bookMarkId,
    required this.bookmarkType,
  });

  BookmarkModel copyWith({
    String? bookMarkId,
    String? bookmarkType,
  }) {
    return BookmarkModel(
      bookMarkId: bookMarkId ?? this.bookMarkId,
      bookmarkType: bookmarkType ?? this.bookmarkType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bookMarkId': bookMarkId,
      'bookmarkType': bookmarkType,
    };
  }

  factory BookmarkModel.fromMap(Map<String, dynamic> map) {
    return BookmarkModel(
      bookMarkId: map['bookMarkId'],
      bookmarkType: map['bookmarkType'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BookmarkModel.fromJson(String source) =>
      BookmarkModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'BookmarkModel(bookMarkId: $bookMarkId, bookmarkType: $bookmarkType)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BookmarkModel &&
        other.bookMarkId == bookMarkId &&
        other.bookmarkType == bookmarkType;
  }

  @override
  int get hashCode => bookMarkId.hashCode ^ bookmarkType.hashCode;
}
