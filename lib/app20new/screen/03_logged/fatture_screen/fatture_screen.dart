// FattureScreen è il contenitore per tutta l'intera pagina:
// contiene:
// menù
// elenco fatture
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_aircomm/costanti.dart';
import 'package:my_aircomm/app20new/screen/03_logged/fatture_screen/elenco_fatture.dart';
import '/app20new/controller/http_helper.dart';
import '/app20new/data/dati_utenza.dart';

class FattureScreen extends StatefulWidget {
  FattureScreen({
    required this.datiUtenza,
    required this.cc,
    required this.isLoading,
    Key? key,
  }) : super(key: key);
  DatiUtenza datiUtenza;

  final String cc;
  final bool isLoading;

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
    return Scaffold(
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Container(
          child: ElencoFatture(
            isLoading: widget.isLoading,
            cC: widget.cc,
            selectYear: Container(),
            datiUtenza: widget.datiUtenza,
            title: titleNotPayed,
            datiInvoice: widget.datiUtenza.invoice,
            helper: helper,
            url: url,
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
          backgroundColor: arancioneAircomm,
          textColor: Colors.white);
      return false;
    }
    SystemNavigator.pop();
    return true;
  }
}
