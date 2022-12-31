import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class Wave extends StatelessWidget {
   Wave({super.key, required this.reverse, required this.flip});
  bool reverse;
  bool flip;
  @override
  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper: WaveClipperOne(reverse: reverse, flip: flip),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 95,
          color: blue,
        ));
  }
}
