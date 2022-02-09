import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:greatr/Firebase%20Functions/bookmarks.dart';
import 'package:greatr/models/Job.dart';
import 'package:like_button/like_button.dart';
import '../globals.dart' as global;

class JobApplicationPage extends StatefulWidget {
  JobApplicationPage({required this.job});
  Job job;
  @override
  State<JobApplicationPage> createState() => _JobApplicationPageState();
}

bool isliked = false;

class _JobApplicationPageState extends State<JobApplicationPage> {
  int pageIndex = 0;
  PageController _pageController = PageController();
  @override
  void initState() {
    global.bookmarks.bookmarks.forEach((element) {
      if (element.bookMarkId == widget.job.id) {
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
      bottomNavigationBar: bottomNav(height, width, context),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            brandContainer(height, width, context),
            SizedBox(
              height: height / 60,
            ),
            infoBox(context, width, height),
            SizedBox(
              height: height / 60,
            ),
            categoryBox(width, context),
            SizedBox(
              height: height / 60,
            ),
            Flexible(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    pageIndex = index;
                  });
                },
                children: [
                  firstPage(width, context, height),
                  secondPage(width, context),
                  Container(
                    color: Colors.green,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container secondPage(double width, BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: width / 20),
        children: [
          Text(
            'Analyze and meet product specifications and user expectations',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: width / 30),
          ),
          Divider(color: Theme.of(context).primaryColor),
          Text(
            'Perform concept and usability testing and gather feedback',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: width / 30),
          ),
          Divider(color: Theme.of(context).primaryColor),
          Text(
            'Use special personas based on user research results',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: width / 30),
          ),
          Divider(color: Theme.of(context).primaryColor),
          Text(
            'Create right interaction models and evaluate their success',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: width / 30),
          ),
          Divider(color: Theme.of(context).primaryColor),
          Text(
            'Build wireframes and prototypes around customer needs',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: width / 30),
          ),
          Divider(color: Theme.of(context).primaryColor),
          Text(
            'Analyze and meet product specifications and user expectations',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: width / 30),
          ),
          Divider(color: Theme.of(context).primaryColor),
          Text(
            'Perform concept and usability testing and gather feedback',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: width / 30),
          ),
          Divider(color: Theme.of(context).primaryColor),
          Text(
            'Use special personas based on user research results',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: width / 30),
          ),
          Divider(color: Theme.of(context).primaryColor),
          Text(
            'Create right interaction models and evaluate their success',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: width / 30),
          ),
          Divider(color: Theme.of(context).primaryColor),
          Text(
            'Build wireframes and prototypes around customer needs',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: width / 30),
          ),
        ],
      ),
    );
  }

  Container firstPage(double width, BuildContext context, double height) {
    return Container(
      child: ListView(
          padding: EdgeInsets.symmetric(horizontal: width / 20),
          children: [
            Text(
                'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: width / 30)),
            SizedBox(
              height: height / 60,
            ),
            Text(
                'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: width / 30)),
            SizedBox(
              height: height / 60,
            ),
            Text(
                'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: width / 30))
          ]),
    );
  }

  Material categoryBox(double width, BuildContext context) {
    return Material(
      elevation: 15,
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
              thickness: 1.2,
            ),
            Expanded(
                child: Center(
                    child: category(context, width, 'Gereksinimler', 1))),
          ],
        ),
      ),
    );
  }

  Container bottomNav(double height, double width, BuildContext context) {
    return Container(
      height: height / 10,
      color: Colors.white,
      width: width,
      child: Padding(
        padding: EdgeInsets.all(width / 30),
        child: Row(
          children: [
            Expanded(
                flex: 20,
                child: Container(
                  height: height / 15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width / 30),
                      color: Theme.of(context).primaryColor),
                  child: Center(
                    child: Text('Şimdi Başvur',
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            color: Colors.white, fontSize: width / 25)),
                  ),
                )),
            Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Expanded(
              flex: 4,
              child: Container(
                height: height / 15,
                child: Center(
                  child: LikeButton(
                    isLiked: isliked,
                    onTap: (isLiked) async {
                      if (isLiked) {
                        Get.snackbar(widget.job.jobTitle,
                            'İş Başvurusu Kaydettiklerinizden Silindi',
                            borderColor: Colors.red,
                            borderWidth: 2,
                            snackPosition: SnackPosition.TOP);
                        global.bookmarkedObjects.removeWhere(
                            (element) => element.id == widget.job.id);
                        removeBookmark(global.user.id, widget.job.id);
                      } else {
                        Get.snackbar(widget.job.jobTitle,
                            'İş Başvurusu Kaydettiklerinize Eklendi',
                            borderColor: Colors.green,
                            borderWidth: 2,
                            snackPosition: SnackPosition.TOP);
                        bookmarkJob(global.user.id, widget.job.id);
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

  Widget category(
      BuildContext context, double width, String category, int index) {
    return GestureDetector(
      onTap: () {
        _pageController.animateToPage(
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
            fontSize: width / 25,
            color: pageIndex == index
                ? Theme.of(context).primaryColor
                : Colors.black),
      ),
    );
  }

  Center infoBox(BuildContext context, double width, double height) {
    return Center(
      child: Column(
        children: [
          Text('Sr. UI Designer',
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: width / 18)),
          SizedBox(
            height: height / 120,
          ),
          Text('Mercedes, İstanbul',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: width / 30, color: Colors.grey.shade600)),
          SizedBox(
            height: height / 120,
          ),
          Text('Staj/Maaşlı',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontSize: width / 30, color: Colors.grey.shade600)),
        ],
      ),
    );
  }

  Container brandContainer(double height, double width, BuildContext context) {
    return Container(
      height: height / 3.3,
      width: width,
      child: brandStack(width, context),
    );
  }

  Stack brandStack(double width, BuildContext context) {
    return Stack(
      children: [
        ExtendedImage.network(
            'https://www.deutschland.de/sites/default/files/styles/crop_page/public/media/image/work-and-travel-germany-jobs.jpg?h=55f18e7c&itok=i5d7MByo'),
        Align(
          alignment: Alignment.bottomCenter,
          child: Material(
              elevation: 20,
              color: Colors.transparent,
              shadowColor: Colors.grey.shade100,
              child: Container(
                width: width / 5,
                height: width / 5,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(width / 40)),
                child: Padding(
                  padding: EdgeInsets.all(width / 30),
                  child: Center(child: Image.asset('images/sampleLogo.png')),
                ),
              )),
        ),
        Positioned(
            left: width / 20,
            top: width / 20,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              icon: Icon(
                FontAwesomeIcons.arrowLeft,
                color: Colors.white,
              ),
            ))
      ],
    );
  }
}
