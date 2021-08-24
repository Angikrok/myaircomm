import 'package:flutter/material.dart';
import './animation.dart';

class TextAnimato extends StatelessWidget {
  final Animation<double> animation;
  const TextAnimato({required this.animation, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeSlideTransition(
      additionalOffset: 0.0,
      animation: animation,
      child: const Text(
        'Seleziona profilo:',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }
}
