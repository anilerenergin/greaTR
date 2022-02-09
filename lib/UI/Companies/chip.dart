import 'package:flutter/material.dart';

class CustomChipForEvent extends StatelessWidget {
  final String tag;
  const CustomChipForEvent({required this.tag});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: EdgeInsets.all(6.0),
          child: Text(
            tag,
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
        ),
      ),
    );
  }
}
