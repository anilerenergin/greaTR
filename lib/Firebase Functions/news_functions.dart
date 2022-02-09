import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greatr/models/News.dart';

final newsRef =
    FirebaseFirestore.instance.collection('news').withConverter<News>(
          fromFirestore: (snapshot, _) => News.fromMap(snapshot.data()!),
          toFirestore: (userModel, _) => userModel.toMap(),
        );
