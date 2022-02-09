import 'package:date_format/date_format.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:greatr/UI/Companies/job_application.dart';
import 'package:greatr/UI/Home%20Sections/Home%20Widgets/avatar-method.dart';
import 'package:greatr/models/Event.dart';
import 'package:greatr/models/Job.dart';

import '../../../constants.dart';

class JobOfferBox extends StatelessWidget {
  const JobOfferBox(
      {Key? key,
      required this.height,
      required this.width,
      required this.index,
      required this.job,
      this.image})
      : super(key: key);
  final int index;
  final Job job;
  final String? image;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Get.to(() => JobApplicationPage(job: job));
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
                        job.jobTitle,
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(fontSize: 20 * height / 1000),
                      ),
                      Text(
                        formatDate(job.time.toDate(), [
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
                      job.jobDescription,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: width / 30),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: width / 40),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(width / 30),
                      child: ExtendedImage.network(job.image),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0 * height / 1000),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(job.companyName,
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(fontSize: width / 20)),
                        SizedBox(
                          width: width / 10,
                        ),
                        Container(child: Icon(FontAwesomeIcons.chevronRight)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
