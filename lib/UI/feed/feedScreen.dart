import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:greatr/UI/feed/postPublish.dart';

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
  List likedPosts = [];
  @override
  void initState() {
    // TODO: implement initState
  Future.delayed(const Duration(milliseconds: 300));
        SchedulerBinding.instance?.addPostFrameCallback((_) {
           _feedScroll.animateTo(
           _feedScroll.position.maxScrollExtent,
           duration: const Duration(milliseconds: 400),
           curve: Curves.fastOutSlowIn);
        });
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
        body: ListView.builder(
            controller: _feedScroll,
            reverse: true,
            itemCount: widget.posts.length,
            itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: width,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  widget.posts[index].profileImg!,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.posts[index].composer!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  widget.posts[index].location!,
                                  style: const TextStyle(color: Colors.grey),
                                )
                              ],
                            )
                          ],
                        ),
                      ), //name photo
                      widget.posts[index].postImg == ""
                          ? SizedBox.shrink()
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: GestureDetector(
                                onDoubleTap: () {
                                  //LIKE listesine ekle çıkart
                                },
                                child: Container(
                                    width: width,
                                    height: height * 0.3,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                widget.posts[index].postImg!),
                                            fit: BoxFit.fill))),
                              ),
                            ), //photo
                      Container(
                        child: Text(widget.posts[index].postText!),
                      ), //post text
                      SizedBox(
                        height: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  //like listesine ekle çıkar
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                    FontAwesomeIcons.heart,
                                    color: Colors.purple,
                                  ),
                                ),
                              ),
                              StreamBuilder<
                                      DocumentSnapshot<Map<String, dynamic>>>(
                                  stream: FirebaseFirestore.instance
                                      .collection('posts')
                                      .doc(widget.posts[index].postId)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      var likeCount =
                                          snapshot.data!.data()!['likeCount'];
                                      return Text(
                                        likeCount.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      );
                                    } else {
                                      return Text(
                                        "",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      );
                                    }
                                  })
                            ],
                          ),
                        ],
                      ),

                      GestureDetector(
                        onTap: (() async {
                          allComments = [];
                          await getPostComments(
                                  allComments, widget.posts[index].postId!)
                              .then((value) => Get.to(CommentScreen(
                                    postId: widget.posts[index].postId!,
                                    currentPost: widget.posts[index],
                                    commentList: value,
                                  ))!
                                      .then((value) => allComments = []));
                        }),
                        child: Text(
                          "Yorumlar..",
                          style: TextStyle(color: Colors.purple),
                        ),
                      ) //like comment
                    ],
                  ),
                ),
              );
            })));
  }

  Widget bottomBar(height, width, galleryImg) {
    return GestureDetector(
      child: Container(
        width: width,
        height: height * 0.08,
        color: Colors.purple,
        child: Center(
          child: IconButton(
              onPressed: () => Get.to(() => PostPublish(posts: [])),
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
