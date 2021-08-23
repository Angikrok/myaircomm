import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../model/costanti.dart';
import '../../model/button.dart';
import '../02_login/login_aziendale.dart';
import '../02_login/login_privato.dart';

class LoadingScreenFasullo extends StatefulWidget {
  const LoadingScreenFasullo({Key? key}) : super(key: key);

  @override
  _LoadingScreenFasulloState createState() => _LoadingScreenFasulloState();
}

class _LoadingScreenFasulloState extends State<LoadingScreenFasullo> {
  int spazioIniziale = 1;
  int logoMyAircomm = 1;
  int scrittaMyAircomm = 1;
  int animazioneCaricamento = 1;
  int messaggioDiErrore = 2;
  int spazioFinale = 1;
  DateTime? backButtonPressedTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: doubleTapCloseApp,
      child: Scaffold(
        body: Container(
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

              Container(),

              graphicErrorMsgWithButtonWdg(17, messaggioDiErrore),

              selectionBusinssPrivateWdg(17, messaggioDiErrore),

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
              backgroundColor: bluAircomm,
              valueColor:
                  AlwaysStoppedAnimation<Color>(arancioneAircomm),
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
                      color: bluAircomm,
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
                      'Scegli il profilo:',
                      style: TextStyle(
                          fontFamily: "CocoItalic",
                          fontSize: fontSize17,
                          color: bluAircomm),
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
                          child: Container(),
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
