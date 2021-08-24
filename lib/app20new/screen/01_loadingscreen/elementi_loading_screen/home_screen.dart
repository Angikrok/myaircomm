import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_aircomm/app20new/model/costanti.dart';
import 'package:my_aircomm/app20new/model/custom_clippers/header_screen.dart';
import 'package:my_aircomm/app20new/model/custom_clippers/linea_arancione.dart';
import 'package:my_aircomm/app20new/model/custom_clippers/linea_blu.dart';
import 'header.dart';
import 'businessprivateselect.dart';
import 'text_animato.dart';

class HomeScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _headerTextAnimation;
  late final Animation<double> _formElementAnimation;
  late final Animation<double> lineaArancione;
  late final Animation<double> headerScreen;
  late final Animation<double> lineaBlu;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: kLoginAnimationDuration,
    );

    final fadeSlideTween = Tween<double>(begin: 0.0, end: 1.0);
    _headerTextAnimation = fadeSlideTween.animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.0,
        0.6,
        curve: Curves.easeInOut,
      ),
    ));
    _formElementAnimation = fadeSlideTween.animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.7,
        1.0,
        curve: Curves.easeInOut,
      ),
    ));
    final clipperOffsetTween = Tween<double>(
      begin: 350,
      end: 0.0,
    );
    headerScreen = clipperOffsetTween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.2,
          0.7,
          curve: Curves.easeInOut,
        ),
      ),
    );
    lineaBlu = clipperOffsetTween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.35,
          0.7,
          curve: Curves.easeInOut,
        ),
      ),
    );
    lineaArancione = clipperOffsetTween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.5,
          0.7,
          curve: Curves.easeInOut,
        ),
      ),
    );

    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //colore sfondo sotto le linee
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: <Widget>[
          lineaCurvaArancione(),
          lineaCurvaBlu(),
          parteSuperioreScreen(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: kPaddingL),
              child: Column(
                children: <Widget>[
                  Header(animation: _headerTextAnimation),
                  const Spacer(
                    flex: 1,
                  ),
                  TextAnimato(animation: _formElementAnimation),
                  const Divider(
                    color: Colors.transparent,
                  ),
                  BusinessPrivate(animation: _formElementAnimation),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  AnimatedBuilder lineaCurvaArancione() {
    return AnimatedBuilder(
      animation: lineaArancione,
      builder: (_, Widget? child) {
        return ClipPath(
          clipper: LineaArancione(
            yOffset: lineaArancione.value,
          ),
          child: child,
        );
      },
      //linea arancione
      child: Container(color: arancioneAircomm),
    );
  }

  AnimatedBuilder lineaCurvaBlu() {
    return AnimatedBuilder(
      animation: lineaBlu,
      builder: (_, Widget? child) {
        return ClipPath(
          clipper: LineaBlu(
            yOffset: lineaBlu.value,
          ),
          child: child,
        );
      },
      //linea blu
      child: Container(color: bluAircomm),
    );
  }

  AnimatedBuilder parteSuperioreScreen() {
    return AnimatedBuilder(
      animation: headerScreen,
      builder: (_, Widget? child) {
        return ClipPath(
          clipper: HeaderScreen(
            yOffset: headerScreen.value,
          ),
          child: child,
        );
      },
      //colore della parte superiore dello schermo (header)
      child: Container(color: bluAircomm),
    );
  }
}
