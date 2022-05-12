import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';
import 'package:greatr/Firebase%20Functions/auth-functions.dart';
import 'package:greatr/Firebase%20Functions/bookmarks.dart';
import 'package:greatr/Firebase%20Functions/chat_functions.dart';
import 'package:greatr/Firebase%20Functions/event_functions.dart';
import 'package:greatr/Firebase%20Functions/feed_functions.dart';
import 'package:greatr/Firebase%20Functions/job_offer_functions.dart';
import 'package:greatr/Firebase%20Functions/user_functions.dart';
import 'package:greatr/UI/NewRegister/new_register.dart';
import 'package:greatr/UI/home.dart';
import 'package:greatr/models/ChatRoom.dart';
import 'package:greatr/models/Company.dart';
import 'package:greatr/models/Event.dart';
import 'package:greatr/models/Job.dart';
import 'package:greatr/models/User.dart';
import 'package:greatr/models/UserBookmarks.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';
import '../../models/post_model.dart';
import '../globals.dart' as global;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

final translator = GoogleTranslator();

// VARIABLES
List<ChatRoom> rooms = [];
List<Event> events = [];
List<UserModel> users = [];
List<UserModel> allUsers = [];
List<UserBookmark> bookmarks = [];
List<Company> companies = [];
List<Job> jobs = [];
List<PostModel> posts = [];

//VARIABLES
class _LoginPageState extends State<LoginPage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  bool newRegister = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterLogin(
          messages: LoginMessages(
              userHint: "E-mail",
              loginButton: 'Giriş',
              signupButton: 'Kayıt Ol',
              forgotPasswordButton: 'Şifremi Unuttum',
              passwordHint: 'Şifre',
              confirmPasswordHint: 'Şifreyi Onayla',
              recoverPasswordButton: 'Kurtar',
              recoverPasswordDescription: 'Şifreni Buradan Sıfırla',
              goBackButton: 'Geri Dön',
              recoverPasswordIntro: ''),
          onSubmitAnimationCompleted: () {
            if (newRegister) {
              Get.off(() => NewRegister(
                    rooms: rooms,
                  ));
            } else {
              Get.off(() => HomePage(
                    notificationReceived: false,
                    jobs: jobs,
                    companies: companies,
                    events: events,
                    allUsers: allUsers,
                    user: users.first,
                    rooms: rooms,
                    posts: posts,
                    pageIndex: 0,
                  ));
            }
          },
          theme: LoginTheme(
              titleStyle: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: Theme.of(context).primaryColor),
              buttonTheme: LoginButtonTheme(),
              pageColorLight: Theme.of(context).primaryColor,
              pageColorDark: Theme.of(context).primaryColor,
              cardTheme: CardTheme(
                color: Theme.of(context).backgroundColor,
              ),
              switchAuthTextColor: Theme.of(context).primaryColor,
              inputTheme: InputDecorationTheme(
                  fillColor: Colors.white, focusColor: Colors.white)),
          logo: 'images/logo.png',
          logoTag: 'Greatr',
          title: 'sdasa',
          onSignup: registerUser,
          onLogin: loginUser,
          onRecoverPassword: (password) {
            changePassword(password, password);
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 7,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: CarouselSlider(
                      items: [
                        Image.asset(
                          'images/swipe.png',
                          width: MediaQuery.of(context).size.width / 2,
                        ),
                        Image.asset(
                          'images/ipa.jpg',
                          width: MediaQuery.of(context).size.width / 2,
                        ),
                        Image.asset(
                          'images/ist.png',
                          width: MediaQuery.of(context).size.width / 4,
                        ),
                        Image.asset(
                          'images/kolektif.png',
                          width: MediaQuery.of(context).size.width / 2,
                        ),
                        Image.asset(
                          'images/Loreal_logo.png',
                          width: MediaQuery.of(context).size.width / 2,
                        ),
                        Image.asset('images/makromusıc.png'),
                        Image.asset(
                          'images/sabancı.png',
                          width: MediaQuery.of(context).size.width / 2,
                        ),
                        Image.asset(
                          'images/sertf.png',
                          width: MediaQuery.of(context).size.width / 2,
                        ),
                        Image.asset(
                          'images/swipe.png',
                          width: MediaQuery.of(context).size.width / 2,
                        ),
                        Image.asset(
                          'images/workup.png',
                          width: MediaQuery.of(context).size.width / 3,
                        ),
                        Image.asset(
                          'images/suzer.png',
                          width: MediaQuery.of(context).size.width / 3,
                        ),
                        Image.asset(
                          'images/cineshort.png',
                          width: MediaQuery.of(context).size.width / 3,
                        ),
                        Image.asset(
                          'images/karavan.png',
                          width: MediaQuery.of(context).size.width / 3,
                        ),
                        Image.asset(
                          'images/bulbeez.png',
                          width: MediaQuery.of(context).size.width / 3,
                        ),
                        Image.asset(
                          'images/producter.png',
                          width: MediaQuery.of(context).size.width / 8,
                        ),
                        ColorFiltered(
                          colorFilter:
                              ColorFilter.mode(Colors.black, BlendMode.srcATop),
                          child: Image.asset(
                            "images/evimdekipsikolog.png",
                            width: MediaQuery.of(context).size.width / 3,
                          ),
                        )
                      ],
                      options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 0.5,
                          autoPlayInterval: Duration(seconds: 1),
                          autoPlayCurve: Curves.easeOut,
                          enlargeCenterPage: true)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<String?> registerUser(LoginData data) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: data.name, password: data.password);
      setState(() {
        newRegister = true;
      });
      var prefs = await SharedPreferences.getInstance();
      prefs.setString('uid', FirebaseAuth.instance.currentUser!.uid);
      return null;
    } on FirebaseAuthException catch (e) {
      var translation = await translator.translate(e.code, to: 'tr');
      return translation.toString();
    } catch (e) {
      var translation = await translator.translate(e.toString(), to: 'tr');
      return translation.toString();
    }
  }

  Future<String?> loginUser(LoginData data) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: data.name, password: data.password);
      Future.wait([
        getChatRooms(rooms),
        getAllEvents(events),
        getUserFromFirestore(auth.currentUser!.uid, users),
        getFeedObjects(),
        getCompanies(companies),
        getJobOffers(jobs)
      ])
          .then((value) => getBookmarks(users.first.id, bookmarks))
          .then((value) => global.bookmarks = bookmarks.first);
      
      OneSignal.shared
          .setExternalUserId(FirebaseAuth.instance.currentUser!.uid);

      var prefs = await SharedPreferences.getInstance();
      prefs.setString('uid', FirebaseAuth.instance.currentUser!.uid);
      prefs.setString('onesignal', FirebaseAuth.instance.currentUser!.uid);
      return null;
    } on FirebaseAuthException catch (e) {
      var translation = await translator.translate(e.code, to: 'tr');
      return translation.toString();
    } catch (e) {
      var translation = await translator.translate(e.toString(), to: 'tr');
      return translation.toString();
    }
  }
}
