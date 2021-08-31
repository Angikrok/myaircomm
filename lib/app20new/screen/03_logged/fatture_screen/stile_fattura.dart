// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:my_aircomm/app20new/controller/http_helper.dart';
import 'package:my_aircomm/app20new/data/dati_utenza.dart';
import 'package:my_aircomm/app20new/data/invoice.dart';
import 'package:my_aircomm/app20new/model/costanti.dart';
import 'package:my_aircomm/app20new/screen/03_logged/fatture_screen/barCodeFattura.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bill_pdf.dart';

class StileFattura extends StatefulWidget {
  StileFattura({
    Key? key,
    required this.datiUtenza,
    required this.datiInvoice,
    required this.helper,
    required this.url,
    required this.title,
    required this.animationController,
    required this.animation,
    required this.isLoading,
  }) : super(key: key);
  final DatiUtenza datiUtenza;
  final List<Invoice> datiInvoice;
  final HttpHelper helper;
  final String url;
  final String title;
  final bool isLoading;

  AnimationController animationController;
  Animation<double> animation;

  @override
  State<StileFattura> createState() => _StileFatturaState();
}

class _StileFatturaState extends State<StileFattura> {
  @override
  Widget build(BuildContext context) {
    bool internet = true;
    double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (context, _) {
        return FadeTransition(
          opacity: widget.animation,
          child: Transform(
            filterQuality: FilterQuality.high,
            origin: Offset(-20, 50),
            transform: Matrix4.translationValues(
                100 * (1.0 - widget.animation.value), 0, 0),
            child: ListView.builder(
              reverse: false,
              shrinkWrap: true,
              itemCount: widget.datiInvoice.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(32),
                          ),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(-5, 6),
                              blurRadius: 5,
                              color: Colors.black.withOpacity(.3),
                            ),
                          ],
                        ),
                        width: width,
                        height: 100,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(38),
                          ),
                          child: Container(
                            color: Colors.blue[900]!,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      logo_Data(index),
                                      colonnaInfoFattura(
                                          context, index, internet),
                                      arancioniBassi(context, index),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Expanded logo_Data(int index) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Positioned(
                  left: -15,
                  top: -20,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                  ),
                ),
                Positioned(
                    left: widget.title == titleNotPayed ? 0 : -2,
                    top: widget.title == titleNotPayed ? 0 : -5,
                    child: widget.title == titleNotPayed
                        ? GestureDetector(
                            onTap: () {
                              _launchURL(index);
                            },
                            child: SvgPicture.asset(
                              'assets/icon/paypal.svg',
                              height: 65,
                            ),
                          )
                        : Image.asset(
                            'assets/icon/logo.png',
                            height: 65,
                          )),
                Positioned(
                  top: 75,
                  left: 10,
                  child: Text(
                    widget.datiInvoice[index].data,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _launchURL(int index) async {
    String url =
        "https://www.paypal.com/cgi-bin/webscr?cmd=_xclick&charset=utf-8&business=info@aircomm.it&item_name=Fattura+Numero+${widget.datiInvoice[index].id_fattura}+&amount=${widget.datiInvoice[index].tot}&currency_code=EUR";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Expanded colonnaInfoFattura(BuildContext context, int index, bool internet) {
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                'ID Fattura : ${widget.datiInvoice[index].id_fattura}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Totale Fattura: ',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${widget.datiInvoice[index].tot} €',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: widget.title == titleNotPayed
                          ? Color(0xFFff0000)
                          : Color(0xFF70e000)),
                ),
              ],
            ),
          ),
          bottoneVediFattura(context, index, internet),
        ],
      ),
    );
  }

  Expanded bottoneVediFattura(BuildContext context, int index, bool internet) {
    return Expanded(
        flex: MediaQuery.of(context).size.width <= 340 ? 2 : 1,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: downloadButton(
              context, widget.datiInvoice[index].id_fattura, internet),
        ));
  }

  Widget downloadButton(BuildContext context, String id, bool internet) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          border: Border.all(
            color: Colors.white,
            width: 0.7,
          )),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: Size(double.infinity, double.infinity),
          primary: Colors.transparent,
        ),
        onPressed: () {
          if (internetChecker(internet)) {
            Navigator.push(
                context,
                PageTransition(
                    child: PdfView(id: id), type: PageTransitionType.fade));
          } else {
            Fluttertoast.showToast(
                timeInSecForIosWeb: 2,
                msg: 'Nessuna connessione a internet',
                backgroundColor: Colors.red);
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.remove_red_eye, color: Colors.white, size: 15),
            const SizedBox(width: 4),
            Center(
              child: Text(
                "Vedi fattura",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool internetChecker(bool internet) {
    InternetConnectionChecker().onStatusChange.listen((event) {
      //hasInternet è un bool che serve a capire lo status della connessione. vero connessione ok falso non connesso
      final hasInternet = event == InternetConnectionStatus.connected;

      internet = true;
      setState(() {});

      //se è connesso procedi ai test successivi se no torna errore
      if (hasInternet) {
        print('cellulare online: passo alla fase successiva');

        internet = true;
        setState(() {});
      } else {
        internet = false;
        setState(() {});
      }
    });
    return internet;
  }

  Expanded arancioniBassi(BuildContext context, int index) {
    return Expanded(
      flex: 1,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Positioned(
            right: -30,
            top: 35,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.orange,
            ),
          ),
          Positioned(
            right: -30,
            top: 40,
            child: CircleAvatar(
              radius: 45,
              backgroundColor: arancioneAircomm,
            ),
          ),
          Positioned(
              right: 2,
              top: 45,
              child: widget.title == titleNotPayed
                  ? IconButton(
                      icon: SvgPicture.asset(
                        'assets/icon/barcode.svg',
                        height: 35,
                      ),
                      onPressed: () {
                        SystemChrome.setPreferredOrientations([
                          DeviceOrientation.landscapeLeft,
                          //DeviceOrientation.landscapeRight,
                        ]);
                        Navigator.push(
                          context,
                          PageTransition(
                              child: BarCodeFattura(
                                  data: widget.datiInvoice[index].barCode),
                              type: PageTransitionType.bottomToTop),
                        );
                      },
                    )
                  : Container()),
        ],
      ),
    );
  }
}
