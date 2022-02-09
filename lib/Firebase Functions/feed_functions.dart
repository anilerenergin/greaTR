import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greatr/Firebase%20Functions/event_functions.dart';
import 'package:greatr/Firebase%20Functions/job_offers.dart';
import 'package:greatr/Firebase%20Functions/news_functions.dart';
import 'package:greatr/models/Event.dart';
import 'package:greatr/models/Feed.dart';
import 'package:greatr/models/Job.dart';
import 'package:greatr/models/News.dart';
import '/UI/globals.dart' as global;

final feedRef =
    FirebaseFirestore.instance.collection('feed').withConverter<Feed>(
          fromFirestore: (snapshot, _) => Feed.fromMap(snapshot.data()!),
          toFirestore: (userModel, _) => userModel.toMap(),
        );

//INSALLAH CALISIR
Future getFeedObjects() async {
  var response;

  response = await feedRef
      .orderBy(
        'feedObjectDate',
      )
      .get();

  await response.docs.forEach((element) async {
    switch (element['feedObjectType']) {
      case 'events':
        var eventResponse = await eventRef.doc(element['feedObjectId']).get();
        Event event = Event.fromMap(eventResponse.data()!.toMap());

        global.feedObjects.add(event);

        break;
      case 'job_offers':
        var jobOfferResponse =
            await jobOfferRef.doc(element['feedObjectId']).get();
        Job job = Job.fromMap(jobOfferResponse.data()!.toMap());

        global.feedObjects.add(job);

        break;
      case 'news':
        var newsResponse = await newsRef.doc(element['feedObjectId']).get();
        News news = News.fromMap(newsResponse.data()!.toMap());

        global.feedObjects.add(news);

        break;
      default:
    }
  });
}
//INSALLAH CALISIR
