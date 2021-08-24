import 'package:flutter/material.dart';
import 'package:my_aircomm/app20new/model/costanti.dart';
import 'logo.dart';

class Header extends StatelessWidget {
  final Animation<double> animation;

  // ignore: use_key_in_widget_constructors
  const Header({
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        Logo(
          color: kBlue,
          size: 50.0,
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
