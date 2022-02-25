// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_aircomm/app20new/data/dati_utenza.dart';
import 'package:my_aircomm/costanti.dart';
import 'package:my_aircomm/app20new/screen/03_logged/fatture_screen/fatture_non_pagate.dart';

class BonificoInfo extends StatefulWidget {
  BonificoInfo(
      {Key? key,
      required this.cC,
      required this.datiUtenza,
      required this.id,
      required this.tot})
      : super(key: key);
  final String cC;
  DatiUtenza datiUtenza;
  String id;
  String tot;
  @override
  _BonificoInfoState createState() => _BonificoInfoState();
}

class _BonificoInfoState extends State<BonificoInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                  Icons.arrow_back,
                  size: 32,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
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
                            'Dati Aircomm',
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
                                    bonifico(),
                                    Divider(),
                                    banca(),
                                    Divider(),
                                    causale(),
                                    Divider(),
                                    ibanAircomm(),
                                    Divider(),
                                    totale(),
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
    );
  }

  ListTile bonifico() {
    return ListTile(
        title: Text('AIRCOMM SRL', style: TextStyle(fontFamily: 'Coco')),
        subtitle: Text('Beneficiario'),
        onTap: () {
          Fluttertoast.showToast(
              msg: 'Beneficiario Copiata negli appunti',
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black);
          Clipboard.setData(ClipboardData(text: "AIRCOMM SRL"));
        });
  }

  ListTile banca() {
    return ListTile(
        title: Text('MONTE DEI PASCHI DI SIENA'),
        subtitle: Text('Banca'),
        onTap: () {
          Fluttertoast.showToast(
              msg: 'Banca Copiata negli appunti',
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black);
          Clipboard.setData(ClipboardData(text: "MONTE DEI PASCHI DI SIENA"));
        });
  }

  ListTile causale() {
    return ListTile(
        title: Text('Pagamento fattura ${widget.id}'),
        subtitle: Text('Causale'),
        onTap: () {
          Fluttertoast.showToast(
              msg: 'ID Fattura copiata negli appunti',
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black);
          Clipboard.setData(ClipboardData(text: widget.id));
        });
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

  ListTile totale() {
    return ListTile(
      title: Text('${widget.tot} €'),
      subtitle: Text('Importo'),
      onTap: () {
        Fluttertoast.showToast(
            msg: 'Importo Copiato negli appunti',
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black);
        Clipboard.setData(ClipboardData(text: widget.tot));
      },
    );
  }
}
