import 'package:flutter/material.dart';
import 'package:greatr/UI/Home%20Sections/Home%20Widgets/event-offer-box.dart';
import 'package:greatr/UI/Home%20Sections/Home%20Widgets/job_offer_box.dart';
import 'package:greatr/UI/Home%20Sections/Home%20Widgets/news_box.dart';
import 'package:greatr/models/Event.dart';
import 'package:greatr/models/Job.dart';
import '../../globals.dart' as global;

class HomeSection1PageViewSection1 extends StatefulWidget {
  const HomeSection1PageViewSection1({Key? key}) : super(key: key);

  @override
  State<HomeSection1PageViewSection1> createState() =>
      _HomeSection1PageViewSection1State();
}

class _HomeSection1PageViewSection1State
    extends State<HomeSection1PageViewSection1> {
  @override
  void initState() {
    global.feedObjects
        .sort((a, b) => b.time.toDate().compareTo(a.time.toDate()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Flexible(
      child: ListView.builder(
          itemCount: global.feedObjects.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            if (global.feedObjects[index] is Event) {
              return EventOrJobOfferBox(
                height: height,
                width: width,
                index: index,
                event: global.feedObjects[index],
              );
            } else if (global.feedObjects[index] is Job) {
              return JobOfferBox(
                height: height,
                width: width,
                index: index,
                job: global.feedObjects[index],
              );
            } else {
              return NewsBox(
                news: global.feedObjects[index],
                height: height,
                width: width,
                index: index,
              );
            }
          }),
    );
  }
}
