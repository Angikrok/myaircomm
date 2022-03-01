// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_aircomm/app20new/data/dati_utenza.dart';
import 'package:my_aircomm/costanti.dart';
import 'package:my_aircomm/app20new/screen/03_logged/drawer/elementi_menu.dart';
import 'package:my_aircomm/app20new/screen/03_logged/fatture_screen/fatture_non_pagate.dart';

class InfoFatturazione extends StatefulWidget {
  InfoFatturazione({Key? key, required this.cC, required this.datiUtenza})
      : super(key: key);
  final String cC;
  DatiUtenza datiUtenza;
  @override
  _InfoFatturazioneState createState() => _InfoFatturazioneState();
}

class _InfoFatturazioneState extends State<InfoFatturazione> {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  DateTime? backButtonPressedTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ElementiMenu(
        cC: widget.cC,
        datiUtenza: widget.datiUtenza,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
      key: key,
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Container(
          decoration: BoxDecoration(color: bluAircomm),
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
                    key.currentState!.openDrawer();
                  },
                ),
              ),
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
                              'Info Fatturazione',
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
                  Expanded(
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
                          SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 24.0, bottom: 8),
                                    child: CircleAvatar(
                                        radius: 90,
                                        backgroundColor: Colors.transparent,
                                        child: ClipOval(
                                          child: Image.asset(
                                              'assets/icon/applogo.png'),
                                        ))),
                                Container(
                                  margin: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(36)),
                                      color: Colors.white.withOpacity(.45)),
                                  child: Column(
                                    children: [
                                      nomeCognome(),
                                      Divider(),
                                      tipoFatturazione(),
                                      Divider(),
                                      ultimaFattura(),
                                      Divider(),
                                      prossimaBolletta(),
                                      Divider(),
                                      ibanAircomm(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
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

  ListTile nomeCognome() {
    return ListTile(
      title: Text(widget.datiUtenza.nome, style: TextStyle(fontFamily: 'Coco')),
      subtitle: Text('Nome e Cognome'),
    );
  }

  ListTile tipoFatturazione() {
    return ListTile(
      title: Row(
        children: [
          if (widget.datiUtenza.tipo == '2')
            Text(
              'Bimestrale',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Coco'),
            ),
          if (widget.datiUtenza.tipo == '3')
            Text(
              'Trimestrale',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Coco'),
            ),
          if (widget.datiUtenza.tipo == '6')
            Text(
              'Semestrale',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Coco'),
            ),
          if (widget.datiUtenza.tipo == '12')
            Text(
              'Annuale',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Coco'),
            ),
        ],
      ),
      subtitle: Text('Tipo di fatturazione'),
    );
  }

  ListTile ultimaFattura() {
    return ListTile(
      title: generaMesi(widget.datiUtenza.ultimoMese),
      subtitle: Text('Ultima fattura'),
    );
  }

  ListTile ibanAircomm() {
    return ListTile(
      onTap: () {
        Fluttertoast.showToast(
            msg: 'IBAN Copiato negli appunti',
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black);
        Clipboard.setData(
            ClipboardData(text: "IT72 P01 0308 3880 0000 6123 4602"));
      },
      title: Text(
        'IT72 P01 0308 3880 0000 6123 4602',
        style: TextStyle(fontFamily: 'Coco'),
      ),
      subtitle: Text('IBAN Aircomm'),
    );
  }

  ListTile prossimaBolletta() {
    return ListTile(
      title: generaMesi(widget.datiUtenza.prossimaBolletta),
      subtitle: Text('Prossima fattura'),
    );
  }

  Row generaMesi(String dato) {
    return Row(
      children: [
        if (dato == '1')
          Text(
            'Gennaio',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Coco',
            ),
          ),
        if (dato == '2')
          Text(
            'Febbraio',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Coco',
            ),
          ),
        if (dato == '3')
          Text(
            'Marzo',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Coco',
            ),
          ),
        if (dato == '4')
          Text(
            'Aprile',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Coco',
            ),
          ),
        if (dato == '5')
          Text(
            'Maggio',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Coco',
            ),
          ),
        if (dato == '6')
          Text(
            'Giugno',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Coco',
            ),
          ),
        if (dato == '7')
          Text('Luglio',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Coco',
              )),
        if (dato == '8')
          Text(
            'Agosto',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Coco',
            ),
          ),
        if (dato == '9')
          Text(
            'Settembre',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Coco',
            ),
          ),
        if (dato == '10')
          Text(
            'Ottobre',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Coco',
            ),
          ),
        if (dato == '11')
          Text(
            'Novembre',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Coco',
            ),
          ),
        if (dato == '12')
          Text(
            'Dicembre',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Coco',
            ),
          ),
      ],
    );
  }
}