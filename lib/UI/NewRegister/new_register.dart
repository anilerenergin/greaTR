import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:greatr/Firebase%20Functions/bookmarks.dart';
import 'package:greatr/Firebase%20Functions/event_functions.dart';
import 'package:greatr/Firebase%20Functions/feed_functions.dart';
import 'package:greatr/Firebase%20Functions/job_offer_functions.dart';
import 'package:greatr/Firebase%20Functions/post_function.dart';
import 'package:greatr/UI/Login/login-signin.dart';
import 'package:greatr/UI/NewRegister/pdf_api.dart';
import 'package:greatr/UI/NewRegister/pdf_view_page.dart';
import 'package:greatr/UI/NewRegister/pdf_view_page.dart';
import 'package:greatr/models/Company.dart';
import 'package:greatr/models/Job.dart';
import 'package:greatr/models/UserBookmarks.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:slugify/slugify.dart';
import 'package:greatr/Firebase%20Functions/user_functions.dart';
import 'package:greatr/UI/home.dart';
import 'package:greatr/models/ChatRoom.dart';
import 'package:greatr/models/Education.dart';
import 'package:greatr/models/Location.dart';
import 'package:greatr/models/User.dart';
import '../../models/post_model.dart';
import '../globals.dart' as global;
import '/../constants.dart' as constant;

class NewRegister extends StatefulWidget {
  List<ChatRoom> rooms;
  NewRegister({
    Key? key,
    required this.rooms,
  }) : super(key: key);

  @override
  _NewRegisterState createState() => _NewRegisterState();
}

UserModel? user;
DateTime currentYear = DateTime(DateTime.now().year);
List<PostModel> posts = [];
String name = '';
List<Company> companies = [];
List<Job> jobs = [];
String firstGraduateYear = "Tahmini Mezuniyet Yılınızı Yazınız";
String secondGraduateYear = "Tahmini Mezuniyet Yılınızı Yazınız";
List<String> graduateYears = [
  "Tahmini Mezuniyet Yılınızı Yazınız",
  "2022",
  "2023",
  "2024",
  "2025",
  "2026",
  "2027",
  "2028",
  "2029",
  "2030",
];
String phone = '';
String gender = 'Cinsiyet Seçiniz';
String major = "";
String multipleMajor = "";
String reference = "";
Education education = Education(
    year: 0,
    university: '',
    field: '',
    secondYear: 0,
    secondUniversity: "",
    secondField: "");
List<String> genders = [
  'Cinsiyet Seçiniz',
  'Erkek',
  'Kadın',
  'Belirtmek İstemiyorum'
];
Location location = Location(country: '', city: '');
double sliderValue = 0;
double secondSliderValue = 0;
List classes = [
  'Hazırlık',
  '1.Sınıf',
  '2.Sınıf',
  '3.Sınıf',
  '4.Sınıf',
  '5.Sınıf',
  '6.Sınıf',
  '7.Sınıf',
  'Mezun'
];
List<dynamic> referenceList = [
  "greaTR ülke koordinatörü/temsilcisi",
  "greaTR Üyesi",
  "LinkedIn",
  "Instagram",
  "Twitter",
  "Facebook",
  "Diğer"
];
bool isCustomCountry = false;
bool isCustomUniversity = false;
bool isCustomSecondUniversity = false;
bool isCustomCity = false;
bool kvkkApproved = false;
bool isCustomReference = false;
bool referenceFields = false;
bool otherReference = false;
bool comingBackToTurkey = false;


class _NewRegisterState extends State<NewRegister> {
  PanelController _panelController = PanelController();

