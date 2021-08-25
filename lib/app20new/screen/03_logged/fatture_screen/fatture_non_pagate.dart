import 'package:flutter/material.dart';
import 'package:my_aircomm/app20new/controller/http_helper.dart';
import 'package:my_aircomm/app20new/data/dati_utenza.dart';
import 'package:my_aircomm/app20new/data/invoice.dart';

import 'stile_fattura.dart';

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
        backgroundColor: Colors.grey.withOpacity(
          .17,
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
