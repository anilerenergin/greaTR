import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greatr/Firebase%20Functions/user_functions.dart';
import 'package:greatr/models/ChatRoom.dart';
import 'package:greatr/models/Message.dart';
import 'package:greatr/models/PrivateChatRoom.dart';
import 'package:greatr/models/User.dart';
import '/UI/globals.dart' as global;
import 'package:http/http.dart' as http;

FirebaseFirestore firestore = FirebaseFirestore.instance;
final chatRoomRef =
    FirebaseFirestore.instance.collection('chat_rooms').withConverter<ChatRoom>(
          fromFirestore: (snapshot, _) => ChatRoom.fromMap(snapshot.data()!),
          toFirestore: (chatRoom, _) => chatRoom.toMap(),
        );
final privateChatRoomRef = FirebaseFirestore.instance
    .collection('private_chat_rooms')
    .withConverter<PrivateChatRoom>(
      fromFirestore: (snapshot, _) => PrivateChatRoom.fromMap(snapshot.data()!),
      toFirestore: (chatRoom, _) => chatRoom.toMap(),
    );

Future getChatRooms(List<ChatRoom> rooms) async {
  List<QueryDocumentSnapshot<ChatRoom>> chatRooms = await chatRoomRef
      .orderBy(
        'prior',
      )
      .get()
      .then((snapshot) => snapshot.docs);

  chatRooms.forEach((element) {
    rooms.add(ChatRoom.fromJson(element.data().toJson()));
  });
}

Future blockUser(String userId, String blockedUserId) async {
  userRef.doc(userId).update({
    'blockedUsers': FieldValue.arrayUnion([blockedUserId])
  });
}

Future<PrivateChatRoom> createPrivateRoom(
    UserModel user1Id, UserModel user2Id) async {
  Message msg = Message(
      chatRoomId: 'disabled',
      senderId: user1Id.id,
      text: 'init',
      date: DateTime.now(),
      senderName: user1Id.name);
  PrivateChatRoom privChatRoom = new PrivateChatRoom(
    lastMessage: msg,
    participants: [user1Id.id, user2Id.id],
    participantNames: [user1Id.name, user2Id.name],
    participantImages: [
      user1Id.imageUrl != null ? user1Id.imageUrl : '',
      user2Id.imageUrl != null ? user2Id.imageUrl : ''
    ],
  );
  await privateChatRoomRef.add(privChatRoom).then((value) async {
    privChatRoom.roomId = value.id;
    await privateChatRoomRef.doc(value.id).update({'roomId': value.id});
    userRef.doc(user1Id.id).update({
      'privateChatRoomIds': FieldValue.arrayUnion([value.id])
    });
    userRef.doc(user2Id.id).update({
      'privateChatRoomIds': FieldValue.arrayUnion([value.id])
    });
    global.privChatRooms.add(privChatRoom);
  });

  return privChatRoom;
}

Future getUserPrivateChatRooms(
  List<String> privChatRoomIds,
) async {
  privChatRoomIds.forEach((element) async {
    var response = await privateChatRoomRef.doc(element).get();
    PrivateChatRoom privRoom =
        PrivateChatRoom.fromMap(response.data()!.toMap());

    global.privChatRooms.add(privRoom);
  });
}

Future checkUserPrivateChatRooms(UserModel user1Id, UserModel user2Id) async {
  if (user1Id != user2Id) {
    var response = await privateChatRoomRef
        .where('participants', isEqualTo: [user1Id.id, user2Id.id]).get();

    if (response.docs.length > 0) {
      return PrivateChatRoom.fromMap(response.docs.first.data().toMap());
    } else {
      var secondResponse = await privateChatRoomRef
          .where('participants', isEqualTo: [user2Id.id, user1Id.id]).get();
      if (secondResponse.docs.length > 0) {
        return PrivateChatRoom.fromMap(
            secondResponse.docs.first.data().toMap());
      } else {
        return await createPrivateRoom(user1Id, user2Id);
      }
    }
  }
  return;
}

Future sendPrivChatMessage(
  String senderName,
  String receiverId,
  String content,
  String chatRoomId,
  String photoUrl,
) async {
  try {
    var request = {
      "app_id": "f2cdfb1e-dc8f-4dba-96bd-322376ef98ae",
      "include_external_user_ids": [receiverId],
      "channel_for_external_user_ids": "push",
      "contents": {"en": content},
      "headings": {"en": senderName},
      "data": {"id": chatRoomId, "type": 'priv', 'photoUrl': photoUrl}
    };

    await http.post(Uri.parse('https://onesignal.com/api/v1/notifications'),
        body: jsonEncode(request),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader:
              'Basic NmVkM2Q1YjEtZjlhOC00ZmI2LWI5MjctMTI3NDkyZDg1Mjc3'
        });
  } catch (e) {
    print(e);
  }
}
