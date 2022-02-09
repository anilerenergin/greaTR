import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:greatr/UI/Companies/textWidget.dart';

class SingleNews extends StatefulWidget {
  SingleNews({Key? key}) : super(key: key);

  @override
  State<SingleNews> createState() => _SingleNewsState();
}

class _SingleNewsState extends State<SingleNews> {
  bool showNav = true;
  List<Widget> texts = [
    TextWidget(),
    TextWidget(),
    TextWidget(),
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            FontAwesomeIcons.arrowLeft,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(width / 30),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(width / 25),
                    child: ExtendedImage.network(
                      'https://cdn-1.motorsport.com/images/amp/Yv8ZnvE0/s1200/valtteri-bottas-mercedes-w12-1.webp',
                      fit: BoxFit.cover,
                      width: width,
                      height: height / 3.5,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width / 40, vertical: width / 80),
                  child: Text(
                    'Mercedes, sıralama turları öncesinde aracın dengesini geliştirmeye çalışacak',
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: width / 20),
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: width / 20, bottom: width / 20),
                  child: Row(
                    children: [
                      Text(
                        'Mercedes',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: width / 30, color: Colors.grey.shade500),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        width: width / 30,
                      ),
                      Container(
                        width: 1,
                        color: Colors.grey.shade400,
                        height: height / 60,
                      ),
                      SizedBox(
                        width: width / 30,
                      ),
                      Text(
                        '29/01/2021',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: width / 30, color: Colors.grey.shade500),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: width / 40, right: width / 2),
                  child: Container(
                    height: 2,
                    width: width / 2.5,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Column(
                  children: texts,
                )
              ],
            ),
            Positioned(
                bottom: 0, child: bottomNav(height, width, context, texts))
          ],
        ),
      ),
    );
  }

  Widget bottomNav(double height, double width, BuildContext context,
      List<Widget> textList) {
    return GestureDetector(
      onTap: () {
        setState(() {
          showNav = false;
          texts.add(TextWidget());
          texts.add(TextWidget());
        });
      },
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 200),
        opacity: showNav ? 1 : 0,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width / 30, vertical: width / 30),
          child: GestureDetector(
            child: Container(
              height: height / 15,
              width: width / 1.1,
              decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 150.0,
                        offset: Offset(0.0, 0.75))
                  ],
                  borderRadius: BorderRadius.circular(width / 30),
                  color: Theme.of(context).primaryColorDark),
              child: Center(
                child: Text('Devamını Oku',
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(color: Colors.white, fontSize: width / 25)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
