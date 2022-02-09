import 'dart:io';

import 'package:greatr/Firebase%20Functions/user_functions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

firebase_storage.FirebaseStorage storage =
    firebase_storage.FirebaseStorage.instance;

Future getImageFromGallery(String username, String id) async {
  ImagePicker _picker = ImagePicker();
  XFile? image =
      await _picker.pickImage(source: ImageSource.gallery, imageQuality: 25);
  String imageUrl = await uploadProfileImage(image!.path, username, id);
  return imageUrl;
}

Future getImageFromCamera(String username, String id) async {
  ImagePicker _picker = ImagePicker();
  XFile? image =
      await _picker.pickImage(source: ImageSource.camera, imageQuality: 25);
  String imageUrl = await uploadProfileImage(image!.path, username, id);
  return imageUrl;
}

Future<String> uploadProfileImage(
    String filePath, String username, String id) async {
  File file = File(filePath);

  try {
    var uploadTask = await firebase_storage.FirebaseStorage.instance
        .ref('profile-pics/$username.png')
        .putFile(file);

    String imageUrl = await uploadTask.ref.getDownloadURL();
    print(imageUrl);
    await updateUserProfileImage(imageUrl, id);
    return imageUrl;
  } catch (e) {
    throw (e);
  }
}
