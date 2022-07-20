import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:greatr/UI/splash/splash.dart';
import 'package:greatr/UI/splash/splash_in_app.dart';
import '../globals.dart' as global;
import '../../Firebase Functions/add_image.dart';
import '../../Firebase Functions/add_post_function.dart';
import '../../Firebase Functions/post_function.dart';
import '../../models/post_model.dart';

class PostPublish extends StatefulWidget {
  List<PostModel> posts;
  PostPublish({required this.posts});

  State<PostPublish> createState() => _PostPublishState();
}

File? galleryImg;

class _PostPublishState extends State<PostPublish> {
  TextEditingController postDesc = TextEditingController();

  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.off(
                    () => SplashAlt(notificationReceived: false, pageIndex: 0));
              },
              icon: Icon(
                FontAwesomeIcons.arrowLeft,
                color: Theme.of(context).primaryColor,
              )),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Gönderi Paylaş",
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          actions: [
            IconButton(
                onPressed: galleryImg != null
                    ? (fieldValidator(postDesc.text.trim())
                        ? () async {
                            widget.posts = [];
                            await uploadFile(galleryImg)
                                .then((value) => loadImage(value))
                                .then((value) => addNewPost(
                                    global.user.name,
                                    global.user.id,
                                    global.user.location.country,
                                    postDesc.text,
                                    global.user.imageUrl ??
                                        "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png",
                                    value,
                                    DateTime.now()));

                            getAllPosts(widget.posts).then((value) => Get.off(
                                () => SplashAlt(
                                    notificationReceived: false,
                                    pageIndex: 1)));
                          }
                        : () =>
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                               duration: Duration(seconds:1),
                              content: Text("Lütfen bir şeyler yazınız"),
                              backgroundColor: Colors.grey[800],
                            )))
                    : (fieldValidator(postDesc.text.trim())
                        ? () async {
                            widget.posts = [];

                            addNewPost(
                                global.user.name,
                                global.user.id,
                                global.user.location.country,
                                postDesc.text,
                                global.user.imageUrl ??
                                    "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png",
                                "",
                                DateTime.now());

                            getAllPosts(widget.posts)
                                .then((value) => Get.off(() => SplashAlt(
                                      notificationReceived: false,
                                      pageIndex: 0,
                                    )));
                          }
                        : () {
                            print(postDesc.text);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: Duration(seconds:1),
                              content: Text("Lütfen bir şeyler yazın"),
                              backgroundColor: Colors.grey[800],
                            ));
                          }),
                icon: Icon(
                  FontAwesomeIcons.check,
                  color: Theme.of(context).primaryColor,
                ))
          ],
        ),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () =>
                        imgFromGallery(galleryImg).then((value) => setState(() {
                              galleryImg = value;
                            })),
                    child: galleryImg != null
                        ? Image.file(
                            galleryImg!,
                            width: width * 0.9,
                            height: height * 0.7,
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: height * 0.1,
                            ),
                            child: Container(
                              width: width * 0.9,
                              height: height * 0.5,
                              decoration: BoxDecoration(
                                  color: Colors.grey[400]!.withAlpha(100),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(FontAwesomeIcons.camera),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Fotoğraf Ekle",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: width * 0.035),
                                  ),
                                ],
                              )),
                            ),
                          ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: width,
                height: height * 0.08,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextFormField(
                      controller: postDesc,
                      onChanged: (value) {},
                      decoration: const InputDecoration(
                        hintText: "Açıklama yazınız",
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

bool fieldValidator(String value) {

    return true;
  

}
