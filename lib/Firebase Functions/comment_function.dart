import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/comment_model.dart';
import '../models/post_model.dart';

Future getPostComments(List<CommentModel> allComments, String postId) async {
  final commentRef = FirebaseFirestore.instance.collection('comments');

  var commentData = await commentRef.doc(postId).get();
  commentData.data()!.values.forEach((element) {
    allComments.add(CommentModel.fromJson(element));
  });
  allComments.sort(
    (a, b) => a.timeStamp!.compareTo(b.timeStamp!));

  return allComments;
  
}

Future addPostComment(String postId, String comment, String composer,DateTime timeStamp) async {
  final commentRef = FirebaseFirestore.instance.collection('comments');

  var commentDataSecond = await commentRef.doc(postId).get();
  var commentDataLength = commentDataSecond.data()!.length;
  var commentData = await commentRef.doc(postId).set({
    (commentDataLength + 1).toString(): {
      'composer': composer,
      'comment': comment,
      'timeStamp': timeStamp,
    },
  }, SetOptions(merge: true));
  return;
}
