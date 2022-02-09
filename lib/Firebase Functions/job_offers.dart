import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greatr/models/Job.dart';

final jobOfferRef =
    FirebaseFirestore.instance.collection('job_offers').withConverter<Job>(
          fromFirestore: (snapshot, _) => Job.fromMap(snapshot.data()!),
          toFirestore: (userModel, _) => userModel.toMap(),
        );
