// FattureScreen è il contenitore per tutta l'intera pagina:
// contiene:
// menù
// elenco fatture
// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:my_aircomm/app20new/model/alerts.dart';
import 'package:my_aircomm/app20new/model/costanti.dart';
import 'package:page_transition/page_transition.dart';
import 'bill_pdf.dart';
import '../../data/invoice.dart';
import '/app20new/controller/http_helper.dart';
import '/app20new/data/dati_utenza.dart';
import 'drawer/elementi_menu.dart';
import 'dart:math' as math;

class FattureScreen extends StatefulWidget {
  FattureScreen({
    required this.datiUtenza,
    Key? key,
  }) : super(key: key);
  DatiUtenza datiUtenza;

  @override
  State<FattureScreen> createState() => _FattureScreenState();
}

class _FattureScreenState extends State<FattureScreen> {
  HttpHelper helper = HttpHelper();
  @override
  void initState() {
    super.initState();
  }

  String url = 'http://core.aircommservizi.it/admin/a/pdf.php?id=';
  DateTime? backButtonPressedTime;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () {
            return onWillPop(backButtonPressedTime);
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0096c7),
                  Color(0xFF023e8a),
                ],
              ),
            ),
            child: ElencoFatture(
              selectYear: Container(),
              datiUtenza: widget.datiUtenza,
              title: 'Fatture da pagare',
              datiInvoice: widget.datiUtenza.not_payed_invoice,
              helper: helper,
              url: url,
            ),
          ),
        ),
      ),
    );
  }
}

class ElencoFatture extends StatelessWidget {
  ElencoFatture({
    Key? key,
    required this.datiInvoice,
    required this.datiUtenza,
    required this.helper,
    required this.url,
    required this.title,
    required this.selectYear,
  }) : super(key: key);

  Widget selectYear;

  final List<Invoice> datiInvoice;
  final DatiUtenza datiUtenza;
  final HttpHelper helper;
  final String url;
  final String title;
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _globalKey,
      drawer: ElementiMenu(
        width: width,
        height: height,
        datiUtenza: datiUtenza,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF40b6c7),
              Color(0xFF023e8a),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 5,
              right: -120,
              child: CircleAvatar(
                radius: 120,
                backgroundColor: Color(0xFF023e8a),
              ),
            ),
            Positioned(
              top: 2,
              left: -150,
              child: CircleAvatar(
                radius: 135,
                backgroundColor: Color(0xFF40b6c7),
              ),
            ),
            Positioned(
              top: 50,
              right: -115,
              child: CircleAvatar(
                radius: 120,
                backgroundColor: Color(0xFF0096c7),
              ),
            ),
            Positioned(
              top: 25,
              child: IconButton(
                icon: Icon(
                  Icons.menu,
                  size: 32,
                  color: Colors.white,
                ),
                onPressed: () {
                  _globalKey.currentState!.openDrawer();
                },
              ),
            ),
            selectYear,
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 25),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            title,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'Coco',
                              fontSize: 19,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                FattureNonPagate(
                  title: title,
                  datiInvoice: datiInvoice,
                  datiUtenza: datiUtenza,
                  helper: helper,
                  url: url,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FattureNonPagate extends StatefulWidget {
  FattureNonPagate({
    Key? key,
    required this.datiUtenza,
    required this.datiInvoice,
    required this.helper,
    required this.url,
    required this.title,
  }) : super(key: key);
  final DatiUtenza datiUtenza;
  final List<Invoice> datiInvoice;
  final HttpHelper helper;
  final String title;
  final String url;

  @override
  State<FattureNonPagate> createState() => _FattureNonPagateState();
}

class _FattureNonPagateState extends State<FattureNonPagate>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: (Duration(milliseconds: 1250)),
    );
    animationController.forward();
  }

  void dispose() {
    if (animationController.isCompleted == false) {
      animationController.stop();
    } else {
      animationController.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          (1 / 9) * 2,
          1.0,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              18,
            ),
            topRight: Radius.circular(
              18,
            ),
          ),
          color: Colors.grey[200],
        ),
        child: Stack(
          children: [
            cerchioGrandeDestra(context),
            cerchioPiccoloDestra(context),
            cerchioSinistra(context),
            widget.datiInvoice.isEmpty
                ? nienteDaVederetxt()
                : Column(
                    children: [
                      Expanded(
                        child: StileFattura(
                          animation: animation,
                          animationController: animationController,
                          title: widget.title,
                          datiUtenza: widget.datiUtenza,
                          datiInvoice: widget.datiInvoice,
                          helper: widget.helper,
                          url: widget.url,
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Positioned cerchioGrandeDestra(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height / 3.2,
      left: MediaQuery.of(context).size.width / 5,
      child: CircleAvatar(
        radius: 350,
        backgroundColor: Color(0xFF023e8a).withOpacity(
          .4,
        ),
      ),
    );
  }

  Positioned cerchioPiccoloDestra(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height / 2.5,
      left: MediaQuery.of(context).size.width / 4,
      child: CircleAvatar(
        radius: 250,
        backgroundColor: Color(0xFF0096c7).withOpacity(
          .4,
        ),
      ),
    );
  }

  Positioned cerchioSinistra(BuildContext context) {
    return Positioned(
      top: 35,
      right: MediaQuery.of(context).size.width / 1.4,
      child: CircleAvatar(
        radius: 150,
        backgroundColor: Colors.white.withOpacity(
          .3,
        ),
      ),
    );
  }

  nienteDaVederetxt() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Icon(
            Icons.visibility_off_sharp,
            size: 132,
            color: Colors.black.withOpacity(.2),
          ),
        ),
        Center(
          child: Text(
            'Niente da visualizzare',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Colors.black.withOpacity(.5),
            ),
          ),
        ),
      ],
    );
  }
}

