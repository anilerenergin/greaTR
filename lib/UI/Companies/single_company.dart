import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/shape/gf_avatar_shape.dart';
import 'package:greatr/UI/Companies/job_application.dart';
import 'package:greatr/UI/Companies/news.dart';
import 'package:greatr/models/Company.dart';
import 'package:greatr/models/Event.dart';
import 'package:greatr/models/Job.dart';
import 'package:greatr/models/News.dart';

import 'package:like_button/like_button.dart';

class SingleCompany extends StatefulWidget {
  SingleCompany(
      {required this.company,
      required this.jobs,
      required this.news,
      required this.events});
  Company company;
  List<Job> jobs;
  List<News> news;
  List<Event> events;
  @override
  _SingleCompanyState createState() => _SingleCompanyState();
}

int categoryNum = 0;

class _SingleCompanyState extends State<SingleCompany> {
  PageController _pageController = PageController();
  int pageIndex = 0;
  PageController _pageController2 = PageController();
  @override
  void initState() {
    print(widget.company.social);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                          height: height / 1.35,
                          width: width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: Column(
                            children: [
                              headerTile(context),
                              categorPicker(height, width),
                              Expanded(
                                child: PageView(
                                  controller: _pageController,
                                  onPageChanged: (index) {
                                    setState(() {
                                      categoryNum = index;
                                    });
                                  },
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width / 30),
                                        child: page1(height, width, context)),
                                    page2(width),
                                    page3(width, height),
                                    page4(width, height),
                                  ],
                                ),
                              ),
                            ],
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
      ),
    );
  }

  Container page3(double width, double height) {
    return Container(
      color: Colors.white,
      child: widget.news.length == 0
          ? Center(
              child: Text('Henüz bir Haber yok.',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: width / 20,
                      ),
                  textAlign: TextAlign.center))
          : ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: widget.news.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(() => SingleNews());
                  },
                  child: Padding(
                    padding: EdgeInsets.all(width / 30),
                    child: Stack(
                      children: [
                        Container(
                          width: width,
                          height: width / 2,
                          child: ExtendedImage.network(
                            'https://cdn-1.motorsport.com/images/amp/Yv8ZnvE0/s1200/valtteri-bottas-mercedes-w12-1.webp',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: Padding(
                            padding: EdgeInsets.all(width / 40),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  width / 80,
                                ),
                                color: Theme.of(context).primaryColorLight,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(width / 80),
                                child: Text('Haberi Oku',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                            color: Colors.white,
                                            fontSize: width / 30)),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: width,
                            height: height / 10,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.black54, Colors.black38]),
                            ),
                            child: Column(
                              children: [
                                newsHeader(width, context),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width / 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Mercedes',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontSize: width / 30)),
                                      Text('29/01/2021',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontSize: width / 30))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
    );
  }

  Container page4(double width, double height) {
    return Container(
      color: Colors.white,
      child: widget.events.length == 0
          ? Center(
              child: Text('Henüz bir Etkinlik yok.',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: width / 20,
                      ),
                  textAlign: TextAlign.center))
          : ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: widget.events.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(() => SingleNews());
                  },
                  child: Padding(
                    padding: EdgeInsets.all(width / 30),
                    child: Stack(
                      children: [
                        Container(
                          width: width,
                          height: width / 2,
                          child: ExtendedImage.network(
                            'https://cdn-1.motorsport.com/images/amp/Yv8ZnvE0/s1200/valtteri-bottas-mercedes-w12-1.webp',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: Padding(
                            padding: EdgeInsets.all(width / 40),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  width / 80,
                                ),
                                color: Theme.of(context).primaryColorLight,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(width / 80),
                                child: Text('Haberi Oku',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                            color: Colors.white,
                                            fontSize: width / 30)),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: width,
                            height: height / 10,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.black54, Colors.black38]),
                            ),
                            child: Column(
                              children: [
                                newsHeader(width, context),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width / 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Mercedes',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontSize: width / 30)),
                                      Text('29/01/2021',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontSize: width / 30))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
    );
  }

  Padding newsHeader(double width, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(width / 50),
      child: Text(
          'Mercedes, sıralama turları öncesinde aracın dengesini geliştirmeye çalışacak',
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(fontSize: width / 30, color: Colors.white)),
    );
  }

  Container page2(double width) {
    return Container(
      color: Colors.white,
      child: Center(
        child: widget.jobs.length == 0
            ? Center(
                child: Text('Henüz bir fırsat yok.',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: width / 20,
                        ),
                    textAlign: TextAlign.center))
            : ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: widget.jobs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => JobApplicationPage(job: widget.jobs[index]));
                    },
                    child: GFListTile(
                      avatar: GFAvatar(
                        shape: GFAvatarShape.standard,
                        backgroundImage: NetworkImage(widget.jobs[index].image),
                      ),
                      titleText: widget.jobs[index].jobTitle,
                      icon: Icon(FontAwesomeIcons.chevronRight),
                    ),
                  );
                }),
      ),
    );
  }

  Widget page1(double height, double width, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(height / 90),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: height / 60,
          ),
          categoryBox(width, context),
          SizedBox(
            height: height / 60,
          ),
          Flexible(
            child: PageView(
              controller: _pageController2,
              onPageChanged: (index2) {
                setState(() {
                  pageIndex = index2;
                });
              },
              children: [
                firstPage(width, context, height),
                secondPage(width, context),
                Container(
                    child: ListView.builder(
                        itemCount: widget.company.social.length,
                        itemBuilder: (context, index) {
                          return GFListTile(
                            onTap: () {
                              switch (
                                  widget.company.social[index].values.last) {
                                case 'Instagram':
                                  _launchURL(
                                      'https://www.instagram.com/${widget.company.social[index].values.first.toString().substring(1, widget.company.social[index].values.first.toString().length)}/');
                                  break;
                                case 'Twitter':
                                  _launchURL(
                                      'https://www.twitter.com/${widget.company.social[index].values.first.toString().substring(1, widget.company.social[index].values.first.toString().length)}');
                                  break;
                                case 'LinkedIn':
                                  _launchURL(
                                      'https://www.linkedin.com/company/${widget.company.social[index].values.first.toString().substring(1, widget.company.social[index].values.first.toString().length)}/');
                                  break;
                                case 'Website':
                                  _launchURL(
                                      'https://${widget.company.social[index].values.first.toString().substring(1, widget.company.social[index].values.first.toString().length)}');
                                  break;
                                default:
                              }
                            },
                            avatar: iconInfo(
                                widget.company.social[index].values.last,
                                width),
                            titleText:
                                widget.company.social[index].values.first,
                          );
                        }))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget iconInfo(String media, double width) {
    switch (media) {
      case 'Instagram':
        return Icon(
          FontAwesomeIcons.instagram,
          color: Theme.of(context).primaryColorDark,
          size: width / 10,
        );
      case 'Twitter':
        return Icon(
          FontAwesomeIcons.twitter,
          color: Colors.blueAccent,
          size: width / 10,
        );
      case 'LinkedIn':
        return Icon(
          FontAwesomeIcons.linkedin,
          color: Colors.blue,
          size: width / 10,
        );
      case 'İnternet Sitesi':
        return Icon(
          FontAwesomeIcons.globe,
          color: Colors.blue[800],
          size: width / 10,
        );
      default:
        return SizedBox();
    }
  }

  Container secondPage(double width, BuildContext context) {
    return Container(
      child: ListView(
          children: widget.company.gallery
              .map((e) => Padding(
                    padding: EdgeInsets.all(width / 90),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(width / 30),
                        child: ExtendedImage.network(
                          e,
                          initGestureConfigHandler: (state) {
                            return GestureConfig(
                              minScale: 0.9,
                              animationMinScale: 0.7,
                              maxScale: 3.0,
                              animationMaxScale: 3.5,
                              speed: 1.0,
                              inertialSpeed: 100.0,
                              initialScale: 1.0,
                              inPageView: true,
                              initialAlignment: InitialAlignment.center,
                            );
                          },
                        )),
                  ))
              .toList()),
    );
  }

  Container firstPage(double width, BuildContext context, double height) {
    return Container(
      child: ListView(
          padding: EdgeInsets.symmetric(horizontal: width / 20),
          children: [
            Text('Hakkında',
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: width / 20)),
            Text(widget.company.info,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: width / 25)),
            SizedBox(
              height: height / 20,
            ),
            Text('Ofis Hayatı',
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: width / 20)),
            Text(widget.company.about,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: width / 25)),
          ]),
    );
  }

  Material categoryBox(double width, BuildContext context) {
    return Material(
      elevation: 25,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(width / 30),
      shadowColor: Colors.white38,
      child: Container(
        width: width / 1.2,
        height: width / 8,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(width / 30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                child: Center(child: category(context, width, 'Açıklama', 0))),
            VerticalDivider(
              thickness: 1.1,
            ),
            Expanded(
                child: Center(child: category(context, width, 'Galeri', 1))),
            VerticalDivider(
              thickness: 1.1,
            ),
            Expanded(
                child:
                    Center(child: category(context, width, 'Sosyal Medya', 2))),
          ],
        ),
      ),
    );
  }

  Widget category(
      BuildContext context, double width, String category, int index) {
    return GestureDetector(
      onTap: () {
        _pageController2.animateToPage(
          index,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeIn,
        );
        setState(() {
          pageIndex = index;
        });
      },
      child: Text(
        category,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: width / 30,
            color: pageIndex == index
                ? Theme.of(context).primaryColor
                : Colors.black),
      ),
    );
  }

  Container categorPicker(double height, double width) {
    return Container(
      height: height / 20,
      width: width,
      child: Row(
        children: [
          categoryContainer(height, width, 'Genel', 0),
          categoryContainer(height, width, 'Fırsatlar', 1),
          categoryContainer(height, width, 'Haberler', 2),
          categoryContainer(height, width, 'Etkinlikler', 3),
        ],
      ),
    );
  }

  Widget categoryContainer(
      double height, double width, String text, int numberOfCategory) {
    return GestureDetector(
      onTap: () {
        print(numberOfCategory);
        _pageController.animateToPage(numberOfCategory,
            duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width / 100),
        child: Container(
          width: width / 4.5,
          height: height / 20,
          child: Center(
            child: Text(text,
                style: TextStyle(
                    color: categoryNum == numberOfCategory
                        ? Theme.of(context).primaryColor
                        : Colors.black),
                textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }

  GFListTile headerTile(BuildContext context) {
    return GFListTile(
      title: Text(
        widget.company.name,
        style: Theme.of(context)
            .textTheme
            .headline2!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      avatar: GFAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(widget.company.logo),
      ),
    );
  }

  Stack imageStack(double height, double width, BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height / 2.5,
          child: Hero(
            tag: widget.company.name + 'cover',
            child: ExtendedImage.network(
              widget.company.cover,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Material(
          elevation: 100,
          color: Colors.transparent,
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(width / 15),
              child: IconButton(
                  onPressed: () {
                    categoryNum = 0;
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    FontAwesomeIcons.arrowLeft,
                    color: Colors.white,
                    size: width / 15,
                  )),
            ),
          ),
        ),
      ],
    );
  }

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}
