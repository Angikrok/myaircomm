

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myaircomm/constants.dart';
import 'package:myaircomm/model/widget/custombody.dart';
import 'package:myaircomm/model/widget/wave.dart';
import 'package:myaircomm/screens/login/onboarding2.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          CustomBody(
            horizontalSpace: false,
            verticalSpace: false,
            child: Center(
              child: Column(
                children: [
                  Wave(reverse: false, flip: true),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Image.asset(
                      "assets/images/player1.png",
                      height: MediaQuery.of(context).size.height / 2.7,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Text(
                      textAlign: TextAlign.center,
                      "\n\nLa nostra app semplifica la gestione delle fatture e l'invio delle transazioni, in modo che possiate dedicare più tempo ed energie al vostro lavoro!",
                      style: montSerrat(
                        color: grey,
                        fontSize: 20,
                        letterSpacing: 1.8,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.only(left: 60),
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: orange,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            color: grey.withOpacity(0.32),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: grey.withOpacity(0.3))),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OnBoarding2(),
                              ));
                        },
                        child: Container(
                            margin: const EdgeInsets.only(right: 20),
                            padding: const EdgeInsets.only(
                                top: 12, bottom: 12, left: 12, right: 12),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: blue),
                            child: const Icon(
                              CupertinoIcons.right_chevron,
                              color: Colors.white,
                              size: 30,
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
