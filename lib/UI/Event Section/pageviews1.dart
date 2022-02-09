import 'package:flutter/material.dart';

class PageViewEventSection1 extends StatelessWidget {
  const PageViewEventSection1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'Hakkında',
            style: Theme.of(context).textTheme.headline1,
          )
        ],
      ),
    );
  }
}