  bool isChecked = false;
  bool isMultipleMajor = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          children: [
            Text('Hoşgeldin!',
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: Colors.black, fontSize: width / 15)),
            Text('Kaydını hemen tamamla ve aramıza katıl!',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: width / 30, color: Colors.grey.shade600)),
          ],
        ),
      ),
      body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(width / 30),
              child: Column(
                   
                children: [
                  SizedBox(
                    height: height / 30,
                  ),
                  referenceBox(context, height, width),
                  SizedBox(
                    height: height / 30,
                  ),
                  nameBox(context),
                  SizedBox(
                    height: height / 30,
                  ),
                  phoneBox(context),
                  SizedBox(
                    height: height / 120,
                  ),
                  //whatsapp
                  Text(
                    "*Lütfen Whatsapp kullandığınız telefon numarasını yazınız",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: width / 30,
                        color: Theme.of(context).primaryColor),
                  ),
                  SizedBox(
                    height: height / 30,
                  ),
                  genderPicker(context, height, width),
                  SizedBox(
                    height: height / 30,
                  ),
                  Text('Konum',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: width / 15)),
                  SizedBox(
                    height: height / 30,
                  ),
                  isCustomCountry
                      ? Stack(
                          children: [
                            TextField(
                              onChanged: (value) {
                                setState(() {
                                  location.country = value.toString();
                                });
                              },
                              decoration: InputDecoration(
                                hintStyle: Theme.of(context).textTheme.bodyText1,
                                hintText: 'Lütfen Ülke Giriniz',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor)),
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontSize:
                                            MediaQuery.of(context).size.width / 25),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor)),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                returnButtonPickCountry(
                                    context, height, width, constant.countryList),
                              ],
                            ),
                          ],
                        )
                      : pickCountry(context, height, width, constant.countryList),
                  SizedBox(
                    height: height / 30,
                  ),
                  pickCity(
                    context,
                    height,
                    width,
                    constant.cityList,
                  ),
                  SizedBox(
                    height: height / 30,
                  ),
                  Text('Eğitim',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: width / 15)),
                  SizedBox(
                    height: height / 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GFCheckbox(
                        size: GFSize.SMALL,
                        activeBgColor: GFColors.SUCCESS,
                        onChanged: (value) {
                          setState(() {
                            isMultipleMajor = value;
                          });
                          if (value == false) {
                            education.secondField = "";
                            education.secondUniversity = "";
                            education.secondYear = 0;
                          }
                        },
                        value: isMultipleMajor,
                      ),
                      SizedBox(width: width / 40),
                      Text('Birden fazla bölüm okuyorum',
                          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontWeight: FontWeight.w200, fontSize: width / 30))
                    ],
                  ),
                  SizedBox(
                    height: height / 30,
                  ),
                  isCustomUniversity
                      ? Stack(
                          children: [
                            TextField(
                              onChanged: (value) {
                                setState(() {
                                  education.university = value.toString();
                                });
                              },
                              decoration: InputDecoration(
                                hintStyle: Theme.of(context).textTheme.bodyText1,
                                hintText: 'Lütfen Üniversite Giriniz',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor)),
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontSize:
                                            MediaQuery.of(context).size.width / 25),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor)),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                returnButtonUni(
                                    context, height, width, constant.universityList)
                              ],
                            )
                          ],
                        )
                      : uniBox(context, height, width, constant.universityList),
                  SizedBox(
                    height: height / 30,
                  ),
                  fieldPicker(context, height, width),
                  SizedBox(
                    height: height / 60,
                  ),
                  firstUniGraduateYear(context, height, width),
                  SizedBox(
                    height: height / 60,
                  ),
                  Text('Sınıf',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: width / 25)),
                  Slider(
                    value: sliderValue,
                    min: 0,
                    max: 8,
                    divisions: 8,
                    thumbColor: Theme.of(context).primaryColor,
                    activeColor: Theme.of(context).primaryColorDark,
                    onChanged: (double value) {
                      setState(() {
                        sliderValue = value;
                      });
                      education.year = value.toInt();
                    },
                    label: classes[sliderValue.toInt()],
                  ),
                  isMultipleMajor
                      ? Column(
                          children: [
                            SizedBox(
                              height: height / 30,
                            ),
                            isCustomSecondUniversity
                                ? Column(
                                    children: [
                                      Stack(
                                        children: [
                                          TextField(
                                            onChanged: (value) {
                                              setState(() {
                                                education.secondUniversity =
                                                    value.toString();
                                              });
                                            },
                                            decoration: InputDecoration(
                                              hintStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                              hintText:
                                                  'Lütfen İkinci Üniversite Giriniz',
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .headline2!
                                                  .copyWith(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              25),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            ),
                                            //burası
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              returnButtonSecondUni(context, height,
                                                  width, constant.universityList),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: height / 30,
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            education.university != "university"
                                                ? showModalBottomSheet<Widget>(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () =>
                                                                    Get.back(),
                                                                child: Container(
                                                                    width:
                                                                        width / 3,
                                                                    height:
                                                                        height / 15,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(MediaQuery.of(context).size.width /
                                                                                20),
                                                                        color: Colors
                                                                            .transparent),
                                                                    child: Center(
                                                                      child: Text(
                                                                          'Tamam',
                                                                          style: Theme.of(
                                                                                  context)
                                                                              .textTheme
                                                                              .headline1!
                                                                              .copyWith(
                                                                                  color: Colors.blue,
                                                                                  fontSize: MediaQuery.of(context).size.width / 25)),
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                          //2
                                                          Container(
                                                            height: height / 3,
                                                            child: CupertinoPicker(
                                                                selectionOverlay:
                                                                    Container(
                                                                  color: Colors
                                                                      .transparent,
                                                                ),
                                                                onSelectedItemChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    education
                                                                            .secondField =
                                                                        constant.majors[
                                                                            value];
                                                                    multipleMajor =
                                                                        constant.majors[
                                                                            value];
                                                                  });
                                                                },
                                                                itemExtent: 50.0,
                                                                children: constant
                                                                    .majors
                                                                    .map<Widget>(
                                                                        (e) =>
                                                                            Text(e))
                                                                    .toList()),
                                                          ),
                                                        ],
                                                      );
                                                    })
                                                : Get.snackbar('', '',
                                                    padding:
                                                        EdgeInsets.all(width / 20),
                                                    titleText: Center(
                                                      child: Text(
                                                          'Lütfen Önce Üniversitenizi Seçiniz',
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .headline1!
                                                              .copyWith(
                                                                  color:
                                                                      Colors.white,
                                                                  fontSize:
                                                                      width / 25)),
                                                    ),
                                                    backgroundColor: Colors.red,
                                                    snackPosition:
                                                        SnackPosition.BOTTOM);
                                          },
                                          child: Container(
                                            width: width,
                                            height: height / 17,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Center(
                                              child: Text(
                                                education.secondField != ''
                                                    ? education.secondField!
                                                    : "Lütfen İkinci Bölüm Seçiniz",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2!
                                                    .copyWith(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        fontSize: width / 30),
                                              ),
                                            ),
                                          )),
                                      SizedBox(
                                        height: height / 60,
                                      ),
                                      Text('Sınıf',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1!
                                              .copyWith(fontSize: width / 25)),
                                      Slider(
                                        value: secondSliderValue,
                                        min: 0,
                                        max: 8,
                                        divisions: 8,
                                        thumbColor: Theme.of(context).primaryColor,
                                        activeColor:
                                            Theme.of(context).primaryColorDark,
                                        onChanged: (double value) {
                                          setState(() {
                                            secondSliderValue = value;
                                          });
                                          education.secondYear = value.toInt();
                                        },
                                        label: classes[secondSliderValue.toInt()],
                                      ),
                                    ],
                                  )
                                : secondMajor(context, height, width,
                                    constant.universityList),
                          ],
                        )
                      : SizedBox.shrink(),
                  SizedBox(
                    height: height / 120,
                  ),
                  kvkk(context, width),
                  SizedBox(
                    height: height / 120,
                  ),
                  backToTurkey(context, width),
                  registerButton(width, height, context),
                  SizedBox(
                    height: height / 60,
                  ),
                ],
              ),
            ),
          )),
    );
  }
  Padding registerButton(double width, double height, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(width / 30),
      child: GestureDetector(
        onTap: () {
          String username = slugify(name) +
              '-' +
              FirebaseAuth.instance.currentUser!.uid.substring(0, 3) +
              FirebaseAuth.instance.currentUser!.uid.substring(10, 12);

          UserModel user = UserModel(
              privateChatRoomIds: [],
              blockedUsers: [],
              roleNumber: 3,
              username: username,
              id: FirebaseAuth.instance.currentUser!.uid,
              registerDate: DateTime.now(),
              name: name,
              email: FirebaseAuth.instance.currentUser!.email!,
              phoneNumber: phone,
              education: education,
              location: location,
              kvkkApproved: kvkkApproved,
              comingBackToTurkey: comingBackToTurkey,
              secondGraduateYear: secondGraduateYear,
              firstGraduateYear: firstGraduateYear,
              reference: reference,
              likedPosts:[],
              postList:[]
              );
          UserBookmark userBookmark = UserBookmark(
              userId: FirebaseAuth.instance.currentUser!.uid, bookmarks: []);
          global.bookmarks = userBookmark;
          Future.wait([
            addUserToFirestore(user),
            getFeedObjects(),
            createBookmark(
                FirebaseAuth.instance.currentUser!.uid, userBookmark),
            getCompanies(companies),
            getJobOffers(jobs),
            getAllEvents(events),
            getAllPosts(posts).then((value) => posts = value)
          ]).then((value) async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            OneSignal.shared
                .setExternalUserId(FirebaseAuth.instance.currentUser!.uid);
            prefs.setString(
                'onesignal', FirebaseAuth.instance.currentUser!.uid);
            Get.to(() => HomePage(
                  notificationReceived: false,
                  jobs: jobs,
                  companies: companies,
                  events: events,
                  rooms: widget.rooms,
                  user: user,
                  allUsers: allUsers,
                  posts: posts,
                  pageIndex: 0,
                ));
          });
        },
        child: Container(
            height: height / 15,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width / 20),
                color: Theme.of(context).primaryColorDark),
            child: Center(
              child: Text('Kaydı Tamamla!',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(color: Colors.white, fontSize: width / 25)),
            )),
      ),
    );
  }

  Row kvkk(BuildContext context, double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GFCheckbox(
          size: GFSize.SMALL,
          activeBgColor: GFColors.SUCCESS,
          onChanged: (value) {
            setState(() {
              kvkkApproved = value;
            });
            print(kvkkApproved.toString());
          },
          value: kvkkApproved,
        ),
        SizedBox(width: width / 40),
        GestureDetector(
          onTap: () async {
            final path = "images/kvkk.pdf";
            final file = await PDFApi.loadAsset(path);
            openPDF(context, file);
          },
          child: Text('Aydınlatma metnini ve KVKK sözleşmesini Onaylıyorum',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Colors.blue,
                  fontWeight: FontWeight.w200,
                  fontSize: width / 34)),
        )
      ],
    );
  }

  Row backToTurkey(BuildContext context, double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GFCheckbox(
          size: GFSize.SMALL,
          activeBgColor: GFColors.SUCCESS,
          onChanged: (value) {
            setState(() {
              comingBackToTurkey = value;
            });
          },
          value: comingBackToTurkey,
        ),
        SizedBox(width: width / 40),
        Flexible(
          child: Text(
              "Mezun Olduktan Sonra Türkiye'ye Geri Dönmeyi Düşünüyorum",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.w200, fontSize: width / 32)),
        ),
      ],
    );
  }

  Widget fieldPicker(BuildContext context, double height, double width) {
    return GestureDetector(
        onTap: () {
          education.university != "university"
              ? showModalBottomSheet<Widget>(
                  context: context,
                  builder: (BuildContext context) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: Container(
                                  width: width / 3,
                                  height: height / 15,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.width /
                                              20),
                                      color: Colors.transparent),
                                  child: Center(
                                    child: Text('Tamam',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1!
                                            .copyWith(
                                                color: Colors.blue,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    25)),
                                  )),
                            ),
                          ],
                        ),
                        //2
                        Container(
                          height: height / 3,
                          child: CupertinoPicker(
                              selectionOverlay: Container(
                                color: Colors.transparent,
                              ),
                              onSelectedItemChanged: (value) {
                                setState(() {
                                  education.field = constant.majors[value];
                                  major = constant.majors[value];
                                });
                              },
                              itemExtent: 50.0,
                              children: constant.majors
                                  .map<Widget>((e) => Text(e))
                                  .toList()),
                        ),
                      ],
                    );
                  })
              : Get.snackbar('', '',
                  padding: EdgeInsets.all(width / 20),
                  titleText: Center(
                    child: Text('Lütfen Önce Üniversitenizi Seçiniz',
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            color: Colors.white, fontSize: width / 25)),
                  ),
                  backgroundColor: Colors.red,
                  snackPosition: SnackPosition.BOTTOM);
        },
        child: Container(
          width: width,
          height: height / 17,
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: Text(
              education.field != '' ? education.field : "Lütfen Bölüm Seçiniz",
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Theme.of(context).primaryColor, fontSize: width / 30),
            ),
          ),
        ));
  }

  Widget secondMajor(
      BuildContext context, double height, double width, Map universityList) {
    return Column(
      children: [
        GestureDetector(
            onTap: () {
              if (location.city != '') {
                showModalBottomSheet<Widget>(
                    context: context,
                    builder: (BuildContext context) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () => Get.back(),
                                child: Container(
                                    width: width / 3,
                                    height: height / 15,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            MediaQuery.of(context).size.width /
                                                20),
                                        color: Colors.transparent),
                                    child: Center(
                                      child: Text('Tamam',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1!
                                              .copyWith(
                                                  color: Colors.blue,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          25)),
                                    )),
                              ),
                            ],
                          ),
                          Container(
                            height: height / 3,
                            child: CupertinoPicker(
                                selectionOverlay: Container(
                                  color: Colors.transparent,
                                ),
                                onSelectedItemChanged: (value) {
                                  if (value ==
                                      universityList[location.city].length -
                                          1) {
                                    setState(() {
                                      isCustomSecondUniversity = true;
                                    });
                                  } else {
                                    setState(() {
                                      isCustomSecondUniversity = false;
                                      education.secondUniversity =
                                          universityList[location.city]![value];
                                    });
                                  }
                                },
                                itemExtent: 50.0,
                                children: universityList[location.city]!
                                    .map<Widget>((e) => Text(e))
                                    .toList()),
                          ),
                        ],
                      );
                    });
              } else {
                Get.snackbar('', '',
                    padding: EdgeInsets.all(width / 20),
                    titleText: Center(
                      child: Text('Lütfen Önce Şehir Seçiniz',
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  color: Colors.white, fontSize: width / 25)),
                    ),
                    backgroundColor: Colors.red,
                    snackPosition: SnackPosition.BOTTOM);
              }
            },
            child: Container(
              width: width,
              height: height / 17,
              decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(
                    education.secondUniversity != ''
                        ? education.secondUniversity!
                        : 'Lütfen İkinci Üniversite Seçin',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: width / 30)),
              ),
            )),
        SizedBox(
          height: height / 30,
        ),
        GestureDetector(
            onTap: () {
              education.university != "university"
                  ? showModalBottomSheet<Widget>(
                      context: context,
                      builder: (BuildContext context) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () => Get.back(),
                                  child: Container(
                                      width: width / 3,
                                      height: height / 15,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  20),
                                          color: Colors.transparent),
                                      child: Center(
                                        child: Text('Tamam',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1!
                                                .copyWith(
                                                    color: Colors.blue,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            25)),
                                      )),
                                ),
                              ],
                            ),
                            //2
                            Container(
                              height: height / 3,
                              child: CupertinoPicker(
                                  selectionOverlay: Container(
                                    color: Colors.transparent,
                                  ),
                                  onSelectedItemChanged: (value) {
                                    setState(() {
                                      education.secondField =
                                          constant.majors[value];
                                      multipleMajor = constant.majors[value];
                                    });
                                  },
                                  itemExtent: 50.0,
                                  children: constant.majors
                                      .map<Widget>((e) => Text(e))
                                      .toList()),
                            ),
                          ],
                        );
                      })
                  : Get.snackbar('', '',
                      padding: EdgeInsets.all(width / 20),
                      titleText: Center(
                        child: Text('Lütfen Önce Üniversitenizi Seçiniz',
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    color: Colors.white, fontSize: width / 25)),
                      ),
                      backgroundColor: Colors.red,
                      snackPosition: SnackPosition.BOTTOM);
            },
            child: Container(
              width: width,
              height: height / 17,
              decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(
                  education.secondField != ''
                      ? education.secondField!
                      : "Lütfen İkinci Bölüm Seçiniz",
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: width / 30),
                ),
              ),
            )),
        SizedBox(
          height: height / 60,
        ),
        Text('Sınıf',
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(fontSize: width / 25)),
        Slider(
          value: secondSliderValue,
          min: 0,
          max: 8,
          divisions: 8,
          thumbColor: Theme.of(context).primaryColor,
          activeColor: Theme.of(context).primaryColorDark,
          onChanged: (double value) {
            setState(() {
              secondSliderValue = value;
            });
            education.secondYear = value.toInt();
          },
          label: classes[secondSliderValue.toInt()],
        ),
        secondUniGraduateYear(context, height, width)
      ],
    );
  }

  Widget uniBox(
    context,
    double height,
    double width,
    Map universityList,
  ) {
    return GestureDetector(
        onTap: () {
          if (location.city != '') {
            showModalBottomSheet<Widget>(
                context: context,
                builder: (BuildContext context) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Container(
                                width: width / 3,
                                height: height / 15,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        MediaQuery.of(context).size.width / 20),
                                    color: Colors.transparent),
                                child: Center(
                                  child: Text('Tamam',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1!
                                          .copyWith(
                                              color: Colors.blue,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  25)),
                                )),
                          ),
                        ],
                      ),
                      Container(
                        height: height / 3,
                        child: CupertinoPicker(
                            selectionOverlay: Container(
                              color: Colors.transparent,
                            ),
                            onSelectedItemChanged: (value) {
                              if (value ==
                                  universityList[location.city].length - 1) {
                                setState(() {
                                  isCustomUniversity = true;
                                });
                              } else {
                                setState(() {
                                  isCustomUniversity = false;
                                  education.university =
                                      universityList[location.city]![value];
                                });
                              }
                            },
                            itemExtent: 50.0,
                            children: universityList[location.city]!
                                .map<Widget>((e) => Text(e))
                                .toList()),
                      ),
                    ],
                  );
                });
          } else {
            Get.snackbar('', '',
                padding: EdgeInsets.all(width / 20),
                titleText: Center(
                  child: Text('Lütfen Önce Şehir Seçiniz',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(color: Colors.white, fontSize: width / 25)),
                ),
                backgroundColor: Colors.red,
                snackPosition: SnackPosition.BOTTOM);
          }
        },
        child: Container(
          width: width,
          height: height / 17,
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: Text(
                education.university != ''
                    ? education.university
                    : 'Lütfen Üniversite Seçin',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: width / 30)),
          ),
        ));
  }

  Widget pickCity(
    context,
    double height,
    double width,
    Map mapForCity,
  ) {
    return isCustomCity
        ? Stack(
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    location.city = value.toString();
                  });
                },
                decoration: InputDecoration(
                  hintStyle: Theme.of(context).textTheme.bodyText1,
                  hintText: 'Lütfen Şehir Giriniz',
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor)),
                  labelStyle: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: MediaQuery.of(context).size.width / 25),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  isCustomCountry
                      ? SizedBox.shrink()
                      : returnButtonPickCity(
                          context, height, width, mapForCity),
                ],
              ),
            ],
          )
        : GestureDetector(
            onTap: () {
              if (location.country != '') {
                showModalBottomSheet<Widget>(
                    context: context,
                    builder: (BuildContext context) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () => Get.back(),
                                child: Container(
                                    width: width / 3,
                                    height: height / 15,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            MediaQuery.of(context).size.width /
                                                20),
                                        color: Colors.transparent),
                                    child: Center(
                                      child: Text('Tamam',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1!
                                              .copyWith(
                                                  color: Colors.blue,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          25)),
                                    )),
                              ),
                            ],
                          ),
                          Container(
                            height: height / 3,
                            child: CupertinoPicker(
                                selectionOverlay: Container(
                                  color: Colors.transparent,
                                ),
                                onSelectedItemChanged: (value) {
                                  if (value ==
                                      mapForCity[location.country].length - 1) {
                                    setState(() {
                                      isCustomCity = true;
                                      isCustomUniversity = true;
                                      isCustomSecondUniversity = true;
                                    });
                                  } else {
                                    setState(() {
                                      isCustomCity = false;
                                      isCustomUniversity = false;
                                      isCustomSecondUniversity = false;
                                      location.city =
                                          mapForCity[location.country]![value];
                                    });
                                  }
                                },
                                itemExtent: 50.0,
                                children: mapForCity[location.country]!
                                    .map<Widget>((e) => Text(e))
                                    .toList()),
                          ),
                        ],
                      );
                    });
              } else {
                Get.snackbar('', '',
                    padding: EdgeInsets.all(width / 20),
                    titleText: Center(
                      child: Text('Lütfen Önce Ülke Seçiniz',
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  color: Colors.white, fontSize: width / 25)),
                    ),
                    backgroundColor: Colors.red,
                    snackPosition: SnackPosition.BOTTOM);
              }
            },
            child: Container(
              width: width,
              height: height / 17,
              decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(
                    location.city != '' ? location.city : 'Lütfen Şehir Seçin',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: width / 30)),
              ),
            ));
  }

  GestureDetector pickCountry(
    context,
    double height,
    double width,
    List listForCountry,
  ) {
    return GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                              width: width / 3,
                              height: height / 15,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width / 20),
                                  color: Colors.transparent),
                              child: Center(
                                child: Text('Tamam',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                            color: Colors.blue,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                25)),
                              )),
                        ),
                      ],
                    ),
                    Container(
                      height: height / 3,
                      child: CupertinoPicker(
                        selectionOverlay: Container(
                          color: Colors.transparent,
                        ),
                        onSelectedItemChanged: (value) {
                          if (value == listForCountry.length - 1) {
                            setState(() {
                              isCustomCountry = true;
                              isCustomUniversity = true;
                              isCustomSecondUniversity = true;
                              isCustomCity = true;
                            });
                          } else {
                            setState(() {
                              isCustomCountry = false;
                              isCustomUniversity = false;
                              isCustomSecondUniversity = false;
                              isCustomCity = false;
                              location.country = listForCountry[value];
                            });
                          }
                          ;
                        },
                        itemExtent: 50.0,
                        children: listForCountry.map((e) => Text(e)).toList(),
                      ),
                    ),
                  ],
                );
              });
        },
        child: Container(
          width: width,
          height: height / 17,
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: Text(
              location.country != '' ? location.country : 'Lütfen Ülke Seçin',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Theme.of(context).primaryColor, fontSize: width / 30),
            ),
          ),
        ));
  }

  //burası
  Column referenceBox(
    context,
    double height,
    double width,
  ) {
    return Column(
      children: [
        GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: Container(
                                  width: width / 3,
                                  height: height / 15,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.width /
                                              20),
                                      color: Colors.transparent),
                                  child: Center(
                                    child: Text('Tamam',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1!
                                            .copyWith(
                                                color: Colors.blue,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    25)),
                                  )),
                            ),
                          ],
                        ),
                        Container(
                          height: height / 3,
                          child: CupertinoPicker(
                            selectionOverlay: Container(
                              color: Colors.transparent,
                            ),
                            onSelectedItemChanged: (value) {
                              if (value == referenceList.length - 1) {
                                referenceFields = true;
                                otherReference = true;
                                setState(() {
                                  reference = referenceList[value];
                                });
                              } else if (value == 0) {
                                referenceFields = true;
                                otherReference = false;
                                setState(() {
                                  reference = referenceList[value];
                                });
                              } else {
                                referenceFields = false;
                                setState(() {
                                  reference = referenceList[value];
                                });
                              }
                            },
                            itemExtent: 50.0,
                            children:
                                referenceList.map((e) => Text(e)).toList(),
                          ),
                        ),
                      ],
                    );
                  });
            },
            child: Container(
              width: width,
              height: height / 17,
              decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(
                  reference != '' ? reference : 'Bizi Nereden Duydunuz?',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: width / 30),
                ),
              ),
            )),
        referenceFields
            ? Column(
                children: [
                  SizedBox(
                    height: height / 30,
                  ),
                  otherReference
                      ? TextField(
                          onChanged: (value) {
                            setState(() {
                              reference = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintStyle: Theme.of(context).textTheme.bodyText1,
                            hintText: 'Diğer',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor)),
                            labelStyle: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontSize:
                                        MediaQuery.of(context).size.width / 25),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor)),
                          ),
                        )
                      : TextField(
                          onChanged: (value) {
                            setState(() {
                              reference = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintStyle: Theme.of(context).textTheme.bodyText1,
                            hintText: 'Temsilcinizin Adı',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor)),
                            labelStyle: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontSize:
                                        MediaQuery.of(context).size.width / 25),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor)),
                          ),
                        ),
                ],
              )
            : SizedBox.shrink()
      ],
    );
  }

  GestureDetector returnButtonPickCountry(
    context,
    double height,
    double width,
    List listForCountry,
  ) {
    return GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                              width: width / 3,
                              height: height / 15,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width / 20),
                                  color: Colors.transparent),
                              child: Center(
                                child: Text('Tamam',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                            color: Colors.blue,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                25)),
                              )),
                        ),
                      ],
                    ),
                    Container(
                      height: height / 3,
                      child: CupertinoPicker(
                        selectionOverlay: Container(
                          color: Colors.transparent,
                        ),
                        onSelectedItemChanged: (value) {
                          if (value == listForCountry.length - 1) {
                            setState(() {
                              isCustomCountry = true;
                            });
                          } else {
                            isCustomCountry = false;
                            setState(() {
                              location.country = listForCountry[value];
                            });
                          }
                          ;
                        },
                        itemExtent: 50.0,
                        children: listForCountry.map((e) => Text(e)).toList(),
                      ),
                    ),
                  ],
                );
              });
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 16, right: 5),
          child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Icon(
                Icons.arrow_downward_rounded,
                color: Colors.white,
              )),
        ));
  }

  GestureDetector returnButtonPickCity(
    context,
    double height,
    double width,
    Map mapForCity,
  ) {
    return GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                              width: width / 3,
                              height: height / 15,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width / 20),
                                  color: Colors.transparent),
                              child: Center(
                                child: Text('Tamam',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                            color: Colors.blue,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                25)),
                              )),
                        ),
                      ],
                    ),
                    Container(
                      height: height / 3,
                      child: CupertinoPicker(
                          selectionOverlay: Container(
                            color: Colors.transparent,
                          ),
                          onSelectedItemChanged: (value) {
                            if (value ==
                                mapForCity[location.country].length - 1) {
                              setState(() {
                                isCustomCity = true;
                                isCustomUniversity = true;
                                isCustomSecondUniversity = true;
                              });
                            } else {
                              setState(() {
                                isCustomCity = false;
                                isCustomUniversity = false;
                                isCustomSecondUniversity = false;
                                location.city =
                                    mapForCity[location.country]![value];
                              });
                            }
                          },
                          itemExtent: 50.0,
                          children: mapForCity[location.country]!
                              .map<Widget>((e) => Text(e))
                              .toList()),
                    ),
                  ],
                );
              });
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 16, right: 5),
          child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Icon(
                Icons.arrow_downward_rounded,
                color: Colors.white,
              )),
        ));
  }

  GestureDetector returnButtonSecondUni(
    context,
    double height,
    double width,
    Map universityList,
  ) {
    return GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                              width: width / 3,
                              height: height / 15,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width / 20),
                                  color: Colors.transparent),
                              child: Center(
                                child: Text('Tamam',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                            color: Colors.blue,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                25)),
                              )),
                        ),
                      ],
                    ),
                    Container(
                      height: height / 3,
                      child: CupertinoPicker(
                          selectionOverlay: Container(
                            color: Colors.transparent,
                          ),
                          onSelectedItemChanged: (value) {
                            if (value ==
                                universityList[location.city].length - 1) {
                              setState(() {
                                isCustomSecondUniversity = true;
                              });
                            } else {
                              setState(() {
                                isCustomSecondUniversity = false;
                                education.secondUniversity =
                                    universityList[location.city]![value];
                              });
                            }
                          },
                          itemExtent: 50.0,
                          children: universityList[location.city]!
                              .map<Widget>((e) => Text(e))
                              .toList()),
                    ),
                  ],
                );
              });
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 16, right: 5),
          child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Icon(
                Icons.arrow_downward_rounded,
                color: Colors.white,
              )),
        ));
  }

  GestureDetector returnButtonUni(
    context,
    double height,
    double width,
    Map universityList,
  ) {
    return GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                              width: width / 3,
                              height: height / 15,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width / 20),
                                  color: Colors.transparent),
                              child: Center(
                                child: Text('Tamam',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                            color: Colors.blue,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                25)),
                              )),
                        ),
                      ],
                    ),
                    Container(
                      height: height / 3,
                      child: CupertinoPicker(
                          selectionOverlay: Container(
                            color: Colors.transparent,
                          ),
                          onSelectedItemChanged: (value) {
                            if (value ==
                                universityList[location.city].length - 1) {
                              setState(() {
                                isCustomUniversity = true;
                              });
                            } else {
                              setState(() {
                                isCustomUniversity = false;
                                education.university =
                                    universityList[location.city]![value];
                              });
                            }
                          },
                          itemExtent: 50.0,
                          children: universityList[location.city]!
                              .map<Widget>((e) => Text(e))
                              .toList()),
                    ),
                  ],
                );
              });
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 16, right: 5),
          child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Icon(
                Icons.arrow_downward_rounded,
                color: Colors.white,
              )),
        ));
  }

  //1
  GestureDetector genderPicker(
      BuildContext context, double height, double width) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet<Widget>(
            context: context,
            builder: (BuildContext context) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                            width: width / 3,
                            height: height / 15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width / 20),
                                color: Colors.transparent),
                            child: Center(
                              child: Text('Tamam',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(
                                          color: Colors.blue,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              25)),
                            )),
                      ),
                    ],
                  ),
                  Container(
                    height: height / 3,
                    child: CupertinoPicker(
                        selectionOverlay: Container(
                          color: Colors.transparent,
                        ),
                        onSelectedItemChanged: (value) {
                          setState(() {
                            gender = genders[value];
                            print(gender);
                          });
                        },
                        itemExtent: 50.0,
                        children: genders.map<Widget>((e) => Text(e)).toList()),
                  ),
                ],
              );
            });
      },
      child: TextField(
        enabled: false,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: gender,
          hintStyle: Theme.of(context).textTheme.bodyText1,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          labelStyle: Theme.of(context).textTheme.headline2!.copyWith(
              color: Theme.of(context).primaryColor,
              fontSize: MediaQuery.of(context).size.width / 25),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
        ),
      ),
    );
  }

  GestureDetector firstUniGraduateYear(
      BuildContext context, double height, double width) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet<Widget>(
            context: context,
            builder: (BuildContext context) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                            width: width / 3,
                            height: height / 15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width / 20),
                                color: Colors.transparent),
                            child: Center(
                              child: Text('Tamam',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(
                                          color: Colors.blue,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              25)),
                            )),
                      ),
                    ],
                  ),
                  Container(
                    height: height / 3,
                    child: CupertinoPicker(
                        selectionOverlay: Container(
                          color: Colors.transparent,
                        ),
                        onSelectedItemChanged: (value) {
                          setState(() {
                            firstGraduateYear = graduateYears[value];
                          });
                        },
                        itemExtent: 50.0,
                        children:
                            graduateYears.map<Widget>((e) => Text(e)).toList()),
                  ),
                ],
              );
            });
      },
      child: Container(
          width: width,
          height: height / 17,
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: Text(
              firstGraduateYear,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Theme.of(context).primaryColor, fontSize: width / 30),
            ),
          ),
        ));
  }
  GestureDetector secondUniGraduateYear(
      BuildContext context, double height, double width) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet<Widget>(
            context: context,
            builder: (BuildContext context) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                            width: width / 3,
                            height: height / 15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width / 20),
                                color: Colors.transparent),
                            child: Center(
                              child: Text('Tamam',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(
                                          color: Colors.blue,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              25)),
                            )),
                      ),
                    ],
                  ),
                  Container(
                    height: height / 3,
                    child: CupertinoPicker(
                        selectionOverlay: Container(
                          color: Colors.transparent,
                        ),
                        onSelectedItemChanged: (value) {
                          setState(() {
                            secondGraduateYear = graduateYears[value];
                          });
                        },
                        itemExtent: 50.0,
                        children:
                            graduateYears.map<Widget>((e) => Text(e)).toList()),
                  ),
                ],
              );
            });
      },
      child: Container(
          width: width,
          height: height / 17,
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: Text(
              secondGraduateYear,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Theme.of(context).primaryColor, fontSize: width / 30),
            ),
          ),
        ));
  }

  TextField phoneBox(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.phone,
      onChanged: (value) {
        setState(() {
          phone = value;
        });
      },
      decoration: InputDecoration(
        hintStyle: Theme.of(context).textTheme.bodyText1,
        hintText: 'Telefon Numarası',
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
        labelStyle: Theme.of(context).textTheme.headline2!.copyWith(
            color: Theme.of(context).primaryColor,
            fontSize: MediaQuery.of(context).size.width / 25),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
      ),
    );
  }

  TextField nameBox(BuildContext context) {
    return TextField(
      
      onChanged: (value) {
        setState(() {
          name = value;
        });
      },
      decoration: InputDecoration(
        hintStyle: Theme.of(context).textTheme.bodyText1,
        hintText: 'Ad Soyad',
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
        labelStyle: Theme.of(context).textTheme.headline2!.copyWith(
            color: Theme.of(context).primaryColor,
            fontSize: MediaQuery.of(context).size.width / 25),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
      ),
    );
  }
}

void openPDF(BuildContext context, File file) {
  Get.to(PdfViewPage(file: file));
}
