import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:greatr/UI/Event%20Section/single_event.dart';
import 'package:greatr/models/Event.dart';

class Events extends StatefulWidget {
  Events({required this.events});
  List<Event> events;
  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  PageController _pageController = PageController();
  int pageIndex = 0;
  List<Event> pastEvents = [];
  List<Event> upcomingEvents = [];
  @override
  void initState() {
    pastEvents = [];
    upcomingEvents = [];
    widget.events.forEach((element) {
      if (element.time.toDate().isBefore(DateTime.now())) {
        pastEvents.add(element);
      } else {
        upcomingEvents.add(element);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  _pageController.animateToPage(0,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                },
                child: Text('Gelecek Etkinlikler',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: width / 22,
                        color: pageIndex == 0
                            ? Colors.black
                            : Colors.grey.shade500),
                    textAlign: TextAlign.center),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  _pageController.animateToPage(1,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                },
                child: Text(
                  'Geçmiş Etkinlikler',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: width / 22,
                      color:
                          pageIndex == 1 ? Colors.black : Colors.grey.shade500),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: PageView(
          onPageChanged: (index) {
            setState(() {
              pageIndex = index;
            });
          },
          controller: _pageController,
          children: [page1(upcomingEvents), page1(pastEvents)],
        ),
      ),
    );
  }

  Widget page1(List<Event> eventList) {
    double width=MediaQuery.of(context).size.width;
    if (eventList.length == 0) {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 30),
        child: Center(
          child: Text(
            'Henüz Planlanmış Bir Etkinlik Yok',
            style: Theme.of(context).textTheme.headline1!.copyWith(
                fontSize: MediaQuery.of(context).size.width / 15,
                color: Theme.of(context).primaryColor),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: StaggeredGridView.countBuilder(
        padding: EdgeInsets.zero,
          crossAxisCount:(width ~/ 90).toInt(),
        itemCount: eventList.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () {
            Get.to(() => SingleEvent(event: widget.events[index]));
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: ExtendedImage.network(
              eventList[index].images.first,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        staggeredTileBuilder: (int index) =>
            new StaggeredTile.count(2, index.isEven ? 3 : 2),
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
    );
  }
}
