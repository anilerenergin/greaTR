import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:greatr/Firebase%20Functions/user_functions.dart';

Future pickFile(String userId, String username) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  File file = File(result!.files.single.path!);
  uploadCV(file.path, username, userId);
}

Future<void> uploadCV(String filePath, String username, String id) async {
  File file = File(filePath);

  try {
    var uploadTask = await firebase_storage.FirebaseStorage.instance
        .ref('user-cvs/$username.pdf')
        .putFile(file);

    String cvUrl = await uploadTask.ref.getDownloadURL();

    await updateUserCV(cvUrl, id);
    return;
  } catch (e) {
    throw (e);
  }
}
