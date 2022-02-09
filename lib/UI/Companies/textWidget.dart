import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: width / 20, vertical: width / 30),
      child: Text(
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, mnis iste natus error sit voluptatem accusantium doloremque laudantium,',
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontSize: width / 25)),
    );
  }
}
