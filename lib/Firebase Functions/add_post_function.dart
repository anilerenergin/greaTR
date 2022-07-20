import 'package:cloud_firestore/cloud_firestore.dart';

addNewPost(String name, String composerId, String location, String comment,
    String profileImg, String postImg, DateTime timeStamp) async {
  final postRef = FirebaseFirestore.instance.collection('posts');
  var postData = await postRef.add({
    'postId': "",
    'composerId': composerId,
    'composer': name,
    'postText': comment.trim(),
    'location': location,
    'profileImg': profileImg,
    'postImg': postImg,
    'likedUsers': [],
    'commentList': "",
    'timeStamp': timeStamp,
  }).then((value) {
    postRef.doc(value.id).update({'postId': value.id, 'commentList': value.id});
    FirebaseFirestore.instance.collection('comments').doc(value.id).set({});
  });
  return;
}
