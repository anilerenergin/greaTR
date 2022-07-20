import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:greatr/Firebase%20Functions/bookmarks.dart';
import 'package:greatr/Firebase%20Functions/user_functions.dart';
import 'package:greatr/UI/Companies/job_application.dart';
import 'package:greatr/UI/Event%20Section/single_event.dart';
import 'package:greatr/UI/Onboarding/onboarding.dart';
import 'package:greatr/models/Event.dart';
import 'package:greatr/models/Job.dart';
import 'package:like_button/like_button.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:table_calendar/table_calendar.dart';
import '../../Firebase Functions/chat_functions.dart';
import '../../models/PrivateChatRoom.dart';
import '../Chat Section/chat_screen.dart';
import '../globals.dart' as global;
import 'package:greatr/models/User.dart';
import 'package:greatr/utils/file_upload.dart';
import 'package:greatr/utils/image_upload.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  UserModel user;
  ProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String bio = '';
  bool panelClosed = false;
  int panelIndex = 0;
  bool imagePickerOpened = false;
  PageController _pageController = PageController();
  PanelController _panelController1 = PanelController();
  PanelController _panelController2 = PanelController();
  List<UserModel> _users = [];
  late Future getBlockedUsers;
  @override
  void initState() {
    panelIndex =
        FirebaseAuth.instance.currentUser!.uid == widget.user.id ? 0 : 1;
    getBlockedUsers = getBlocked();
    print(widget.user.blockedUsers);
    setState(() {});

    super.initState();
  }

  Future<void> getBlocked() async {
    widget.user.blockedUsers.forEach((e) async {
      var response = await userRef.doc(e).get();
      _users.add(UserModel.fromMap(response.data()!.toMap()));
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Stack(
          children: [
            animatorForProfileBox(height, context),
            sliderProfile(height, width, context),
            blockedSlider(height, width, context),
            Positioned(
                right: MediaQuery.of(context).size.width / 25,
                top: width / 10,
                child: Row(
                  children: [
                    widget.user.id != global.user.id
                        ? IconButton(
                            icon: Icon(FontAwesomeIcons.solidCommentAlt,
                                color: Colors.white),
                            onPressed: () {
                              checkUserPrivateChatRooms(
                                      global.user, widget.user)
                                  .then((value) async {
                                print(value.roomId);
                                PrivateChatRoom privRoom = value;
                                global.currentChatRoomId = privRoom.roomId!;

                                Stream<QuerySnapshot> messageStream =
                                    FirebaseFirestore.instance
                                        .collection('messages')
                                        .where('chatRoomId',
                                            isEqualTo: privRoom.roomId)
                                        .orderBy('date', descending: true)
                                        .snapshots();

                                var value10 = await Get.to(() => ChatScreen(
                                    type: 'priv',
                                    chatRoomId: privRoom.roomId!,
                                    messageStream: messageStream,
                                    title: privRoom.participantNames.last,
                                    user: global.user,
                                    otherUserId: privRoom.participants
                                        .where((element) =>
                                            element != global.user.id)
                                        .toList()
                                        .first));
                                if (value10) {
                                  setState(() {
                                    global.currentChatRoomId = '';
                                  });
                                }
                              });
                            },
                          )
                        : SizedBox.shrink(),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.userAltSlash,
                          color: Colors.white),
                      onPressed: () {
                        _panelController1.close();
                        _panelController2.open();
                      },
                    ),
                    FirebaseAuth.instance.currentUser!.uid == widget.user.id
                        ? IconButton(
                            onPressed: () async {
                              var value = await logoutDialog(context, height);
                              if (value) {
                                await FirebaseAuth.instance.signOut();
                                var prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setString('uid', '');
                                Get.off(() => Onboarding());
                              }
                            },
                            icon: Icon(FontAwesomeIcons.arrowRight,
                                color: Colors.white))
                        : SizedBox(),
                  ],
                )),
            FirebaseAuth.instance.currentUser!.uid == widget.user.id
                ? SizedBox()
                : Positioned(
                    left: MediaQuery.of(context).size.width / 25,
                    top: width / 10,
                    child: IconButton(
                        icon: Icon(FontAwesomeIcons.chevronLeft,
                            color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        }))
          ],
        ),
      ),
    );
  }

  SlidingUpPanel blockedSlider(
      double height, double width, BuildContext context) {
    return SlidingUpPanel(
        onPanelClosed: () {
          _panelController1.open();
        },
        minHeight: 0,
        slideDirection: SlideDirection.UP,
        controller: _panelController2,
        panel: Container(
            color: Colors.white,
            height: height / 2,
            child: Padding(
              padding: EdgeInsets.all(width / 30),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Bloklanan Kullanıcılar',
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(fontSize: width / 20))
                    ],
                  ),
                  Flexible(
                      child: FutureBuilder(
                          future: getBlockedUsers,
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return Center(
                                    child: CircularProgressIndicator());

                              default:
                                return ListView.builder(
                                    itemCount: _users.length,
                                    itemBuilder: (context, index) {
                                      return GFListTile(
                                          titleText: _users[index].name,
                                          icon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  widget.user.blockedUsers
                                                      .removeWhere((element) =>
                                                          element ==
                                                          _users[index].id);
                                                  _users.remove(_users[index]);
                                                  print('AAA');
                                                });
                                              },
                                              icon: Icon(
                                                FontAwesomeIcons.minus,
                                              )));
                                    });
                            }
                          }))
                ],
              ),
            )));
  }

  Future<dynamic> logoutDialog(BuildContext context, double height) {
    return showDialog(
        context: context,
        builder: (context) {
          if (Platform.isIOS) {
            return CupertinoAlertDialog(
                content: Text('Çıkış Yapıyorsunuz'),
                actions: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context, true);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(20.0 * height / 1000),
                        child: Center(
                            child: Text('Çıkış Yap',
                                style: Theme.of(context).textTheme.bodyText1)),
                      )),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context, false);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(20.0 * height / 1000),
                        child: Center(
                            child: Text('Geri Dön',
                                style: Theme.of(context).textTheme.bodyText1)),
                      ))
                ]);
          } else {
            return AlertDialog(title: Text('Çıkış Yapıyorsunuz'), actions: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context, true);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(20.0 * height / 1000),
                    child: Center(
                        child: Text('Devam Et',
                            style: Theme.of(context).textTheme.bodyText1!)),
                  )),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context, false);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(20.0 * height / 1000),
                    child: Center(
                        child: Text('Geri Dön',
                            style: Theme.of(context).textTheme.bodyText1)),
                  ))
            ]);
          }
        });
  }

  Padding animatorForProfileBox(double height, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(height / 12),
      child: Container(
          color: Theme.of(context).primaryColor,
          child: AnimatedAlign(
            alignment: panelClosed ? Alignment.center : Alignment.topCenter,
            duration: Duration(milliseconds: 200),
            child: infoBoxProfile(height, context),
          )),
    );
  }

  Container infoBoxProfile(double height, BuildContext context) {
    return Container(
      height: panelClosed ? height / 2 : height / 3,
      color: Color(0x9077d1),
      child: Column(
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  if (global.user.id == widget.user.id) {
                    setState(() {
                      imagePickerOpened = !imagePickerOpened;
                    });
                  }
                },
                child: CircleAvatar(
                  radius:
                      panelClosed ? 100 * height / 1000 : 70 * height / 1000,
                  backgroundColor: Colors.white,
                  backgroundImage: widget.user.imageUrl != null
                      ? NetworkImage(widget.user.imageUrl!)
                      : NetworkImage(
                          'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png'),
                ),
              ),
              imagePickerOpened
                  ? Positioned(
                      left: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: () {
                          if (global.user.id == widget.user.id) {
                            getImageFromCamera(widget.user.username,
                                    FirebaseAuth.instance.currentUser!.uid)
                                .then((value) {
                              setState(() {
                                widget.user.imageUrl = value;
                              });
                            });
                          }
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          width: MediaQuery.of(context).size.width / 8,
                          height: MediaQuery.of(context).size.width / 8,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Padding(
                            padding: EdgeInsets.all(3.0 * height / 1000),
                            child: Center(
                                child: Icon(FontAwesomeIcons.camera,
                                    color: Colors.white,
                                    size: MediaQuery.of(context).size.width *
                                        0.07)),
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
              imagePickerOpened
                  ? Positioned(
                      right: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: () {
                          if (global.user.id == widget.user.id) {
                            getImageFromGallery(widget.user.username,
                                    FirebaseAuth.instance.currentUser!.uid)
                                .then((value) {
                              setState(() {
                                widget.user.imageUrl = value;
                              });
                            });
                          }
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          width: MediaQuery.of(context).size.width / 8,
                          height: MediaQuery.of(context).size.width / 8,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Padding(
                            padding: EdgeInsets.all(3.0 * height / 1000),
                            child: Center(
                              child: Icon(
                                Icons.photo,
                                color: Colors.white,
                                size: MediaQuery.of(context).size.width * 0.08,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink()
            ],
          ),
          Column(
            children: [
              Text(
                widget.user.name,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width / 15),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: height / 50,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<dynamic> bottomSheetBio(double height, BuildContext context) {
    return Get.bottomSheet(
        Container(
          height: height / 2,
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width / 30),
            child: Column(
              children: [
                Text('Biyografi', style: Theme.of(context).textTheme.headline1),
                SizedBox(
                  height: height / 30,
                ),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      bio = value;
                    });
                  },
                  maxLines: 6,
                  maxLength: 200,
                ),
                GFButton(
                    text: 'Güncelle',
                    onPressed: () {
                      updateBio(global.user.id, bio);
                      setState(() {
                        widget.user.userBio = bio;
                        bio = '';
                      });
                      Navigator.pop(context);
                    }),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white);
  }

  SlidingUpPanel sliderProfile(
      double height, double width, BuildContext context) {
    return SlidingUpPanel(
      onPanelSlide: (position) {
        if (position <= 0.3) {
          if (!panelClosed) {
            setState(() {
              panelClosed = true;
            });
          }
        } else {
          if (panelClosed) {
            setState(() {
              panelClosed = false;
            });
          }
        }
      },
      controller: _panelController1,
      renderPanelSheet: false,
      maxHeight: height / 1.65,
      minHeight: height / 20,
      slideDirection: SlideDirection.UP,
      defaultPanelState: PanelState.OPEN,
      panel: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        height: height / 1.65,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 2.5),
              child: Divider(
                color: Colors.grey.shade400,
                indent: 3,
                thickness: 1.5,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.0 * height / 1000),
              child: Row(
                children: [
                  panelCategory(
                      context,
                      'Bilgiler',
                      Icon(
                        FontAwesomeIcons.edit,
                        color: panelIndex == 0
                            ? Theme.of(context).primaryColor
                            : Colors.grey.shade500,
                      ),
                      0),
                  FirebaseAuth.instance.currentUser!.uid == widget.user.id
                      ? panelCategory(
                          context,
                          'Kaydedilen',
                          Icon(
                            FontAwesomeIcons.bookmark,
                            color: panelIndex == 1
                                ? Theme.of(context).primaryColor
                                : Colors.grey.shade500,
                          ),
                          1)
                      : SizedBox(),
                ],
              ),
            ),
            Expanded(
              child: FirebaseAuth.instance.currentUser!.uid == widget.user.id
                  ? PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          panelIndex = index;
                        });
                      },
                      children: [
                        pageViewThird(width, context),
                        pageViewSecond(height, width),
                      ],
                    )
                  : pageViewThird(width, context),
            )
          ],
        ),
      ),
    );
  }

  Container pageViewThird(double width, BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.all(width / 15),
        children: [
          Text('Ad Soyad',
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: width / 25)),
          TextFormField(
              enabled: false,
              initialValue: widget.user.name,
              decoration: InputDecoration(
                border: InputBorder.none,
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('E-mail',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: width / 25)),
            ],
          ),
          TextFormField(
              enabled: false,
              initialValue: widget.user.email,
              decoration: InputDecoration(
                border: InputBorder.none,
              )),
          Text('Ülke',
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: width / 25)),
          TextFormField(
              enabled: false,
              initialValue: widget.user.location.country,
              decoration: InputDecoration(
                border: InputBorder.none,
              )),
          Text('Şehir',
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: width / 25)),
          TextFormField(
              enabled: false,
              initialValue: widget.user.location.city,
              decoration: InputDecoration(
                border: InputBorder.none,
              )),
          Text('Üniversite',
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: width / 25)),
          TextFormField(
              enabled: false,
              initialValue: widget.user.education.university,
              decoration: InputDecoration(
                border: InputBorder.none,
              )),
          Text('Bölüm',
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: width / 25)),
          TextFormField(
              enabled: false,
              initialValue: widget.user.education.field,
              decoration: InputDecoration(
                border: InputBorder.none,
              )),
          widget.user.education.secondField == ""
              ? secondMajorStrings(
                  context, MediaQuery.of(context).size.height, width)
              : SizedBox.shrink(),
          Text('Kayıt Tarihi',
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: width / 25)),
          TextFormField(
              enabled: false,
              initialValue: '27/09/2021',
              decoration: InputDecoration(
                border: InputBorder.none,
              )),
        ],
      ),
    );
  }

  Widget pageViewSecond(double height, double width) {
    if (global.bookmarks.bookmarks.length == 0) {
      return Container(
        child: Padding(
          padding: EdgeInsets.all(width / 10),
          child: Center(
              child: Text('Henüz Kaydedilen Bir Şey Yok',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: width / 15,
                        color: Colors.accents[3],
                      ),
                  textAlign: TextAlign.center)),
        ),
      );
    } else {
      return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: global.bookmarkedObjects.length,
          itemBuilder: (context, index) {
            if (global.bookmarkedObjects[index] is Event) {
              return eventBox(width, height, index, context,
                  global.bookmarkedObjects[index]);
            } else {
              return jobBox(width, height, index, context,
                  global.bookmarkedObjects[index]);
            }
          });
    }
  }

  Padding eventBox(double width, double height, int index, BuildContext context,
      Event event) {
    return Padding(
        padding: EdgeInsets.all(width / 30),
        child: Container(
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(width / 30),
              gradient: LinearGradient(colors: [
                Colors.grey.shade50,
                Colors.white,
                Colors.grey.shade50
              ])),
          child: Padding(
            padding: EdgeInsets.all(width / 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width / 1.3,
                      child: Text(event.eventTitle,
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize:
                                      MediaQuery.of(context).size.width / 25)),
                    ),
                    LikeButton(
                      isLiked: true,
                      onTap: (isLiked) async {
                        setState(() {
                          global.bookmarkedObjects
                              .removeWhere((element) => element.id == event.id);
                          removeBookmark(global.user.id, event.id);
                        });

                        return !isLiked;
                      },
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          isLiked
                              ? FontAwesomeIcons.solidBookmark
                              : FontAwesomeIcons.bookmark,
                          color: Theme.of(context).primaryColorLight,
                        );
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: width / 1.4,
                      child: Padding(
                        padding: EdgeInsets.all(width / 60),
                        child: Text(event.eventText,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: width / 35)),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        formatDate(event.time.toDate(), [
                          dd,
                          '/',
                          mm,
                          '/',
                          yyyy,
                          '  ',
                          HH,
                          ':',
                          nn,
                        ]),
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.grey.shade600, fontSize: width / 30)),
                    GFButton(
                        size: GFSize.LARGE,
                        color: Theme.of(context).primaryColor,
                        onPressed: () async {
                          var value =
                              await Get.to(() => SingleEvent(event: event));
                          if (value) {
                            setState(() {});
                          }
                        },
                        text: "Etkinliğe Git"),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Column secondMajorStrings(BuildContext context, double height, double width) {
    if (widget.user.education.secondUniversity != "") {
      return Column(
        children: [
          Text('İkinci Üniversite',
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: width / 25)),
          TextFormField(
              enabled: false,
              initialValue: widget.user.education.secondUniversity,
              decoration: InputDecoration(
                border: InputBorder.none,
              )),
          Text('İkinci Bölüm',
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: width / 25)),
          TextFormField(
              enabled: false,
              initialValue: widget.user.education.secondField,
              decoration: InputDecoration(
                border: InputBorder.none,
              )),
        ],
      );
    } else {
      return Column(
        children: [
          SizedBox.shrink(),
        ],
      );
    }
  }

  Padding jobBox(
      double width, double height, int index, BuildContext context, Job job) {
    return Padding(
        padding: EdgeInsets.all(width / 30),
        child: Container(
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(width / 30),
              gradient: LinearGradient(colors: [
                Colors.grey.shade50,
                Colors.white,
                Colors.grey.shade50
              ])),
          child: Padding(
            padding: EdgeInsets.all(width / 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width / 1.3,
                      child: Text(job.jobTitle,
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize:
                                      MediaQuery.of(context).size.width / 25)),
                    ),
                    LikeButton(
                      isLiked: true,
                      onTap: (isLiked) async {
                        setState(() {
                          global.bookmarkedObjects
                              .removeWhere((element) => element.id == job.id);
                          removeBookmarkJob(global.user.id, job.id);
                        });

                        return !isLiked;
                      },
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          isLiked
                              ? FontAwesomeIcons.solidBookmark
                              : FontAwesomeIcons.bookmark,
                          color: Theme.of(context).primaryColorLight,
                        );
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: width / 1.4,
                      child: Padding(
                        padding: EdgeInsets.all(width / 60),
                        child: Text(job.jobDescription,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: width / 35)),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        formatDate(job.time.toDate(), [
                          dd,
                          '/',
                          mm,
                          '/',
                          yyyy,
                          '  ',
                          HH,
                          ':',
                          nn,
                        ]),
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.grey.shade600, fontSize: width / 30)),
                    GFButton(
                        size: GFSize.LARGE,
                        color: Theme.of(context).primaryColor,
                        onPressed: () async {
                          var value =
                              await Get.to(() => JobApplicationPage(job: job));
                          if (value) {
                            setState(() {});
                          }
                        },
                        text: "Başvuruya Git"),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Center pageViewFirst(double height) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 18.0 * height / 1000),
        child: Container(
          height: height / 2,
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width / 30),
            child: TableCalendar(
              calendarFormat: CalendarFormat.month,
              headerStyle: HeaderStyle(formatButtonVisible: false),
              locale: 'tr_TR',
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
            ),
          ),
        ),
      ),
    );
  }

  Widget panelCategory(
      BuildContext context, String text, Icon icon, int indexNum) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _pageController.animateToPage(indexNum,
              duration: Duration(milliseconds: 100), curve: Curves.easeIn);
        },
        child: Column(
          children: [
            icon,
            Text(text,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: panelIndex == indexNum
                          ? Theme.of(context).primaryColor
                          : Colors.grey.shade500,
                    ))
          ],
        ),
      ),
    );
  }

  void _launchURL(_url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}
