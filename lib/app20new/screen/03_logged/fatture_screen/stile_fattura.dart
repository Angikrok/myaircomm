import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:my_aircomm/app20new/controller/http_helper.dart';
import 'package:my_aircomm/app20new/data/dati_utenza.dart';
import 'package:my_aircomm/app20new/data/invoice.dart';
import 'package:my_aircomm/app20new/screen/03_logged/fatture_screen/barCodeFattura.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../costanti.dart';
import '../bill_pdf.dart';
import 'bonificoInfo.dart';

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
                    child: Image.asset(
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

  Widget colonnaInfoFattura(BuildContext context, int index, bool internet) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              'ID Fattura : ${widget.datiInvoice[index].id_fattura}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Totale Fattura: ',
              style: TextStyle(
                fontSize: 1,
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
        bottoneVediFattura(context, index, internet),
      ],
    );
  }

  Widget bottoneVediFattura(BuildContext context, int index, bool internet) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: downloadButton(
          context, widget.datiInvoice[index].id_fattura, internet, index),
    );
  }

  Widget downloadButton(
      BuildContext context, String id, bool internet, int index) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(14),
          ),
          border: Border.all(
            color: Colors.white,
            width: 0.7,
          )),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: Colors.transparent,
        ),
        onPressed: () {
          widget.title == titleNotPayed
              ? showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  elevation: 100,
                  context: context,
                  builder: (context) {
                    return ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white),
                        child: ListView(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  'Paga Con',
                                  style: TextStyle(
                                      fontFamily: 'Coco', fontSize: 24),
                                ),
                              ),
                            ),
                            bottonePayPal(context, index),
                            bottoneBarCode(context, index),
                            bottoneBonifico(context, index,
                                tot: widget.datiInvoice[index].tot,
                                id: widget.datiInvoice[index].id_fattura),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  'Oppure',
                                  style: TextStyle(
                                      fontFamily: 'Coco', fontSize: 24),
                                ),
                              ),
                            ),
                            bottoneVedi(context, index),
                          ],
                        ),
                      ),
                    );
                  })
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PdfView(id: widget.datiInvoice[index].id_fattura)));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
                widget.title == titlePayed
                    ? Icons.remove_red_eye
                    : Icons.payments,
                color: Colors.white,
                size: 15),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  widget.title == titlePayed
                      ? 'Visualizza Fattura'
                      : "Paga Fattura",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: widget.title == titlePayed ? 11.5 : 12.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Center bottoneVedi(BuildContext context, int index) {
    return Center(
        child: Container(
      margin: EdgeInsets.only(top: 4),
      width: MediaQuery.of(context).size.width / 1.5,
      decoration: BoxDecoration(
        color: bluAircomm,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PdfView(id: widget.datiInvoice[index].id_fattura)));
        },
        style:
            ElevatedButton.styleFrom(elevation: 0, primary: Colors.transparent),
        child: Center(
            child: ListTile(
                title: Text(
                  'Visualizza Fattura',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Coco',
                  ),
                ),
                leading: Icon(
                  Icons.remove_red_eye,
                  color: Colors.white,
                ))),
      ),
    ));
  }

  Center bottonePayPal(BuildContext context, int index) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        // width: 110,
        decoration: BoxDecoration(
          color: Color(0xFFffc439),
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: ElevatedButton(
          onPressed: () {
            _launchURL(index);
          },
          style: ElevatedButton.styleFrom(
              elevation: 0, primary: Colors.transparent),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 4),
              child: Image.asset(
                'assets/icon/paypal.png',
                height: 32,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Center bottoneBonifico(BuildContext context, int index,
      {required String tot, required String id}) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 24),
        width: MediaQuery.of(context).size.width / 1.5,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(.85),
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    child: BonificoInfo(
                      cC: '',
                      datiUtenza: widget.datiUtenza,
                      tot: tot,
                      id: id,
                    ),
                    type: PageTransitionType.fade));
          },
          style: ElevatedButton.styleFrom(
              elevation: 0, primary: Colors.transparent),
          child: Center(
            child: ListTile(
                title: Text(
                  'Effettua un bonifico',
                  style: TextStyle(color: Colors.white, fontSize: 14.5),
                ),
                leading: SvgPicture.asset(
                  'assets/icon/bank.svg',
                  height: 28,
                  color: Colors.white,
                )),
          ),
        ),
      ),
    );
  }

  Center bottoneBarCode(BuildContext context, int index) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 24),
        width: MediaQuery.of(context).size.width / 1.5,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: ElevatedButton(
          onPressed: () {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.landscapeLeft,
              //DeviceOrientation.portraitDown,
            ]);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BarCodeFattura(
                        data: widget.datiInvoice[index].barCode)));
          },
          style: ElevatedButton.styleFrom(
              elevation: 0, primary: Colors.transparent),
          child: Center(
              child: ListTile(
            title: Text('Scannerizza BarCode'),
            leading: SvgPicture.asset(
              'assets/icon/barcode.svg',
              height: 32,
            ),
          )),
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

  Widget arancioniBassi(BuildContext context, int index) {
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
        ],
      ),
    );
  }
}
