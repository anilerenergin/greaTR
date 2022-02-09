import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:greatr/UI/Companies/job_application.dart';
import 'package:greatr/UI/Companies/single_company.dart';
import 'package:greatr/models/Company.dart';
import 'package:greatr/models/Job.dart';

class Companies extends StatefulWidget {
  Companies({required this.companies, required this.jobs});
  List<Company> companies;
  List<Job> jobs;
  @override
  State<Companies> createState() => _CompaniesState();
}

class _CompaniesState extends State<Companies> {
  PageController _pageController = PageController();

  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                child: Text('Şirketler',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: width / 20,
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
                  'İş İlanları',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: width / 20,
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
          children: [
            /*Padding(
              padding: EdgeInsets.all(width / 30),
              child: Container(
                child: Center(
                  child: Column(children: [
                    Image.asset('images/cs.png'),
                    Text(
                      'Şirketler Yakında greaTR ile Sizlerle!',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: width / 15),
                      textAlign: TextAlign.center,
                    )
                  ]),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(width / 30),
              child: Container(
                child: Center(
                  child: Column(children: [
                    Image.asset('images/cs.png'),
                    Text(
                      'İş İlanları Yakında greaTR ile Sizlerle!',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: width / 15),
                      textAlign: TextAlign.center,
                    )
                  ]),
                ),
              ),
            )*/
            ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: widget.companies.length,
                itemBuilder: (context, index) {
                  return headerTile(context, widget.companies[index]);
                }),
            ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: widget.jobs.length,
                itemBuilder: (context, index) {
                  return headerTileForJobOffer(widget.jobs[index]);
                })
          ],
        ),
      ),
    );
  }

  Widget headerTileForJobOffer(Job job) {
    return GestureDetector(
      onTap: () {
        Get.to(() => JobApplicationPage(job: job));
      },
      child: GFListTile(
        title: Text(
          'Sr. UI Designer',
          style: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        subTitle: Text(
          'Mercedes/Istanbul',
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Colors.grey.shade500, fontWeight: FontWeight.normal),
        ),
        icon: Icon(FontAwesomeIcons.chevronRight,
            color: Theme.of(context).primaryColor),
        avatar: GFAvatar(
          size: MediaQuery.of(context).size.width / 8,
          backgroundImage: NetworkImage(
              'https://www.deutschland.de/sites/default/files/styles/crop_page/public/media/image/work-and-travel-germany-jobs.jpg?h=55f18e7c&itok=i5d7MByo'),
        ),
      ),
    );
  }

  Widget headerTile(BuildContext context, Company company) {
    return GestureDetector(
      onTap: () {
        Get.to(SingleCompany(
          company: company,
          jobs: widget.jobs
              .where((element) => element.companyId == company.id)
              .toList(),
          events: [],
          news: [],
        ));
      },
      child: GFListTile(
        title: Text(
          company.name,
          style: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        icon: Icon(FontAwesomeIcons.chevronRight,
            color: Theme.of(context).primaryColor),
        avatar: GFAvatar(
          backgroundColor: Colors.white,
          size: MediaQuery.of(context).size.width / 8,
          backgroundImage: NetworkImage(company.logo),
        ),
      ),
    );
  }
}
