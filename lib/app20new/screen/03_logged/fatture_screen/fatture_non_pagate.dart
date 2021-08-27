import 'package:flutter/material.dart';
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
        curve: Curves.fastOutSlowIn,
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
            if (widget.isLoading == false)
              Container(
                color: Colors.black.withOpacity(.3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.network(
                      'https://assets8.lottiefiles.com/private_files/lf30_63CXnL.json',
                    ),
                  ],
                ),
              )
            else if (widget.datiInvoice.isEmpty)
              nienteDaVederetxt()
            else
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
              child: Image.asset(
            'assets/icon/empty.png',
            height: 195,
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
}
