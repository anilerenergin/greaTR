import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;

Future<String?> sendPasswordResetEmail(String email) async {
  await auth.sendPasswordResetEmail(email: email);
}

Future<String?> verifyPasswordResetCode(String code) async {
  await auth.verifyPasswordResetCode(code);
}

Future<String?> changePassword(String password, String checkPassword) async {
  auth.currentUser!.updatePassword(password);
}

listenChanges() {
  auth.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
}
