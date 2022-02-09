import 'dart:convert';

class Message {
  String chatRoomId;
  String senderId;
  String text;
  DateTime date;
  String? image;
  String senderName;
  Message({
    required this.chatRoomId,
    required this.senderId,
    required this.text,
    required this.date,
    this.image,
    required this.senderName,
  });

  Message copyWith({
    String? chatRoomId,
    String? senderId,
    String? text,
    DateTime? date,
    String? image,
    String? senderName,
  }) {
    return Message(
      chatRoomId: chatRoomId ?? this.chatRoomId,
      senderId: senderId ?? this.senderId,
      text: text ?? this.text,
      date: date ?? this.date,
      image: image ?? this.image,
      senderName: senderName ?? this.senderName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chatRoomId': chatRoomId,
      'senderId': senderId,
      'text': text,
      'date': date.millisecondsSinceEpoch,
      'image': image,
      'senderName': senderName,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      chatRoomId: map['chatRoomId'],
      senderId: map['senderId'],
      text: map['text'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      image: map['image'],
      senderName: map['senderName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Message(chatRoomId: $chatRoomId, senderId: $senderId, text: $text, date: $date, image: $image, senderName: $senderName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Message &&
        other.chatRoomId == chatRoomId &&
        other.senderId == senderId &&
        other.text == text &&
        other.date == date &&
        other.image == image &&
        other.senderName == senderName;
  }

  @override
  int get hashCode {
    return chatRoomId.hashCode ^
        senderId.hashCode ^
        text.hashCode ^
        date.hashCode ^
        image.hashCode ^
        senderName.hashCode;
  }
}
