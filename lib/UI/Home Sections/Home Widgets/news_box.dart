import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:greatr/UI/Companies/news.dart';
import 'package:greatr/UI/Home%20Sections/Home%20Widgets/avatar-method.dart';
import 'package:greatr/models/Event.dart';
import 'package:greatr/models/News.dart';

import '../../../constants.dart';

class NewsBox extends StatelessWidget {
  const NewsBox(
      {Key? key,
      required this.height,
      required this.width,
      required this.index,
      required this.news,
      this.image})
      : super(key: key);
  final int index;
  final News news;
  final String? image;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => SingleNews());
      },
      child: Padding(
        padding: EdgeInsets.all(8.0 * height / 1000),
        child: Container(
          width: width / 1.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade50,
          ),
          child: Padding(
            padding: EdgeInsets.all(10.0 * height / 1000),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      news.newsTitle,
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 20 * height / 1000),
                    ),
                    Text(
                      formatDate(news.time.toDate(), [
                        dd,
                        '/',
                        mm,
                        '/',
                        yyyy,
                      ]),
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.grey.shade500, fontSize: width / 30),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(5.0 * height / 1000),
                  child: Text(
                    news.paragraphs[0],
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: width / 30),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0 * height / 1000),
                  child: Text(
                    news.paragraphs[1],
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: width / 30),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0 * height / 1000),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Icon(
                          FontAwesomeIcons.chevronRight,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
