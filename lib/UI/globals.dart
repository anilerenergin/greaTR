import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greatr/models/Feed.dart';
import 'package:greatr/models/PrivateChatRoom.dart';
import 'package:greatr/models/User.dart';
import 'package:greatr/models/UserBookmarks.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

late UserBookmark bookmarks;
late UserModel user;
List<dynamic> bookmarkedObjects = [];

late QueryDocumentSnapshot<Feed> lastFeedDocument;
List<dynamic> feedObjects = [];
List<PrivateChatRoom> privChatRooms = [];
late Algolia algolia;
late OSNotificationOpenedResult entryNotification;
String currentChatRoomId = '';
