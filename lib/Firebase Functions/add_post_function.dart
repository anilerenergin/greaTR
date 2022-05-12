import 'package:cloud_firestore/cloud_firestore.dart';

addNewPost(String name, String location, String comment, String profileImg,
    String postImg, DateTime timeStamp) async {
  final postRef = FirebaseFirestore.instance.collection('posts');
  var postData = await postRef.add({
    'postId': "",
    'composer': name,
    'postText': comment,
    'location': location,
    'profileImg': profileImg,
    'postImg': postImg,
    'likeCount': 0,
    'commentList': "",
    'timeStamp': timeStamp,
  }).then((value) {
    postRef.doc(value.id).update({'postId': value.id, 'commentList': value.id});
    FirebaseFirestore.instance.collection('comments').doc(value.id).set({});
  });
  return;
}
