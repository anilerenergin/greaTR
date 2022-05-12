import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/post_model.dart';

final postRef = FirebaseFirestore.instance.collection('posts');

Future getAllPosts(List<PostModel> allPosts) async {
  try {
    var postData = await postRef.get();
    postData.docs.forEach((element) {
      allPosts.add(PostModel.fromJson(element.data()));
    });
    allPosts.sort((a, b) => a.timeStamp!.compareTo(b.timeStamp!));
    return allPosts;
  } catch (e) {
    print(e);
  }
}

Future likePost(String postId) async {
  int likeCount = 0;
  await postRef.doc(postId).get().then((snapshot) {
    likeCount = snapshot.data()!['likeCount'];
    return likeCount;
  }).then((value) => postRef.doc(postId).update({'likeCount': likeCount + 1}));
}

Future unLikePost(String postId) async {
  int likeCount = 0;
  await postRef.doc(postId).get().then((snapshot) {
    likeCount = snapshot.data()!['likeCount'];
    return likeCount;
  }).then((value) => postRef.doc(postId).update({'likeCount': likeCount - 1}));
}
