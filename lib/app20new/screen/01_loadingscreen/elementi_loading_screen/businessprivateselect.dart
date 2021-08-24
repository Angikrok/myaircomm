import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_aircomm/app20new/model/costanti.dart';
import 'package:my_aircomm/app20new/screen/02_login/login_aziendale.dart';
import 'package:my_aircomm/app20new/screen/02_login/login_privato.dart';

import 'animation.dart';

class BusinessPrivate extends StatelessWidget {
  final Animation<double> animation;

  // ignore: use_key_in_widget_constructors
  const BusinessPrivate({
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? kSpaceM : kSpaceS;

    return privateBusinessSelection(space, context);
  }

  Expanded privateBusinessSelection(double space, BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                SizedBox(
                  height: 115,
                  child: FadeSlideTransition(
                    animation: animation,
                    additionalOffset: 0.0,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Privato()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          gradient: const LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.transparent,
                            ],
                            end: Alignment(0, -1),
                          ),
                        ),
                        child: ClipRRect(
                          // child: Image.asset('assets/icon/businessman.png'),
                          child: SvgPicture.asset(
                            'assets/icon/person2.svg',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                FadeSlideTransition(
                  animation: animation,
                  additionalOffset: space,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Privato',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                SizedBox(
                  height: 115,
                  child: FadeSlideTransition(
                    animation: animation,
                    additionalOffset: space,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Aziendale()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          gradient: const LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.transparent,
                            ],
                            end: Alignment(0, -1),
                          ),
                        ),
                        child: ClipRRect(
                          child: SvgPicture.asset('assets/icon/factory4.svg'),
                        ),
                      ),
                    ),
                  ),
                ),
                FadeSlideTransition(
                  animation: animation,
                  additionalOffset: space,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Aziendale',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
