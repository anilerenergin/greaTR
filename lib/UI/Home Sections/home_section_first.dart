import 'package:flutter/material.dart';
import 'package:greatr/UI/Home%20Sections/PageViewSections/section1.dart';

import 'package:greatr/constants.dart';
import 'package:line_icons/line_icons.dart';

class HomeSection1 extends StatefulWidget {
  const HomeSection1({Key? key}) : super(key: key);

  @override
  _HomeSection1State createState() => _HomeSection1State();
}

class _HomeSection1State extends State<HomeSection1> {
  PageController _pageController = PageController();

  int chipIndex = 0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: buildBody(height, context, width),
    );
  }

  Container buildBody(double height, BuildContext context, double width) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(
          right: 20.0 * height / 600,
          left: 20.0 * height / 600,
          top: 30.0 * height / 600,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            bodyHeader(context, height, width),
            SizedBox(
              height: height / 35,
            ),
            HomeSection1PageViewSection1()
          ],
        ),
      ),
    );
  }

  Row bodyHeader(BuildContext context, double height, double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hoşgeldin', style: Theme.of(context).textTheme.headline1!),
            Text("greaTR'da senin için ne var?",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w400,
                    fontSize: 22 * height / 1000)),
          ],
        ),
        Hero(
          tag: 'Greatr',
          child: Image.asset(
            'images/logo.png',
            color: Theme.of(context).primaryColor,
            scale: 15,
          ),
        )
      ],
    );
  }

  Container icons(double height, double width) {
    return Container(
      height: height / 20,
      width: width,
      child: Row(
        children: [
          Icon(
            LineIcons.bell,
            size: width / 12,
          ),
          SizedBox(
            width: width / 20,
          ),
          Icon(
            LineIcons.comments,
            size: width / 12,
          )
        ],
      ),
    );
  }
}
