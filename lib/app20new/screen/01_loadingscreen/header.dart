import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final Animation<double> animation;

  // ignore: use_key_in_widget_constructors
  const Header({
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 100,
          width: 280,
          child: Image.asset(
            'assets/icon/logo2.png',
          ),
        ),

        // SizedBox(height: kSpaceM),
        // FadeSlideTransition(
        //   animation: animation,
        //   additionalOffset: 0.0,
        //   child: Text(
        //     'Benvenuto su MyAircomm',
        //     style: Theme.of(context)
        //         .textTheme
        //         .headline5!
        //         .copyWith(color: kBlack, fontWeight: FontWeight.bold),
        //   ),
        // ),
        // SizedBox(height: kSpaceS),
      ],
    );
  }
}
