import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greatr/UI/globals.dart';

import '../models/post_model.dart';

final postRef = FirebaseFirestore.instance.collection('posts');
final userRef = FirebaseFirestore.instance.collection('users');

Future getAllPosts(List<PostModel> allPosts) async {
  try {
    allPosts = [];
    var postData = await postRef.get();
    postData.docs.forEach((element) {
      allPosts.add(PostModel.fromJson(element.data()));
    });
    allPosts.sort((a, b) => a.timeStamp!.compareTo(b.timeStamp!));
    allPosts = allPosts.reversed.toList();
    return allPosts;
  } catch (e) {
    print(e);
  }
}

Future likePost(String postId, String userId) async {
  await userRef.doc(userId).update({
    'likedPosts': FieldValue.arrayUnion([postId]),
  }).then((value) => postRef.doc(postId).update({
        'likedUsers': FieldValue.arrayUnion([userId])
      }));
}

Future unLikePost(String postId, String userId) async {
  await userRef.doc(userId).update({
    'likedPosts': FieldValue.arrayRemove([postId]),
  }).then((value) => postRef.doc(postId).update({
        'likedUsers': FieldValue.arrayRemove([userId])
      }));
}
