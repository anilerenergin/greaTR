import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greatr/models/Company.dart';
import 'package:greatr/models/Job.dart';

import '/UI/globals.dart' as global;

final companyRef =
    FirebaseFirestore.instance.collection('companies').withConverter<Company>(
          fromFirestore: (snapshot, _) => Company.fromMap(snapshot.data()!),
          toFirestore: (userModel, _) => userModel.toMap(),
        );

final jobOfferRef =
    FirebaseFirestore.instance.collection('job_offers').withConverter<Job>(
          fromFirestore: (snapshot, _) => Job.fromMap(snapshot.data()!),
          toFirestore: (userModel, _) => userModel.toMap(),
        );

Future getCompanies(List<Company> companyList) async {
  var response = await companyRef.get();
  response.docs.forEach((element) {
    companyList.add(Company.fromMap(element.data().toMap()));
  });

  return;
}

Future getJobOffers(List<Job> jobList) async {
  var response = await jobOfferRef
      .orderBy(
        'initDate',
      )
      .get();
  response.docs.forEach((element) {
    jobList.add(Job.fromMap(element.data().toMap()));
  });

  return;
}
