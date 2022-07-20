import 'package:get/get.dart';
import 'package:greatr/Firebase%20Functions/user_functions.dart';
import 'package:greatr/UI/Profile%20Section/profile_screen.dart';
import 'package:greatr/models/User.dart';

import '../../Firebase Functions/post_function.dart';
import '../globals.dart' as global;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Firebase Functions/comment_function.dart';
import '../../models/comment_model.dart';
import '../../models/post_model.dart';

class CommentScreen extends StatefulWidget {
  String postId;
  PostModel currentPost;
  List<CommentModel> commentList;

  CommentScreen(
      {required this.postId,
      required this.currentPost,
      required this.commentList});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    TextEditingController commentField = TextEditingController();
    ScrollController _scrollController = ScrollController();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Theme.of(context).primaryColor, //change your color here
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "GreaTR",
            style: TextStyle(color: Theme.of(context).primaryColor),
          )),
      body: Stack(
        children: [
          Container(
            height: height - height * 0.08,
            child: ListView(
              controller: _scrollController,
              children: [
                StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection('posts')
                        .doc(widget.currentPost.postId)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List likedUsers = snapshot.data!.data()!['likedUsers'];
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
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            widget.currentPost.profileImg!,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.currentPost.composer!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            widget.currentPost.location!,
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ), //name photo
                                widget.currentPost.postImg == ""
                                    ? SizedBox.shrink()
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: GestureDetector(
                                          onDoubleTap: () {
                                            likedUsers.contains(global.user.id)
                                                ? unLikePost(
                                                    widget.currentPost.postId!,
                                                    global.user.id)
                                                : likePost(
                                                    widget.currentPost.postId!,
                                                    global.user.id);
                                          },
                                          child: Container(
                                              width: width,
                                              height: height * 0.3,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(widget
                                                          .currentPost
                                                          .postImg!),
                                                      fit: BoxFit.contain))),
                                        ),
                                      ), //photo
                                Container(
                                  child: Text(widget.currentPost.postText!),
                                ), //post text
                             
                               
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            likedUsers.contains(global.user.id)
                                                ? unLikePost(
                                                    widget.currentPost.postId!,
                                                    global.user.id)
                                                : likePost(
                                                    widget.currentPost.postId!,
                                                    global.user.id);
                                          },
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(right: 8.0),
                                            child: Icon(
                                              likedUsers
                                                      .contains(global.user.id)
                                                  ? FontAwesomeIcons.solidHeart
                                                  : FontAwesomeIcons.heart,
                                              color:Theme.of(context).primaryColor,
                                            ),
                                          ),
                                        ),
                                        StreamBuilder<
                                                DocumentSnapshot<
                                                    Map<String, dynamic>>>(
                                            stream: FirebaseFirestore.instance
                                                .collection('posts')
                                                .doc(widget.currentPost.postId)
                                                .snapshots(),
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
                                            })
                                      ],
                                    )
                                  ],
                                
                              
                            ),
                          ),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.commentList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () =>
                            getSingleUser(widget.commentList[index].composerId!)
                                .then((value) =>
                                    Get.to(ProfileScreen(user: value))),
                        child: ListTile(
                            title: Text(
                                widget.commentList[index].composer!.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * 0.05,
                                    color: Theme.of(context).primaryColor)),
                            subtitle: Text(
                                widget.commentList[index].comment!.toString(),
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.7),
                                ))),
                      );
                    }),
                SizedBox(
                  height: height * 0.1,
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                decoration: BoxDecoration(
                 color: Theme.of(context).primaryColor,
                ),
                width: width,
                height: height * 0.08,
                child: Row(
                  children: [
                    Container(
                      width: width * 0.86,
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 3),
                        child: TextFormField(
                          onTap: () {
                            setState(() {
                              _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: Duration(seconds: 1),
                                curve: Curves.fastOutSlowIn,
                              );
                            });
                          },
                          controller: commentField,
                          decoration: const InputDecoration(
                            hintText: "Yorum yazınız",
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )),
                    ),
                    IconButton(
                        onPressed: fieldValidator(commentField.text.trim())
                            ? () async {
                                await addPostComment(
                                        widget.postId,
                                        global.user.id,
                                        commentField.text,
                                        global.user.name,
                                        DateTime.now())
                                    .then((value) => widget.commentList = [])
                                    .then((value) => getPostComments(
                                            widget.commentList, widget.postId)
                                        .then((value) =>
                                            widget.commentList = value));
                                setState(() {
                                  _scrollController.animateTo(
                                    _scrollController.position.maxScrollExtent,
                                    duration: Duration(seconds: 1),
                                    curve: Curves.fastOutSlowIn,
                                  );
                                });
                                FocusScope.of(context).unfocus();
                              }
                            : () => ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  duration: Duration(seconds: 1),
                                  content: Text("Lütfen bir şeyler yazınız"),
                                  backgroundColor: Colors.grey[800],
                                )),
                        icon: const Icon(
                          FontAwesomeIcons.solidPaperPlane,
                          color: Colors.white,
                        ))
                  ],
                )),
          )
        ],
      ),
    );
  }
}

bool fieldValidator(String value) {
  return true;
}
