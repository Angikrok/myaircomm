import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:my_aircomm/app20new/controller/http_helper.dart';
import 'package:my_aircomm/app20new/data/dati_utenza.dart';
import 'package:my_aircomm/app20new/data/invoice.dart';
import 'package:my_aircomm/app20new/model/costanti.dart';

import 'stile_fattura.dart';

class FattureNonPagate extends StatefulWidget {
  FattureNonPagate({
    Key? key,
    required this.datiUtenza,
    required this.datiInvoice,
    required this.helper,
    required this.url,
    required this.title,
    required this.isLoading,
  }) : super(key: key);
  final DatiUtenza datiUtenza;
  final List<Invoice> datiInvoice;
  final HttpHelper helper;
  final String title;
  final String url;
  final bool isLoading;

  @override
  State<FattureNonPagate> createState() => _FattureNonPagateState();
}

class _FattureNonPagateState extends State<FattureNonPagate>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  late Future docs;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: (Duration(milliseconds: 1250)),
    );
    animationController.forward();
    docs = getDoctors();
  }

  void dispose() {
    if (animationController.isCompleted == false) {
      animationController.stop();
    } else {
      animationController.dispose();
    }

    super.dispose();
  }

  bool internet = true;

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    return Expanded(
      child: FutureBuilder(
          future: docs,
          builder: (BuildContext context, snapshot) {
            print('Errore $snapshot');
            return Container(
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
                  if (snapshot.connectionState == ConnectionState.none ||
                      snapshot.connectionState == ConnectionState.none)
                    noInternetWidget(context)

                  //Caricamento Fattura
                  else if (widget.isLoading == false)
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                          color: Colors.white.withOpacity(.8)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset('assets/icon/loadingList.json'),
                        ],
                      ),
                    )
                  else if (widget.datiInvoice.isEmpty)

                    //Lista vuota
                    nienteDaVederetxt()
                  else
                    //Lista piena
                    Column(
                      children: [
                        Expanded(
                          child: StileFattura(
                            isLoading: widget.isLoading,
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
            );
          }),
    );
  }

  Future getDoctors() async {
    Uri url = Uri.http('core.aircommservizi.it', '');
    var res = await get(url);

    print(res.statusCode);

    if (res.statusCode == 200) {
      internet = true;
      setState(() {});
      if (mounted) {
        setState(() {});
      }
    } else {
      internet = false;
      setState(() {});
    }
  }

  Column noInternetWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Lottie.asset(
            'assets/icon/noInternet.json',
            height: 225,
            repeat: false,
          )),
        ),
        Center(
          child: Text(
            'Nessuna Connessione ad Intenet',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Colors.black.withOpacity(.5),
            ),
          ),
        ),
        Container(
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
              setState(() {});
            },
          ),
        )
      ],
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
        backgroundColor: Colors.grey.withOpacity(
          .17,
        ),
      ),
    );
  }

  nienteDaVederetxt() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Lottie.asset(
            'assets/icon/emptyList.json',
            height: 225,
            repeat: false,
          )),
        ),
        Center(
          child: Text(
            widget.title == titleNotPayed
                ? 'Non risultano fatture da pagare'
                : 'Non risultano fatture pagate',
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

  noInternet() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Lottie.asset(
            'assets/icon/noInternet.json',
            height: 225,
            repeat: false,
          )),
        ),
        Center(
          child: Text(
            'Nessuna Connessione a Internet',
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
