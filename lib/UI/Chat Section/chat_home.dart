import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:greatr/Firebase%20Functions/chat_functions.dart';
import 'package:greatr/Firebase%20Functions/user_functions.dart';
import 'package:greatr/UI/Profile%20Section/profile_screen.dart';
import 'package:greatr/models/Message.dart';
import 'package:greatr/models/PrivateChatRoom.dart';
import 'package:line_icons/line_icons.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import '../globals.dart' as global;
import 'package:greatr/UI/Chat%20Section/chat_screen.dart';
import 'package:greatr/models/ChatRoom.dart';
import 'package:greatr/models/User.dart';

class ChatHomeScreen extends StatefulWidget {
  List<ChatRoom> rooms;
  UserModel user;
  List<UserModel> allUsers;
  ChatHomeScreen({
    Key? key,
    required this.rooms,
    required this.user,
    required this.allUsers,
  }) : super(key: key);

  @override
  _ChatHomeScreenState createState() => _ChatHomeScreenState();
}

List<UserModel> users = [];

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  late Future futureOperation;
  PageController _pageController = PageController();
  int pageIndex = 0;
  @override
  void initState() {
    widget.rooms.forEach((element) {
      if (element.title == global.user.location.city) {
        ChatRoom room = element;
        widget.rooms.remove(element);
        widget.rooms.insert(0, room);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  _pageController.animateToPage(0,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                },
                child: Text('Topluluklar',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: width / 20,
                        color: pageIndex == 0
                            ? Colors.black
                            : Colors.grey.shade500),
                    textAlign: TextAlign.center),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  _pageController.animateToPage(1,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                },
                child: Text(
                  'Konuşmalar',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: width / 20,
                      color:
                          pageIndex == 1 ? Colors.black : Colors.grey.shade500),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        children: [
          community(height, width),
  
        single(height, width),//buildFloatingSearchBar()
          
        ],
      ),
    );
  }

  Widget single(double height, double width) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('private_chat_rooms')
                      .where('participants', arrayContains: global.user.id)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return widget.user.privateChatRoomIds.length == 0
                          ? Center(
                              child: Text('Henüz Bir Konuşmanız Yok',
                                  style:
                                      Theme.of(context).textTheme.headline1),
                            )
                          : ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> data =
                                    snapshot.data!.docs[index].data()!
                                        as Map<String, dynamic>;
                                PrivateChatRoom privRoom =
                                    PrivateChatRoom.fromMap(data);

                                return GestureDetector(
                                  onTap: () async {
                                    global.currentChatRoomId =
                                        privRoom.roomId!;
                                    Stream<QuerySnapshot> messageStream =
                                        FirebaseFirestore.instance
                                            .collection('messages')
                                            .where('chatRoomId',
                                                isEqualTo: privRoom.roomId)
                                            .orderBy('date', descending: true)
                                            .snapshots();

                                    var value = await Get.to(() => ChatScreen(
                                          type: 'priv',
                                          chatRoomId: privRoom.roomId!,
                                          title: privRoom
                                                      .participantNames[0] ==
                                                  privRoom.participantNames[1]
                                              ? privRoom.participantNames[0]
                                              : privRoom.participantNames
                                                  .where((element) =>
                                                      element !=
                                                      global.user.name)
                                                  .first,
                                          messageStream: messageStream,
                                          user: global.user,
                                          otherUserId: privRoom.participants
                                              .where((element) =>
                                                  element != global.user.id)
                                              .first,
                                        ));
                                    if (value) {
                                      setState(() {
                                        global.currentChatRoomId = '';
                                      });
                                      print(global.currentChatRoomId);
                                    }
                                  },
                                  child: GFListTile(
                                      icon:
                                          Icon(FontAwesomeIcons.chevronRight),
                                      titleText: privRoom
                                                  .participantNames[0] ==
                                              privRoom.participantNames[1]
                                          ? privRoom.participantNames[0]
                                          : privRoom.participantNames
                                              .where((element) =>
                                                  element != global.user.name)
                                              .first),
                                );
                              });
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  })),
        ),
      ],
    );
  }

  Widget community(double height, double width) {
    return Padding(
      padding: EdgeInsets.all(8.0 * height / 1000),
      child: Container(
        child: ListView.builder(
            itemCount: widget.rooms.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(8.0 * height / 1000),
                child: Container(
                  width: width / 1.2,
                 
                  child: GestureDetector(
                    onTap: () {
                      Stream<QuerySnapshot> messageStream = FirebaseFirestore
                          .instance
                          .collection('messages')
                          .where('chatRoomId',
                              isEqualTo: widget.rooms[index].id)
                          .orderBy('date', descending: true)
                          .snapshots();
                      Get.to(() => ChatScreen(
                            type: 'community',
                            user: widget.user,
                            title: widget.rooms[index].title,
                            chatRoomId: widget.rooms[index].id,
                            messageStream: messageStream,
                          ));
                    },
                    child: GFListTile(
                      avatar: GFAvatar(
                          backgroundImage:
                              NetworkImage(widget.rooms[index].imageUrl)),
                      title: Text(
                        widget.rooms[index].title,
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(fontSize: width / 25),
                      ),
                      subTitleText: widget.rooms[index].location,
                      icon: GestureDetector(
                          onTap: () {
                            Stream<QuerySnapshot> messageStream =
                                FirebaseFirestore.instance
                                    .collection('messages')
                                    .where('chatRoomId',
                                        isEqualTo: widget.rooms[index].id)
                                    .orderBy('date', descending: true)
                                    .snapshots();
                            Get.to(() => ChatScreen(
                                  type: 'community',
                                  user: widget.user,
                                  title: widget.rooms[index].title,
                                  chatRoomId: widget.rooms[index].id,
                                  messageStream: messageStream,
                                ));
                          },
                          child: Icon(FontAwesomeIcons.chevronRight)),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      backdropColor: Colors.transparent,
      backgroundColor: Colors.grey.shade100,

      hint: 'Kullanıcı Ara',
      scrollPadding: EdgeInsets.only(
          right: MediaQuery.of(context).size.width / 20,
          left: MediaQuery.of(context).size.width / 20,
          top: MediaQuery.of(context).size.width / 30,
          bottom: MediaQuery.of(context).size.width / 40),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: MediaQuery.of(context).size.width / 1.2,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) async {
        setState(() {
          users.clear();
        });

        AlgoliaQuery algQuery =
            global.algolia.instance.index('name').query(query);
        AlgoliaQuerySnapshot snap = await algQuery.getObjects();
        snap.hits.forEach((element) {
          setState(() {
            users.add(UserModel.fromMap(element.toMap()));
          });
        });
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),

      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.grey.shade100,
            elevation: 4.0,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: users
                    .map((e) => Column(
                          children: [
                            GFListTile(
                              icon: GestureDetector(
                                  onTap: () {
                                    Get.to(() => ProfileScreen(user: e));
                                  },
                                  child: Icon(FontAwesomeIcons.user)),
                              onTap: () {
                                checkUserPrivateChatRooms(global.user, e)
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
                              titleText: e.name,
                            ),
                            Divider()
                          ],
                        ))
                    .toList()),
          ),
        );
      },
    );
  }
}
