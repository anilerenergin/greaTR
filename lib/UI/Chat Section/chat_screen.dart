import 'dart:io';

import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:greatr/Firebase%20Functions/chat_functions.dart';
import 'package:greatr/Firebase%20Functions/user_functions.dart';
import 'package:greatr/UI/Profile%20Section/profile_screen.dart';
import '../globals.dart' as global;
import 'package:greatr/UI/Onboarding/onboarding.dart';
import 'package:greatr/models/Message.dart';
import 'package:greatr/models/User.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class ChatScreen extends StatefulWidget {
  String chatRoomId;
  String title;
  String type;
  Stream<QuerySnapshot> messageStream;
  UserModel user;
  String? otherUserId;
  ChatScreen({
    Key? key,
    required this.type,
    required this.chatRoomId,
    required this.title,
    required this.messageStream,
    required this.user,
    this.otherUserId,
  }) : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool lastMessageIsMine = false;
  String messageText = '';
  Message? message;
  TextEditingController textEditingController = TextEditingController();
  ScrollController _scrollController =
      ScrollController(initialScrollOffset: 100);
  void scrollToBottom() {
    final bottomOffset = _scrollController.position.minScrollExtent;
    _scrollController.jumpTo(
      bottomOffset,
    );
  }

  Message? lastMessage;
  @override
  void initState() {
    print(widget.type);
    Future.delayed(Duration(milliseconds: 500)).then((value) {
      _scrollController.jumpTo(
        _scrollController.position.minScrollExtent,
      );
    });

    widget.messageStream.listen((event) {
      if (_scrollController.hasClients) {
        if (event.docChanges.isNotEmpty) {
          print(event.docs.length);
          Map<String, dynamic> data2 =
              event.docs[event.docs.length - 1].data()! as Map<String, dynamic>;
          Message last = Message.fromMap(data2);
          print(last.date);
          _scrollController.jumpTo(
            _scrollController.position.minScrollExtent,
          );
        }
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
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.chevronLeft,
                color: Colors.black, size: width / 15),
            onPressed: () {
              if (widget.type == 'priv') {
                Navigator.pop(context, true);
              } else {
                Navigator.pop(context);
              }
            }),
        title: Text(
          widget.title,
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(fontSize: width / 20),
        ),
        actions: <Widget>[
          widget.type == 'priv'
              ? IconButton(
                  icon: Icon(FontAwesomeIcons.flag),
                  iconSize: width / 20,
                  color: Colors.red,
                  onPressed: () async {
                    bool value = await reportDialog();
                  },
                )
              : SizedBox(),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: widget.messageStream,
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Center(
                                child: Text(
                                  'Yükleniyor',
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                              );

                            default:
                              if (snapshot.hasData) {
                                if (lastMessage == null) {
                                  print('aa');
                                  Map<String, dynamic> data =
                                      snapshot.data!.docs.last.data()!
                                          as Map<String, dynamic>;
                                  lastMessage = Message.fromMap(data);
                                }

                                return ListView.builder(
                                    reverse: true,
                                    padding: EdgeInsets.all(width / 20),
                                    controller: _scrollController,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      Map<String, dynamic> data =
                                          snapshot.data!.docs[index].data()!
                                              as Map<String, dynamic>;
                                      Message message = Message.fromMap(data);
                                      if (!widget.user.blockedUsers
                                          .contains(message.senderId)) {
                                        return _buildMessage(
                                            message,
                                            FirebaseAuth.instance.currentUser!
                                                    .uid ==
                                                data['senderId']);
                                      } else {
                                        return SizedBox();
                                      }
                                    });
                              } else {
                                return SizedBox();
                              }
                          }
                        })),
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessage(Message message, bool isMe) {
    if (isMe) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              widget.type != 'priv'
                  ? Text(message.senderName,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: MediaQuery.of(context).size.width / 30))
                  : SizedBox(
                      height: MediaQuery.of(context).size.width / 60,
                    ),
              Bubble(
                alignment: Alignment.topLeft,
                nip: BubbleNip.rightCenter,
                color: Theme.of(context).primaryColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.55,
                            minWidth: MediaQuery.of(context).size.width * 0.15,
                          ),
                          child: Text(
                            message.text,
                            textAlign: TextAlign.right,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: Colors.white,
                                    fontSize: 19 *
                                        MediaQuery.of(context).size.height /
                                        1000),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      formatDate(message.date, [
                        HH,
                        ':',
                        nn,
                      ]),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.white),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return GestureDetector(
        onTap:()=>getSingleUser(widget.otherUserId!).then((value) => Get.to(ProfileScreen(user: value))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    widget.type != 'priv'
                        ? Text(message.senderName,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 30))
                        : SizedBox(
                            height: MediaQuery.of(context).size.width / 60,
                          ),
                    widget.type == 'community'
                        ? GestureDetector(
                            onTap: () async {
                              bool value = await reportDialog();
                              if (value) {
                                setState(() {
                                  widget.user.blockedUsers.add(message.senderId);
                                });
                                blockUser(widget.user.id, message.senderId);
                              } else {
                                Get.snackbar(
                                    message.senderName, 'Kullanıcı Raporlandı',
                                    borderColor: Colors.red,
                                    borderWidth: 2,
                                    snackPosition: SnackPosition.TOP);
                              }
                            },
                            child: Text(
                              'Rapor',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: Colors.red,
                                      fontSize:
                                          MediaQuery.of(context).size.width / 30,
                                      decoration: TextDecoration.underline),
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
                Bubble(
                  margin: BubbleEdges.only(top: 10),
                  alignment: Alignment.topLeft,
                  nip: BubbleNip.leftCenter,
                  color: Color(0xFF8F9BB3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.55,
                              minWidth: MediaQuery.of(context).size.width * 0.15,
                            ),
                            child: Text(
                              message.text,
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: Colors.white,
                                      fontSize: 19 *
                                          MediaQuery.of(context).size.height /
                                          1000),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            formatDate(message.date, [
                              HH,
                              ':',
                              nn,
                            ]),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }

  Future<dynamic> reportDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          if (Platform.isIOS) {
            return CupertinoAlertDialog(
                content: Text('Hangi Eylemi Yapmak İstersiniz'),
                actions: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context, true);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(
                            20.0 * MediaQuery.of(context).size.height / 1000),
                        child: Center(
                            child: Text('Blokla',
                                style: Theme.of(context).textTheme.bodyText1)),
                      )),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context, false);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(
                            20.0 * MediaQuery.of(context).size.height / 1000),
                        child: Center(
                            child: Text('Raporla',
                                style: Theme.of(context).textTheme.bodyText1)),
                      ))
                ]);
          } else {
            return AlertDialog(
                title: Text('Hangi Eylemi Yapmak İstersiniz'),
                actions: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context, true);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(
                            20.0 * MediaQuery.of(context).size.height / 1000),
                        child: Center(
                            child: Text('Blokla',
                                style: Theme.of(context).textTheme.bodyText1)),
                      )),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context, false);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(
                            20.0 * MediaQuery.of(context).size.height / 1000),
                        child: Center(
                            child: Text('Raporla',
                                style: Theme.of(context).textTheme.bodyText1)),
                      ))
                ]);
          }
        });
  }

  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 30),
              child: TextField(
                controller: textEditingController,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (value) {
                  setState(() {
                    messageText = value;
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: ' Mesaj Gönder',
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: MediaQuery.of(context).size.width / 15,
            color: Theme.of(context).primaryColor,
            onPressed: () async {
              if (widget.otherUserId != null) {
                sendPrivChatMessage(
                    widget.user.name,
                    widget.otherUserId!,
                    textEditingController.text.toString(),
                    widget.chatRoomId,
                    widget.user.imageUrl != null
                        ? widget.user.imageUrl!
                        : 'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png');
              }

              message = Message(
                  senderName: widget.user.name,
                  chatRoomId: widget.chatRoomId,
                  senderId: FirebaseAuth.instance.currentUser!.uid,
                  text: messageText,
                  date: DateTime.now());
              await FirebaseFirestore.instance
                  .collection('messages')
                  .add(message!.toMap());
              textEditingController.value = TextEditingValue(text: '');
            },
          ),
        ],
      ),
    );
  }
}
