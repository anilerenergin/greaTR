import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:greatr/models/Event.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
final eventRef =
    FirebaseFirestore.instance.collection('events').withConverter<Event>(
          fromFirestore: (snapshot, _) => Event.fromMap(snapshot.data()!),
          toFirestore: (chatRoom, _) => chatRoom.toMap(),
        );

Future getAllEvents(List<Event> events) async {
  try {
    var userData = await eventRef.get();
    userData.docs.forEach((element) {
      events.add(Event.fromMap(element.data().toMap()));
    });
  } catch (e) {
    print(e);
  }
}

Future attendEvent(
  String eventId,
  String userId,
) async {
  eventRef.doc(eventId).update({
    'attendedUsers': FieldValue.arrayUnion([
      userId,
    ])
  });
}

Future unAttendEvent(
  String eventId,
  String userId,
) async {
  eventRef.doc(eventId).update({
    'attendedUsers': FieldValue.arrayRemove([
      userId,
    ])
  });
}
