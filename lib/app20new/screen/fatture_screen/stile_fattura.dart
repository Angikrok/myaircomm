// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:my_aircomm/app20new/controller/http_helper.dart';
import 'package:my_aircomm/app20new/data/dati_utenza.dart';
import 'package:my_aircomm/app20new/data/invoice.dart';
import 'package:my_aircomm/app20new/model/costanti.dart';
import 'package:my_aircomm/app20new/screen/03_logged/bill_pdf.dart';
import 'package:my_aircomm/app20new/screen/fatture_screen/fatture_screen.dart';
import 'package:page_transition/page_transition.dart';

class StileFattura extends StatefulWidget {
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
  State<StileFattura> createState() => _StileFatturaState();
}

class _StileFatturaState extends State<StileFattura> {
  @override
  Widget build(BuildContext context) {
    Theme.of(context).backgroundColor;
    double width = MediaQuery.of(context).size.width;
    print(width.toStringAsFixed(20));
    // double height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (context, _) {
        return FadeTransition(
          opacity: widget.animation,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - widget.animation.value), 0, 0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.datiInvoice.length,
              itemBuilder: (context, index) {
                return Column(
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
                                id: widget.datiInvoice[index].id_fattura,
                              ),
                              type: PageTransitionType.fade,
                            ),
                          );
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
                                        colonnaInfoFattura(context, index),
                                        arancioniBassi(context),
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
                      color: widget.title == 'Fatture da pagare'
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
        flex: MediaQuery.of(context).size.width <= 340 ? 2 : 1,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: downloadButton(context, widget.datiInvoice[index].id_fattura),
        ));
  }

  Expanded arancioniBassi(
    BuildContext context,
  ) {
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
            right: -5,
            top: 45,
            child: ElevatedButton(
              child: Icon(
                Icons.bar_chart_sharp,
                color: kWhite,
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.transparent, elevation: 0),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(50),
                    ),
                  ),
                  builder: (context) => Container(
                    height: 500,
                    child: Column(
                      children: [
                        SizedBox(
                          child: Icon(Icons.read_more),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
