import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greatr/Firebase%20Functions/event_functions.dart';
import 'package:greatr/Firebase%20Functions/job_offers.dart';
import 'package:greatr/models/BookmarkModel.dart';
import 'package:greatr/models/Event.dart';
import 'package:greatr/models/Job.dart';

import 'package:greatr/models/UserBookmarks.dart';
import '/UI/globals.dart' as global;

final bookmarkRef = FirebaseFirestore.instance
    .collection('bookmarks')
    .withConverter<UserBookmark>(
      fromFirestore: (snapshot, _) => UserBookmark.fromMap(snapshot.data()!),
      toFirestore: (userModel, _) => userModel.toMap(),
    );

Future getBookmarks(String userId, List<UserBookmark> bookmark) async {
  try {
    var response = await bookmarkRef.where('userId', isEqualTo: userId).get();
    bookmark.add(UserBookmark.fromMap(response.docs.first.data().toMap()));
    global.bookmarks =
        UserBookmark(userId: userId, bookmarks: bookmark.first.bookmarks);
  } catch (e) {
    print(e);
  }
}

Future createBookmark(String userId, UserBookmark bookmark) async {
  bookmarkRef.add(bookmark);
}

Future getBookmarkObjetcs() async {
  global.bookmarks.bookmarks.forEach((element) async {
    switch (element.bookmarkType) {
      case 'event':
        var response = await eventRef.doc(element.bookMarkId).get();
        global.bookmarkedObjects.add(Event.fromMap(response.data()!.toMap()));
        break;
      case 'job':
        var response = await jobOfferRef.doc(element.bookMarkId).get();
        global.bookmarkedObjects.add(Job.fromMap(response.data()!.toMap()));
        break;

      default:
    }
  });
}

Future bookmarkJob(String userId, String jobId) async {
  BookmarkModel bookmarkModel =
      BookmarkModel(bookMarkId: jobId, bookmarkType: 'job');
  global.bookmarks.bookmarks.add(bookmarkModel);
  var response = await jobOfferRef.doc(bookmarkModel.bookMarkId).get();
  global.bookmarkedObjects.add(Job.fromMap(response.data()!.toMap()));
  await bookmarkRef
      .where('userId', isEqualTo: userId)
      .get()
      .then((value) async {
    print(value.docs.first.id);
    await bookmarkRef.doc(value.docs.first.id).update({
      'bookmarks': FieldValue.arrayUnion([bookmarkModel.toMap()])
    });
  });
}

Future bookmarkEvent(String userId, String eventId) async {
  BookmarkModel bookmarkModel =
      BookmarkModel(bookMarkId: eventId, bookmarkType: 'event');
  global.bookmarks.bookmarks.add(bookmarkModel);
  var response = await eventRef.doc(bookmarkModel.bookMarkId).get();
  global.bookmarkedObjects.add(Event.fromMap(response.data()!.toMap()));
  await bookmarkRef
      .where('userId', isEqualTo: userId)
      .get()
      .then((value) async {
    await bookmarkRef.doc(value.docs.first.id).update({
      'bookmarks': FieldValue.arrayUnion([bookmarkModel.toMap()])
    });
  });
}

Future removeBookmark(String userId, String eventId) async {
  BookmarkModel bookmarkModel =
      BookmarkModel(bookMarkId: eventId, bookmarkType: 'event');

  global.bookmarks.bookmarks
      .removeWhere((element) => element.bookMarkId == eventId);
  await bookmarkRef
      .where('userId', isEqualTo: userId)
      .get()
      .then((value) async {
    print(value.docs.first.id);
    await bookmarkRef.doc(value.docs.first.id).update({
      'bookmarks': FieldValue.arrayRemove([bookmarkModel.toMap()])
    });
  });
}

Future removeBookmarkJob(String userId, String jobId) async {
  BookmarkModel bookmarkModel =
      BookmarkModel(bookMarkId: jobId, bookmarkType: 'job');

  global.bookmarks.bookmarks
      .removeWhere((element) => element.bookMarkId == jobId);
  await bookmarkRef
      .where('userId', isEqualTo: userId)
      .get()
      .then((value) async {
    print(value.docs.first.id);
    await bookmarkRef.doc(value.docs.first.id).update({
      'bookmarks': FieldValue.arrayRemove([bookmarkModel.toMap()])
    });
  });
}
