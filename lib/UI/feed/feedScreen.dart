import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:greatr/Firebase%20Functions/post_function.dart';
import 'package:greatr/Firebase%20Functions/user_functions.dart';
import 'package:greatr/UI/Profile%20Section/profile_screen.dart';
import 'package:greatr/UI/feed/postPublish.dart';
import 'package:zoom_widget/zoom_widget.dart';

import '../globals.dart' as global;
import '../../Firebase Functions/comment_function.dart';
import '../../models/comment_model.dart';
import '../../models/post_model.dart';
import 'commentScreen.dart';

class FeedScreen extends StatefulWidget {
  List<PostModel> posts;
  FeedScreen({required this.posts});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

ScrollController _feedScroll = ScrollController();
File? galleryImg;

class _FeedScreenState extends State<FeedScreen> {
  List<CommentModel> allComments = [];

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.purple,
            child: Icon(FontAwesomeIcons.plus),
            onPressed: () => Get.off(
                  () => PostPublish(posts: []),
                )),
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              "greaTR Feed",
              style: TextStyle(color: Colors.purple),
            )),
        body: RefreshIndicator(
          color: Colors.purple,
          onRefresh: () {
            return getAllPosts(widget.posts).then((value) => setState(() {
                  widget.posts = value;
                }));
          },
          child: ListView.builder(
              controller: _feedScroll,
              itemCount: widget.posts.length,
              itemBuilder: ((context, index) {
                return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection('posts')
                        .doc(widget.posts[index].postId)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data!.exists) {
                        List likedUsers = snapshot.data!.data()!['likedUsers'];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 10),
                          child: Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () => getSingleUser(
                                          widget.posts[index].composerId!)
                                      .then((value) => Get.to(
                                          () => ProfileScreen(user: value))),
                                  child: Container(
                                    width: width,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              widget.posts[index].profileImg!,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.posts[index].composer!,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              widget.posts[index].location!,
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ), //name photo
                                widget.posts[index].postImg == ""
                                    ? SizedBox.shrink()
                                    : GestureDetector(
                                  
                              
                                        onDoubleTap: () {
                                          likedUsers.contains(global.user.id)
                                              ? unLikePost(
                                                  widget.posts[index].postId!,
                                                  global.user.id)
                                              : likePost(
                                                  widget.posts[index].postId!,
                                                  global.user.id);
                                        },
                                        child: Container(
                                          width: width,
                                          height: height * 0.32,
                                          child: Image.network(
                                            widget.posts[index].postImg!,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ), //photo
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Container(
                                    child: Text(
                                      widget.posts[index].postText!,
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .bodyLarge!
                                          .copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ), //post text

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            likedUsers.contains(global.user.id)
                                                ? unLikePost(
                                                    widget.posts[index].postId!,
                                                    global.user.id)
                                                : likePost(
                                                    widget.posts[index].postId!,
                                                    global.user.id);
                                          },
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(right: 3.0),
                                            child: Icon(
                                              likedUsers
                                                      .contains(global.user.id)
                                                  ? FontAwesomeIcons.solidHeart
                                                  : FontAwesomeIcons.heart,
                                              color: Colors.purple,
                                            ),
                                          ),
                                        ),
                                        StreamBuilder<
                                                DocumentSnapshot<
                                                    Map<String, dynamic>>>(
                                            stream: FirebaseFirestore.instance
                                                .collection('posts')
                                                .doc(widget.posts[index].postId)
                                                .snapshots(),
                                            //burası
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                var likeCount = snapshot.data!
                                                    .data()!['likedUsers']
                                                    .length;
                                                return Text(
                                                  likeCount.toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                );
                                              } else {
                                                return Text(
                                                  "",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                );
                                              }
                                            }),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        GestureDetector(
                                            onTap: (() async {
                                              allComments = [];
                                              await getPostComments(
                                                      allComments,
                                                      widget
                                                          .posts[index].postId!)
                                                  .then((value) => Get.to(() =>
                                                          CommentScreen(
                                                            postId: widget
                                                                .posts[index]
                                                                .postId!,
                                                            currentPost: widget
                                                                .posts[index],
                                                            commentList: value,
                                                          ))!
                                                      .then((value) =>
                                                          allComments = []));
                                            }),
                                            child: Icon(
                                              FontAwesomeIcons.solidCommentAlt,
                                              color: Colors.purple,
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    });
              })),
        ));
  }

  Widget bottomBar(height, width, galleryImg) {
    return GestureDetector(
      child: Container(
        width: width,
        height: height * 0.08,
        color: Colors.purple,
        child: Center(
          child: IconButton(
              onPressed: () => Get.off(() => PostPublish(posts: [])),
              icon: Icon(
                FontAwesomeIcons.plus,
                color: Colors.white,
                size: height * 0.05,
              )),
        ),
      ),
    );
  }
}
