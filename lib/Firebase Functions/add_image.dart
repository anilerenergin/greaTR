import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

Future imgFromGallery(photo) async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    photo = File(pickedFile.path);

    return photo;
  } else {
    print('No image sele+cted.');
  }
}

Future uploadFile(_photo) async {
  if(_photo!=null){
    try {
  final fileName = basename(_photo!.path);
  final destination = 'postImgs/$fileName';
    final ref = FirebaseStorage.instance.ref(destination);
    await ref.putFile(_photo!);
    return ref;
  } catch (e) {
    print('error occured');
  }
  }
  else{
    return;
  }
}

Future loadImage(pathname) async {
  String imageUrl = await pathname.getDownloadURL();
  return imageUrl;
}
