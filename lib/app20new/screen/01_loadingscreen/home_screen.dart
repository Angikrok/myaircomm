import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:my_aircomm/app20new/screen/02_login/login_aziendale.dart';
import 'package:my_aircomm/app20new/screen/02_login/login_privato.dart';
import '/app20new/controller/http_helper.dart';
import '../../../costanti.dart';
import '/app20new/model/custom_clippers/header_screen.dart';
import '/app20new/model/custom_clippers/linea_arancione.dart';
import '/app20new/model/custom_clippers/linea_blu.dart';
import 'animation.dart';
import 'header.dart';

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
  String textMessage = "Seleziona Profilo:";
  bool isError = false;
  bool internet = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
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
    statusChecker();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double space = height > 650 ? 16 : 8;
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
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Column(
                children: <Widget>[
                  Header(animation: _headerTextAnimation),
                  const Spacer(
                    flex: 1,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: AppBar().preferredSize.height + 10),
                    child: textAnimato(_formElementAnimation),
                  ),
                  const Divider(
                    color: Colors.transparent,
                  ),
                  if (textMessage == 'Nessuna connessione ad internet')
                    Container()
                  else if (textMessage == 'Servizio Offline' ||
                      textMessage == 'Server Offline')
                    bottoneRiprova(context)
                  else
                    textMessage == 'Verifica Server...'
                        ? Container()
                        : privateBusinessSelection(
                            space, context, _formElementAnimation),
                  Spacer(
                    flex: 1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container bottoneRiprova(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      margin: EdgeInsets.all(12),
      height: 50,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            bluAircomm,
            bluAircomm,
          ],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, double.infinity),
            primary: Colors.transparent,
            elevation: 0),
        child: Text('Riprova'),
        onPressed: () {
          statusChecker2();
          setState(() {});
        },
      ),
    );
  }

  FadeSlideTransition textAnimato(Animation<double> animation) {
    return FadeSlideTransition(
      additionalOffset: 0.0,
      animation: animation,
      child: Text(
        textMessage,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  Expanded privateBusinessSelection(
      double space, BuildContext context, Animation<double> animation) {
    return Expanded(
      flex: 1,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(),
          ),
          tastoPrivato(animation, context, space),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          tastoAziendale(animation, space, context),
          Expanded(
            flex: 1,
            child: Container(),
          ),
        ],
      ),
    );
  }

  Expanded tastoAziendale(
      Animation<double> animation, double space, BuildContext context) {
    return Expanded(
      flex: 3,
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
                    child: SvgPicture.asset(
                      'assets/icon/factory4.svg',
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
              padding: EdgeInsets.all(2.0),
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
    );
  }

  Expanded tastoPrivato(
      Animation<double> animation, BuildContext context, double space) {
    return Expanded(
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
              padding: EdgeInsets.all(2.0),
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

  statusChecker() {
    InternetConnectionChecker().onStatusChange.listen((event) {
      //hasInternet è un bool che serve a capire lo status della connessione. vero connessione ok falso non connesso
      final hasInternet = event == InternetConnectionStatus.connected;
      setState(() {
        internet = false;

        textMessage = 'Verifica Connettività...';
      });
      //se è connesso procedi ai test successivi se no torna errore
      if (hasInternet) {
        print('cellulare online: passo alla fase successiva');
        internet = false;
        setState(() {
          textMessage = 'Verifica Server...';
        });
        statusChecker2();
      } else {
        internet = true;
        setState(() {
          textMessage = 'Nessuna connessione ad internet';
        });
      }
    });
  }

  statusChecker2() {
    HttpHelper helper = HttpHelper();
    helper.check().then((value) {
      if (value) {
        print('server online: passo alla fase successiva');
        isError = false;
        setState(() {
          textMessage = 'Verifica Servizi...';
        });
        helper.serviceStatus().then((value) {
          if (value) {
            print('servizio online: passo alla fase successiva');
            isError = false;
            setState(() {
              textMessage = 'Seleziona Profilo:';
            });
          } else {
            print('servizio offline mostro errore');
            isError = true;
            setState(() {
              textMessage = 'Servizio Offline';
            });
          }
        });
      } else {
        print('server offline mostro errore');
        isError = true;
        setState(() {
          textMessage = 'Server Offline';
        });
      }
    });
  }
}
