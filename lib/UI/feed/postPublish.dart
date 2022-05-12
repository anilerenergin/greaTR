import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:greatr/UI/splash/splash.dart';

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
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Get.off(SplashScreen(notificationReceived: false,pageIndex: 1,));
                },
                icon: const Icon(
                  FontAwesomeIcons.arrowLeft,
                  color: Colors.black,
                )),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              "greaTR Feed",
              style: TextStyle(color: Colors.indigoAccent),
            )),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Gönderi Paylaş",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: width * 0.06),
            ),
            GestureDetector(
              onTap: () =>
                  imgFromGallery(galleryImg).then((value) => setState(() {
                        galleryImg = value;
                      })),
              child: galleryImg != null
                  ? Container(
                      child: Image.file(
                        galleryImg!,
                        height: MediaQuery.of(context).size.height / 5,
                      ),
                    )
                  : Container(
                      width: width * 0.3,
                      height: height * 0.04,
                      decoration: BoxDecoration(
                          color: Colors.indigoAccent,
                          borderRadius: BorderRadius.all(Radius.circular(200))),
                      child: Center(
                          child: Text(
                        "+ Fotoğraf Ekle",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.035),
                      )),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: width,
                decoration: BoxDecoration(
                    color: Colors.indigoAccent,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextFormField(
                    controller: postDesc,
                    onTap: () {},
                    decoration: const InputDecoration(
                      hintText: "Yorum yazınız",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
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
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: galleryImg != null
                    ? (() async {
                        widget.posts = [];
                        await uploadFile(galleryImg)
                            .then((value) => loadImage(value))
                            .then((value) => addNewPost(
                                "Anıl Eren",
                                "İstanbul",
                                postDesc.text,
                                "https://media-exp1.licdn.com/dms/image/C5603AQGXeUT5orK80A/profile-displayphoto-shrink_200_200/0/1609883170432?e=1652918400&v=beta&t=UhGtUZUc5LYQsMcwJiRKjPdUCz3O2e6Ni-_tGKf14YU",
                                value,
                                DateTime.now()));
                        getAllPosts(widget.posts)
                            .then((value) => Get.off(() =>SplashScreen(notificationReceived: false,pageIndex:1)));
                      })
                    : (() async {
                        widget.posts = [];
                        await addNewPost(
                            "Anıl Eren",
                            "İstanbul",
                            postDesc.text,
                            "https://media-exp1.licdn.com/dms/image/C5603AQGXeUT5orK80A/profile-displayphoto-shrink_200_200/0/1609883170432?e=1652918400&v=beta&t=UhGtUZUc5LYQsMcwJiRKjPdUCz3O2e6Ni-_tGKf14YU",
                            "",
                            DateTime.now());

                        getAllPosts(widget.posts)
                            .then((value) => Get.off(() => SplashScreen(notificationReceived: false,pageIndex: 1,)));
                      }),
                child: Container(
                  width: 100,
                  height: 40,
                  decoration: const BoxDecoration(
                      color: Colors.indigoAccent,
                      borderRadius: BorderRadius.all(Radius.circular(200))),
                  child: Center(
                      child: Text(
                    "Paylaş",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            )
          ],
        ));
  }
}
