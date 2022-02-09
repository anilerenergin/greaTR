import 'package:carousel_slider/carousel_slider.dart';
import 'package:date_format/date_format.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:greatr/Firebase%20Functions/bookmarks.dart';
import 'package:greatr/Firebase%20Functions/event_functions.dart';
import 'package:greatr/models/Event.dart';
import 'package:like_button/like_button.dart';
import '../globals.dart' as global;

class SingleEvent extends StatefulWidget {
  SingleEvent({required this.event});
  Event event;
  @override
  _SingleEventState createState() => _SingleEventState();
}

int categoryNum = 0;
int substringCountForAbout = 150;
int substringCountForOffice = 150;
int carouselIndex = 0;
bool isliked = false;

class _SingleEventState extends State<SingleEvent> {
  CarouselController _controller = CarouselController();
  @override
  void initState() {
    print(global.bookmarks.bookmarks);
    global.bookmarks.bookmarks.forEach((element) {
      if (element.bookMarkId == widget.event.id) {
        isliked = true;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: bottomNavy(width, height, context),
      body: Container(
        color: Colors.white,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Stack(
              children: [
                imageStack(height, width, context),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Stack(
                    children: [
                      Container(
                        height: height / 1.45,
                        width: width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Padding(
                          padding: EdgeInsets.all(width / 20),
                          child: ListView(
                            padding: EdgeInsets.zero,
                            children: [
                              indicatorForCarousel(width, height),
                              SizedBox(
                                height: width / 20,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: width / 1.2,
                                    child: Text(
                                      widget.event.eventTitle,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1!
                                          .copyWith(fontSize: width / 20),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: width / 20,
                              ),
                              Text(widget.event.eventText,
                                  style: Theme.of(context).textTheme.bodyText1),
                              SizedBox(
                                height: width / 8,
                              ),
                              infoRow(
                                  width,
                                  context,
                                  widget.event.location.city,
                                  FontAwesomeIcons.locationArrow),
                              SizedBox(
                                height: width / 15,
                              ),
                              infoRow(
                                  width,
                                  context,
                                  formatDate(widget.event.time.toDate(), [
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
                                  FontAwesomeIcons.clock),
                              SizedBox(
                                height: width / 15,
                              ),
                              infoRow(
                                  width,
                                  context,
                                  widget.event.organizerName,
                                  FontAwesomeIcons.user),
                            ],
                          ),
                        ),
                      ),
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

  Container bottomNavy(double width, double height, BuildContext context) {
    return Container(
      color: Colors.white,
      width: width,
      child: Padding(
        padding: EdgeInsets.all(width / 30),
        child: Row(
          children: [
            Expanded(
                flex: 20,
                child: widget.event.time.toDate().isBefore(DateTime.now())
                    ? GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: height / 15,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(width / 30),
                              color: Colors.grey.shade300),
                          child: Center(

                            child: Text("Etkinlik Sona Erdi",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                        color: Colors.grey.shade700,
                                        fontSize: width / 25)),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          if (widget.event.attendedUsers
                              .contains(global.user.id)) {
                            setState(() {
                              widget.event.attendedUsers.remove(global.user.id);
                            });

                            unAttendEvent(widget.event.id, global.user.id);
                            Get.snackbar(
                                global.user.name, 'Etkinlik Kaydınız Silindi',
                                borderColor: Colors.red,
                                borderWidth: 2,
                                snackPosition: SnackPosition.TOP);
                          } else {
                            setState(() {
                              attendEvent(widget.event.id, global.user.id);
                            });

                            widget.event.attendedUsers.add(global.user.id);
                            Get.snackbar(global.user.name,
                                'Etkinliğe Başarıyla Kaydoldunuz',
                                borderColor: Colors.green,
                                borderWidth: 2,
                                snackPosition: SnackPosition.TOP);
                          }
                        },
                        child: Container(
                          height: height / 15,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(width / 30),
                              color: Theme.of(context).primaryColor),
                          child: Center(
                            child: Text(
                                widget.event.attendedUsers
                                        .contains(global.user.id)
                                    ? 'Kaydını Sil'
                                    : 'Şimdi Katıl',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                        color: Colors.white,
                                        fontSize: width / 25)),
                          ),
                        ),
                      )),
            Expanded(
              flex: 1,
              child: SizedBox(),
            ),widget.event.time.toDate().isBefore(DateTime.now())?SizedBox.shrink():
            Expanded(
              flex: 4,
              child: Container(
                height: height / 15,
                child: Center(
                  child: LikeButton(
                    isLiked: isliked,
                    onTap: (isLiked) async {
                      if (isLiked) {
                        Get.snackbar(widget.event.eventTitle,
                            'Etkinlik Kaydettiklerinizden Silindi',
                            borderColor: Colors.red,
                            borderWidth: 2,
                            snackPosition: SnackPosition.TOP);
                        global.bookmarkedObjects.removeWhere(
                            (element) => element.id == widget.event.id);
                        removeBookmark(global.user.id, widget.event.id);
                      } else {
                        Get.snackbar(widget.event.eventTitle,
                            'Etkinlik Kaydettiklerinize Eklendi',
                            borderColor: Colors.green,
                            borderWidth: 2,
                            snackPosition: SnackPosition.TOP);
                        bookmarkEvent(global.user.id, widget.event.id);
                      }
                      setState(() {
                        isliked = !isliked;
                      });
                      return !isLiked;
                    },
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        isLiked
                            ? FontAwesomeIcons.solidBookmark
                            : FontAwesomeIcons.bookmark,
                        color: Colors.grey.shade700,
                      );
                    },
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(width / 30)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Row infoRow(double width, BuildContext context, String text, IconData icon) {
    return Row(
      children: [
        iconBox(width, context, icon),
        SizedBox(
          width: width / 10,
        ),
        Text(text,
            style: Theme.of(context).textTheme.headline2!.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold)),
      ],
    );
  }

  Container iconBox(double width, BuildContext context, IconData icon) {
    return Container(
      width: width / 8,
      height: width / 8,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }

  Center indicatorForCarousel(double width, double height) {
    return Center(
      child: Container(
        height: width / 18,
        width: width / 8,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.event.images.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(height / 300),
                child: Container(
                  width: width / 40,
                  height: width / 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: carouselIndex == index
                          ? Theme.of(context).primaryColor
                          : Colors.grey.shade300),
                ),
              );
            }),
      ),
    );
  }

  Widget imageStack(double height, double width, BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          carouselController: _controller,
          items: widget.event.images
              .map((e) => carouseltem(height, width, context, e, 0))
              .toList(),
          options: CarouselOptions(
              autoPlay: true,
              height: height / 2.1,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  carouselIndex = index;
                });
              }),
        ),
        popButton(height, width, context),
      ],
    );
  }

  Widget carouseltem(double height, double width, BuildContext context,
      String url, int index) {
    return Container(
      height: height / 2.5,
      child: ExtendedImage.network(
        url,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}

Widget popButton(double height, double width, BuildContext context) {
  return Align(
    alignment: Alignment.topLeft,
    child: Padding(
      padding: EdgeInsets.all(45.0 * height / 1000),
      child: IconButton(
          onPressed: () {
            isliked = false;
            Navigator.pop(context, true);
          },
          icon: Icon(
            FontAwesomeIcons.arrowLeft,
            color: Theme.of(context).primaryColor,
            size: width / 15,
          )),
    ),
  );
}
