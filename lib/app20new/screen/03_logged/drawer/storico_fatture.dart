// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_aircomm/app20new/data/dati_utenza.dart';
import '/app20new/controller/http_helper.dart';
import '../../../data/invoice.dart';
import '../fatture_screen.dart';

class StoricoFatture extends StatefulWidget {
  StoricoFatture({
    Key? key,
    required this.cC,
    required this.a,
    required this.datiUtenza,
  }) : super(key: key);
  final String cC;
  final String a;
  DatiUtenza datiUtenza;

  @override
  _StoricoFattureState createState() => _StoricoFattureState();
}

class _StoricoFattureState extends State<StoricoFatture> {
  HttpHelper helper = HttpHelper();
  List<Invoice> datiInvoice = [];
  DateTime? backButtonPressedTime;
  @override
  void initState() {
    helper
        .storicoFatture(
      widget.cC,
      widget.a,
    )
        .then((List<Invoice> value) {
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
          onWillPop: onWillPop,
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
              datiUtenza: widget.datiUtenza,
              datiInvoice: datiInvoice,
              title: 'Elenco fatture pagate',
              helper: helper,
              url: 'http://core.aircommservizi.it/admin/a/pdf.php?id=',
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> onWillPop() async {
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
