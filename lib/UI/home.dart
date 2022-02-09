import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:greatr/Firebase%20Functions/bookmarks.dart';
import 'package:greatr/Firebase%20Functions/chat_functions.dart';
import 'package:greatr/UI/Chat%20Section/chat_screen.dart';
import 'package:greatr/models/Job.dart';
import 'package:greatr/models/PrivateChatRoom.dart';
import 'package:line_icons/line_icons.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:slugify/slugify.dart';

import 'package:greatr/Firebase%20Functions/user_functions.dart';
import 'package:greatr/UI/Chat%20Section/chat_home.dart';
import 'package:greatr/UI/Companies/companies.dart';
import 'package:greatr/UI/Event%20Section/events.dart';
import 'package:greatr/UI/Home%20Sections/home_section_first.dart';
import 'package:greatr/UI/Profile%20Section/profile_screen.dart';
import 'package:greatr/models/ChatRoom.dart';
import 'package:greatr/models/Company.dart';
import 'package:greatr/models/Education.dart';
import 'package:greatr/models/Event.dart';

import 'package:greatr/models/Location.dart';
import 'package:greatr/models/User.dart';

import '../constants.dart';
import './globals.dart' as global;

String name = 'name';
String phone = 'phone';
Education education =
    Education(year: 0, university: 'university', field: 'field');
Location location = Location(country: '', city: '');

class HomePage extends StatefulWidget {
  List<ChatRoom> rooms;
  UserModel? user;
  List<UserModel> allUsers;
  List<Event> events;
  List<Company> companies;
  List<Job> jobs;
  bool notificationReceived;
  HomePage(
      {Key? key,
      required this.rooms,
      required this.user,
      required this.allUsers,
      required this.events,
      required this.companies,
      required this.jobs,
      required this.notificationReceived})
      : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool isChecked = false;
  PanelController _panelController = PanelController();
  int _currentIndex = 0;
  PageController _pageController = PageController();
  @override
  void initState() {
    global.user = widget.user!;
    print(widget.events);
    print('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
    print(widget.notificationReceived);
    setState(() {
      getBookmarkObjetcs();
    });
    if (widget.notificationReceived) {}

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: [
            HomeSection1(),
            Events(
              events: widget.events,
            ),
            Companies(jobs: widget.jobs, companies: widget.companies),
            ChatHomeScreen(
              allUsers: widget.allUsers,
              user: widget.user!,
              rooms: widget.rooms,
            ),
            ProfileScreen(
              user: widget.user!,
            )
          ],
        ),
      ),
      bottomNavigationBar: GNav(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          backgroundColor: Colors.white,
          selectedIndex: _currentIndex,
          rippleColor: Colors.grey,
          hoverColor: Colors.grey,
          onTabChange: (index) {
            setState(() {
              _currentIndex = index;
              _pageController.jumpToPage(
                index,
              );
            });
          },
          curve: Curves.ease, // tab animation curves
          duration: Duration(milliseconds: 365), // tab animation duration

          color: Colors.grey.shade400,
          activeColor: Colors.purple,

          // selected icon and text color
          iconSize: 26, // tab button icon size
          // selected tab background color
          padding: EdgeInsets.symmetric(
              horizontal: 20 * MediaQuery.of(context).size.height / 1000,
              vertical: 30 *
                  MediaQuery.of(context).size.height /
                  1300), // navigation bar padding
          tabs: [
            GButton(
              icon: LineIcons.home,
            ),
            GButton(
              icon: FontAwesomeIcons.calendarAlt,
            ),
            GButton(
              icon: LineIcons.businessTime,
            ),
            GButton(
              icon: LineIcons.comments,
            ),
            GButton(
              icon: LineIcons.user,
            )
          ]),
    );
  }
}
