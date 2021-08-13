import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../model/costanti.dart';
import '../../model/button.dart';
import '../../controller/http_helper.dart';
import '../02_login/login_aziendale.dart';
import '../02_login/login_privato.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  int spazioIniziale = 1;
  int logoMyAircomm = 1;
  int scrittaMyAircomm = 1;
  int animazioneCaricamento = 1;
  int messaggioDiErrore = 2;
  int spazioFinale = 1;
  String textMessage = "";
  bool isError = false;
  bool internet = false;
  DateTime? backButtonPressedTime;

  @override
  void initState() {
    statusChecker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double fontsize32 = width/;
    return Scaffold(
      body: WillPopScope(
        onWillPop: doubleTapCloseApp,
        child: Container(
          //sfondo pagina
          decoration: sfondoPagina(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //spaziatura iniziale
              spaziaturaWdg(spazioIniziale),
              //logo aircomm
              logoAircommWdg(logoMyAircomm),
              //scritta my aircomm
              scrittaMyAircommWdg(32, scrittaMyAircomm),
              //animazione caricamento
              textMessage != 'Scegli il profilo:'
                  ? animazioneCaricamentoWdg(animazioneCaricamento, width)
                  : Container(),
              //messaggio errore con pulsante riprova

              graphicErrorMsgWithButtonWdg(17, messaggioDiErrore),
              if (textMessage == 'Scegli il profilo:')
                selectionBusinssPrivateWdg(17, messaggioDiErrore),

              //spazio finale
              spaziaturaWdg(spazioFinale),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration sfondoPagina() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.white,
          Colors.grey[100]!,
          Colors.grey[350]!,
        ],
        transform: GradientRotation(-45),
      ),
    );
  }

  Expanded spaziaturaWdg(int spazio) {
    return Expanded(
      flex: spazio,
      child: Container(),
    );
  }

  Expanded animazioneCaricamentoWdg(int spazio, double width) {
    return Expanded(
      flex: spazio,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 3,
            child: Container(),
          ),
          //animazione caricamento

          Container(
            width: width / 10,
            child: CircularProgressIndicator.adaptive(
              backgroundColor: Costanti.bluAircomm,
              valueColor:
                  AlwaysStoppedAnimation<Color>(Costanti.arancioneAircomm),
              strokeWidth: 2,
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(),
          ),
        ],
      ),
    );
  }

  Expanded scrittaMyAircommWdg(double fontSize32, int spazio) {
    //scritta my aircomm
    return Expanded(
      flex: spazio,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //scritta my aircomm
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 2,
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'My Aircomm',
                  textAlign: TextAlign.end,
                  cursor: "",
                  textStyle: TextStyle(
                      color: Costanti.bluAircomm,
                      fontSize: fontSize32,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Coco"),
                  speed: const Duration(milliseconds: 150),
                ),
              ],
              isRepeatingAnimation: false,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
            // AnimatedTextKit(
            //     animatedTexts: [
            //       TypewriterAnimatedText(
            //         'Aircomm',
            //         cursor: "",
            //         textStyle: TextStyle(
            //             color: Costanti.bluAircomm,
            //             fontSize: fontSize32,
            //             fontWeight: FontWeight.bold,
            //             fontFamily: "Coco"),
            //         speed: const Duration(milliseconds: 150),
            //       ),
            //     ],
            //     pause: Duration(milliseconds: 100),
            //     //repeatForever: true,
            //     isRepeatingAnimation: false,
            //   ),
          ),
        ],
      ),
    );
  }

  Expanded logoAircommWdg(int spazio) {
    //LogoAircomm
    return Expanded(
      flex: spazio,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: Container(),
          ),
          //iconea my aircomm
          Expanded(
            flex: 5,
            //child: SvgPicture.asset('assets/icon/download.svg'),
            child: Image.asset('assets/icon/only_logo.png'),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
        ],
      ),
    );
  }

  Expanded graphicErrorMsgWithButtonWdg(double fontSize17, int spazio) {
    //messaggio errore con pulsante riprova
    return Expanded(
      flex: spazio,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                //messaggio d'errore
                Expanded(
                  flex: 5,
                  child: Center(
                    child: Text(
                      textMessage,
                      style: TextStyle(
                          fontFamily: "CocoItalic",
                          fontSize: fontSize17,
                          color: isError || internet
                              ? Colors.red
                              : Costanti.bluAircomm),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        //pulsante riprova
                        Expanded(
                          flex: 2,
                          child: isError
                              ? Container(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Costanti.bluAircomm,
                                          Costanti.bluAircomm.withOpacity(.4)
                                        ],
                                        transform: GradientRotation(-45),
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(24),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 1,
                                            color: Colors.white,
                                            offset: Offset(0, 3),
                                            blurRadius: 30)
                                      ]),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(
                                          double.infinity, double.infinity),
                                      primary: Colors.transparent,
                                      elevation: 0,
                                    ),
                                    child: Text(
                                      'Riprova',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17),
                                    ),
                                    onPressed: () {
                                      statusChecker2();
                                    },
                                  ),
                                )
                              : Container(),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded selectionBusinssPrivateWdg(double fontSize17, int spazio) {
    //messaggio errore con pulsante riprova
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Container(),
          ),
          Button(txt: 'Privato', child: Privato()),
          Expanded(
            child: Container(),
          ),
          Button(txt: 'Aziendale', child: Aziendale()),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

  statusChecker() {
    InternetConnectionChecker().onStatusChange.listen((event) {
      //hasInternet è un bool che serve a capire lo status della connessione. vero connessione ok falso non connesso
      final hasInternet = event == InternetConnectionStatus.connected;
      setState(() {
        internet = false;

        textMessage = 'verifica connettività';
      });
      //se è connesso procedi ai test successivi se no torna errore
      if (hasInternet) {
        print('cellulare online: passo alla fase successiva');
        internet = false;
        setState(() {
          textMessage = 'verifica server';
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
          textMessage = 'verifica servizi';
        });
        helper.serviceStatus().then((value) {
          if (value) {
            print('servizio online: passo alla fase successiva');
            isError = false;
            setState(() {
              textMessage = 'Scegli il profilo:';
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

  Future<bool> doubleTapCloseApp() async {
    DateTime currentTime = DateTime.now();
    bool backButton;
    backButton = backButtonPressedTime == null ||
        currentTime.difference(backButtonPressedTime!) > Duration(seconds: 2);
    if (backButton) {
      backButtonPressedTime = currentTime;
      Fluttertoast.showToast(
        msg: "Clicca di nuovo per chiudere l'app",
        backgroundColor: Colors.black45,
        textColor: Colors.white,
      );
      return false;
    }
    SystemNavigator.pop();
    return true;
  }
}
