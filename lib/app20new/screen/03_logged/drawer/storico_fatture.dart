// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_aircomm/app20new/data/dati_utenza.dart';
import 'package:my_aircomm/app20new/model/alerts.dart';
import 'package:my_aircomm/app20new/screen/fatture_screen/elenco_fatture.dart';
import 'package:page_transition/page_transition.dart';
import '/app20new/controller/http_helper.dart';
import '../../../data/invoice.dart';


class StoricoFatture extends StatefulWidget {
  StoricoFatture({
    Key? key,
    required this.cC,
    required this.a,
    required this.datiUtenza,
  }) : super(key: key);
  final String cC;
  String a;
  DatiUtenza datiUtenza;
  static int id = 0;

  @override
  _StoricoFattureState createState() => _StoricoFattureState();
}

class _StoricoFattureState extends State<StoricoFatture> {
  HttpHelper helper = HttpHelper();
  List<Invoice> datiInvoice = [];
  List<String> list = [
    'Anno',
  ];
  DateTime? backButtonPressedTime;
  @override
  void initState() {
    for (int i = DateTime.now().year; i >= DateTime.now().year - 2; i--) {
      list.add(i.toString());
    }
    helper.storicoFatture(widget.cC, widget.a).then((List<Invoice> value) {
      datiInvoice = value;
      setState(() {});
    });
    super.initState();
  }

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
              selectYear: selectYear(context),
              datiUtenza: widget.datiUtenza,
              datiInvoice: datiInvoice,
              title: 'Fatture pagate',
              helper: helper,
              url: 'http://core.aircommservizi.it/admin/a/pdf.php?id=',
            ),
          ),
        ),
      ),
    );
  }

  Positioned selectYear(BuildContext context) {
    return Positioned(
      top: 25,
      left: MediaQuery.of(context).size.width / 1.28,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            color: Colors.transparent),
        width: MediaQuery.of(context).size.width / 5,
        child: DropdownButton<String>(
          isExpanded: true,
          borderRadius: BorderRadius.all(
            Radius.circular(24),
          ),
          underline: Text(
            '',
          ),
          icon: Container(),
          value: widget.a,
          style: TextStyle(color: Colors.white),
          dropdownColor: Color(0xFF0096c7),
          items: list.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Center(
                child: Text(
                  value,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }).toList(),
          onChanged: (valore) {
            widget.a = valore!;
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: StoricoFatture(
                      cC: widget.cC,
                      a: widget.a,
                      datiUtenza: widget.datiUtenza,
                    ),
                    type: PageTransitionType.fade,
                    duration: Duration(milliseconds: 1)));
          },
        ),
      ),
    );
  }
}
