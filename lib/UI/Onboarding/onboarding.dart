import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:greatr/UI/Login/login-signin.dart';

class Onboarding extends StatefulWidget {
  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _pageController = PageController();

  int pageIndex = 0;
  late Image image1;
  late Image image2;
  late Image image3;
  late Image image4;
@override
  void initState() {
    super.initState();
 
    image1 = Image.asset("images/onboard1.png");
    image2 = Image.asset("images/onboard2.png");
    image3 = Image.asset("images/onboard3.png");
    image4 = Image.asset("images/onboard4.png");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
   
    precacheImage(image1.image, context);
    precacheImage(image2.image, context);
    precacheImage(image3.image, context);
    precacheImage(image4.image, context);
  }
  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          child: Stack(
            children: [
              PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    pageIndex = index;
                  });
                },
                children: [
                  onboardPage(
                    context,
                    height,
                    width,
                    'images/onboard1.png',
                    "Türkiye'den kariyer fırsatlarını yakala",
                  ),
                  onboardPage(context, height, width, 'images/onboard2.png',
                      "greaTR üyelerine özel etkinliklere katılım şansı yakala"),
                  onboardPage(context, height, width, 'images/onboard3.png',
                      "Yurt dışında okuyan diğer Türk öğrencilerle tanış"),
                  onboardPage(
                    context,
                    height,
                    width,
                    'images/onboard4.png',
                    "Yurt dışında okuyorsan sen de aramıza katıl!",
                  )
                ],
              ),
              SizedBox(height:8),
              Padding(
                padding: EdgeInsets.only(top: height / 3.0),
                child: Align(
                  alignment: Alignment.center,
                  child: indicatorForCarousel(width, height),
                ),
              ),
              pageIndex == 3
                  ? Positioned(
                      bottom: height / 8,
                      child: bottomNav(height, width, context))
                  : SizedBox.shrink()
            ],
          ),
        ));
  }

  Stack onboardPage(
    BuildContext context,
    double height,
    double width,
    String imageUrl,
    String title,
  ) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
         decoration:
BoxDecoration(
  color:  Colors.black,
  image: new DecorationImage(
    fit: BoxFit.fitHeight,
    colorFilter: 
      ColorFilter.mode(Colors.black.withOpacity(0.3), 
      BlendMode.dstATop),
    image: AssetImage(imageUrl)
  ),
),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: 18.0 * height / 1000, top: 28 * height / 1000),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      height: height / 3.2,
                      width: width / 1.2,
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            color: Colors.white,
                            fontSize: 55 * height / 1000,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -4),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget indicatorForCarousel(double width, double height) {
    return Container(
      height: width / 18,
      width: width,
      alignment: Alignment.center,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount:4,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(height / 300),
              child: Container(
                width: width / 20,
                height: width / 20,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: pageIndex == index
                        ? Theme.of(context).primaryColorDark
                        : Colors.grey.shade300),
              ),
            );
          }),
    );
  }

  Container bottomNav(double height, double width, BuildContext context) {
    return Container(
      height: height / 10,
      width: width,
      child: Padding(
        padding: EdgeInsets.all(width / 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 20,
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => LoginPage());
                  },
                  child: Container(
                    height: height / 15,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width / 30),
                        color: Theme.of(context).primaryColorDark),
                    child: Center(
                      child: Text('Şimdi Aramıza Katıl!',
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  color: Colors.white, fontSize: width / 25)),
                    ),
                  ),
                )),
            Expanded(
              flex: 1,
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}

const ColorFilter identity = ColorFilter.matrix(<double>[
  1,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
  20,
  10,
  300,
  300,
  100,
  10,
]);
