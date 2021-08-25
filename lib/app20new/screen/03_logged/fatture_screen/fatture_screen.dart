// FattureScreen è il contenitore per tutta l'intera pagina:
// contiene:
// menù
// elenco fatture
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_aircomm/app20new/model/costanti.dart';
import 'package:my_aircomm/app20new/screen/03_logged/fatture_screen/elenco_fatture.dart';
import 'package:page_transition/page_transition.dart';
import '../bill_pdf.dart';
import '/app20new/controller/http_helper.dart';
import '/app20new/data/dati_utenza.dart';

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
              
              selectYear: Container(),
              datiUtenza: widget.datiUtenza,
              title: 'Fatture da pagare',
              datiInvoice: widget.datiUtenza.invoice,
              helper: helper,
              url: url,
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
          backgroundColor: arancioneAircomm,
          textColor: Colors.white);
      return false;
    }
    SystemNavigator.pop();
    return true;
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
