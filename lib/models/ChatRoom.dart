import 'dart:convert';

class ChatRoom {
  String id;
  String title;
  String? location;

  String imageUrl;
  ChatRoom({
    required this.id,
    required this.title,
    this.location,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'imageUrl': imageUrl,
    };
  }

  factory ChatRoom.fromMap(Map<String, dynamic> map) {
    return ChatRoom(
      id: map['id'],
      title: map['title'] ?? "Boş",
      location: map['location'],
      imageUrl: map['imageUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatRoom.fromJson(String source) =>
      ChatRoom.fromMap(json.decode(source));
}
