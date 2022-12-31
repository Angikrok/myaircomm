import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomBody extends StatelessWidget {
  Widget child;
  bool verticalSpace;
  bool horizontalSpace;
  CustomBody({
    required this.child,
    required this.horizontalSpace,
    required this.verticalSpace,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: horizontalSpace ? 16 : 0,
            vertical: verticalSpace ? 14 : 0),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0x5c2196f3), Color(0x00795548)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: child);
  }
}
