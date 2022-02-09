import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greatr/models/User.dart';
import '/UI/globals.dart' as global;

final userRef =
    FirebaseFirestore.instance.collection('users').withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromMap(snapshot.data()!),
          toFirestore: (userModel, _) => userModel.toMap(),
        );

Future addUserToFirestore(UserModel user) async {
  await userRef.doc(user.id).set(user);
}

Future getUserFromFirestore(String uid, List<UserModel> users) async {
  try {
    var userData = await userRef.doc(uid).get();

    users.add(UserModel.fromMap(userData.data()!.toMap()));
  } catch (e) {
    print(e);
  }
}

Future getSingleUser(String userId) async {
  var response = await userRef.doc(userId).get();
  UserModel user = UserModel.fromMap(response.data()!.toMap());
  return user;
}

Future updateUserProfileImage(String dowlandUrl, String id) async {
  await userRef.doc(id).update({'imageUrl': dowlandUrl});
  return dowlandUrl;
}

Future updateUserCV(String dowlandUrl, String id) async {
  await userRef.doc(id).update({'cvUrl': dowlandUrl});
  return dowlandUrl;
}

Future updateBio(String id, String bio) async {
  global.user.userBio = bio;
  await userRef.doc(id).update({'userBio': bio});
  return;
}