class StileFattura extends StatelessWidget {
  StileFattura(
      {Key? key,
      required this.datiUtenza,
      required this.datiInvoice,
      required this.helper,
      required this.url,
      required this.title,
      required this.animationController,
      required this.animation})
      : super(key: key);
  final DatiUtenza datiUtenza;
  final List<Invoice> datiInvoice;
  final HttpHelper helper;
  final String url;
  final String title;
  AnimationController animationController;
  Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform:
                Matrix4.translationValues(100 * (1.0 - animation.value), 0, 0),
            child: Stack(
              children: [
                ListView.builder(
                  itemCount: datiInvoice.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: PdfView(
                                          id: datiInvoice[index].id_fattura,
                                        ),
                                        type: PageTransitionType.fade));
                              },
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
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(40)),
                                  child: Container(
                                    color: Colors.blue[900],
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              logo_Data(index),
                                              colonnaInfoFattura(context, index),
                                              arancioniBassi(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
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
                  left: -5,
                  top: -5,
                  child: Image.asset(
                    'assets/icon/logo.png',
                    height: 65,
                  ),
                ),
                Positioned(
                  top: 75,
                  left: 10,
                  child: Text(
                    datiInvoice[index].data,
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

  Expanded colonnaInfoFattura(BuildContext context, int index) {
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                'ID Fattura : ${datiInvoice[index].id_fattura}',
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
                  '${datiInvoice[index].tot} €',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: title == 'Fatture da pagare'
                          ? Color(0xFFff0000)
                          : Color(0xFF70e000)),
                ),
              ],
            ),
          ),
          bottoneVediFattura(context, index),
        ],
      ),
    );
  }

  Expanded bottoneVediFattura(BuildContext context, int index) {
    return Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: downloadButton(context, datiInvoice[index].id_fattura),
        ));
  }

  Expanded arancioniBassi() {
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
              backgroundColor: Costanti.arancioneAircomm,
            ),
          ),
        ],
      ),
    );
  }
}

Container downloadButton(BuildContext context, String id) {
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
        Navigator.push(
            context,
            PageTransition(
                child: PdfView(id: id), type: PageTransitionType.fade));
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
