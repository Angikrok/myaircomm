import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final Color color;
  final double size;

  // ignore: use_key_in_widget_constructors
  const Logo({
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 100, width: 280, child: Image.asset('assets/icon/logo2.png'));
  }
}
