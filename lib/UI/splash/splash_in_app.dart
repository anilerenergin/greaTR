import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greatr/Firebase%20Functions/bookmarks.dart';
import 'package:greatr/Firebase%20Functions/chat_functions.dart';
import 'package:greatr/Firebase%20Functions/event_functions.dart';
import 'package:greatr/Firebase%20Functions/feed_functions.dart';
import 'package:greatr/Firebase%20Functions/job_offer_functions.dart';
import 'package:greatr/Firebase%20Functions/post_function.dart';
import 'package:greatr/Firebase%20Functions/user_functions.dart';
import 'package:greatr/UI/home.dart';
import 'package:greatr/models/ChatRoom.dart';
import 'package:greatr/models/Company.dart';
import 'package:greatr/models/Event.dart';
import 'package:greatr/models/Job.dart';
import 'package:greatr/models/User.dart';
import 'package:greatr/models/UserBookmarks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/post_model.dart';
import '../globals.dart' as global;

class SplashAlt extends StatefulWidget {
  bool notificationReceived;
  int pageIndex;
  SplashAlt({required this.notificationReceived,required this.pageIndex});

  @override
  _SplashAltState createState() => _SplashAltState();
}

List<UserModel> users = [];
List<ChatRoom> rooms = [];
List<UserModel> allUsers = [];
List<Event> events = [];
List<UserBookmark> bookmarks = [];
List<Company> companies = [];
List<Job> jobs = [];
List<PostModel> posts = [];

Future futureOperation(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String uid = (prefs.getString('uid'))!;
  await Future.wait([
    getUserFromFirestore(uid, users),
    getChatRooms(rooms),
    getAllEvents(events),
    getCompanies(companies),
    getJobOffers(jobs),
  ])
      .then((value) => getBookmarks(users.first.id, bookmarks))
      .then((value) => global.bookmarks = bookmarks.first);
  return;
}

class _SplashAltState extends State<SplashAlt> {
  double opacityValue = 1;
  @override
  void initState() {
  setState(() {
users = [];
rooms = [];
allUsers = [];
events = [];
bookmarks = [];
companies = [];
jobs = [];
posts = [];
  });
    super.initState();
    var timer = new Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (opacityValue == 1) {
        setState(() {
          opacityValue = 0;
        });
      } else {
        setState(() {
          opacityValue = 1;
        });
      }
    });
    rooms = [];

    getAllPosts(posts).then((postlist) => futureOperation(context).then((value) {
      timer.cancel();
      Get.to(() => HomePage(
            notificationReceived: widget.notificationReceived,
            companies: companies,
            jobs: jobs,
            events: events,
            rooms: rooms,
            user: users.first,
            allUsers: allUsers,
            posts: posts,
            pageIndex: widget.pageIndex,
          ));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedOpacity(
            opacity: opacityValue,
            duration: Duration(milliseconds: 350),
            child: Padding(
              padding: EdgeInsets.all(
                  38.0 * MediaQuery.of(context).size.height / 1000),
              child: Center(
                child: Image.asset(
                  'images/logo.png',
                  height: MediaQuery.of(context).size.height / 4,
                  fit: BoxFit.fill,
                  scale: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
