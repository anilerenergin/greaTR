import 'package:algolia/algolia.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:greatr/Firebase%20Functions/auth-functions.dart';
import 'package:greatr/Firebase%20Functions/chat_functions.dart';
import 'package:greatr/UI/Chat%20Section/chat_screen.dart';

import 'package:greatr/UI/Onboarding/onboarding.dart';
import 'package:greatr/UI/splash/splash.dart';
import 'package:greatr/feed.dart';
import 'package:greatr/models/PrivateChatRoom.dart';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:greatr/constants.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/UI/globals.dart' as globals;
import 'UI/NewRegister/new_register.dart';

class Application {
  static final Algolia algolia = Algolia.init(
    applicationId: 'EB15E567DL',
    apiKey: '9084841bd19031b209a11b61bb63c32e',
  );
}

bool notif = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await Firebase.initializeApp();
  String? logged =
      prefs.getString('uid') == null || prefs.getString('uid') == ''
          ? null
          : prefs.getString('uid');
  globals.algolia = Application.algolia;
  initializeDateFormatting();
  Intl.defaultLocale = 'tr';
  listenChanges();
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId("f2cdfb1e-dc8f-4dba-96bd-322376ef98ae");

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });
  OneSignal.shared.setNotificationWillShowInForegroundHandler((event) {
    if (event.notification.additionalData!['type'] == 'priv' &&
        globals.currentChatRoomId != event.notification.additionalData!['id']) {
      print(globals.currentChatRoomId !=
          event.notification.additionalData!['id']);
      Get.snackbar(event.notification.title.toString(),
          event.notification.body.toString(), onTap: (GetSnackBar bar) async {
        var response = await privateChatRoomRef
            .doc(event.notification.additionalData!['id'])
            .get();
        PrivateChatRoom privRoom =
            PrivateChatRoom.fromMap(response.data()!.toMap());
        Stream<QuerySnapshot> messageStream = FirebaseFirestore.instance
            .collection('messages')
            .where('chatRoomId', isEqualTo: privRoom.roomId)
            .orderBy('date', descending: true)
            .snapshots();
        globals.currentChatRoomId = privRoom.roomId!;
        if (globals.currentChatRoomId != '') {
          Get.back();
          Get.to(() => ChatScreen(
            sender:globals.user,
              type: 'priv',
              chatRoomId: privRoom.roomId!,
              title:
                  privRoom.participantNames[0] == privRoom.participantNames[1]
                      ? privRoom.participantNames[0]
                      : privRoom.participantNames
                          .where((element) => element != globals.user.name)
                          .first,
              messageStream: messageStream,
              user: globals.user));
        } else {
          Get.to(() => ChatScreen(
            sender:globals.user,
              type: 'priv',
              chatRoomId: privRoom.roomId!,
              title:
                  privRoom.participantNames[0] == privRoom.participantNames[1]
                      ? privRoom.participantNames[0]
                      : privRoom.participantNames
                          .where((element) => element != globals.user.name)
                          .first,
              messageStream: messageStream,
              user: globals.user));
        }
      }, snackPosition: SnackPosition.TOP);
    }
  });
  OneSignal.shared
      .setNotificationOpenedHandler((OSNotificationOpenedResult result) async {
    if (result.notification.additionalData!['type'] == 'priv') {
      notif = true;
      globals.entryNotification = result;
      Future.delayed(Duration(milliseconds: 560)).then((value) async {
        var response = await privateChatRoomRef
            .doc(globals.entryNotification.notification.additionalData!['id'])
            .get();
        PrivateChatRoom privRoom =
            PrivateChatRoom.fromMap(response.data()!.toMap());
        Stream<QuerySnapshot> messageStream = FirebaseFirestore.instance
            .collection('messages')
            .where('chatRoomId', isEqualTo: privRoom.roomId)
            .orderBy('date', descending: true)
            .snapshots();
        Get.to(() => ChatScreen(
          sender:globals.user,
              type: 'priv',
              chatRoomId: privRoom.roomId!,
              title:
                  privRoom.participantNames[0] == privRoom.participantNames[1]
                      ? privRoom.participantNames[0]
                      : privRoom.participantNames
                          .where((element) => element != globals.user.name)
                          .first,
              messageStream: messageStream,
              user: globals.user,
              otherUserId: privRoom.participants
                  .where((element) => element != globals.user.id)
                  .first,
            ));
      });
    }
  });

  runApp(MyApp(
    logged: logged,
  ));
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  MyApp({required this.logged});

  String? logged;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Greatr',
      theme: whiteTheme,
      home:FeedScreen()
    );
  }
}
