import 'package:flutter/material.dart';

Padding avatarMethod(double left, int image, BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(left: left),
    child: Container(
      height: MediaQuery.of(context).size.height / 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: new Border.all(
          color: Theme.of(context).backgroundColor,
          width: 1.0,
        ),
      ),
      child: CircleAvatar(
          backgroundColor: Colors.accents[image + 4],
          backgroundImage: AssetImage('images/avatar$image.png')),
    ),
  );
}
