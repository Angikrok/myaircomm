// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:my_aircomm/app20new/controller/http_helper.dart';
import 'package:my_aircomm/app20new/data/dati_utenza.dart';
import 'package:my_aircomm/app20new/data/invoice.dart';
import 'package:my_aircomm/app20new/model/costanti.dart';
import 'package:my_aircomm/app20new/screen/03_logged/drawer/elementi_menu.dart';
import 'fatture_non_pagate.dart';

class ElencoFatture extends StatelessWidget {
  ElencoFatture({
    Key? key,
    required this.datiInvoice,
    required this.datiUtenza,
    required this.helper,
    required this.url,
    required this.title,
    required this.selectYear,
    required this.cC,
    required this.isLoading,
  }) : super(key: key);

  Widget selectYear;
  bool isLoading;

  final List<Invoice> datiInvoice;
  final DatiUtenza datiUtenza;
  final HttpHelper helper;
  final String url;
  final String title;
  final String cC;
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _globalKey,
      drawer: ElementiMenu(
        cC: cC,
        width: width,
        height: height,
        datiUtenza: datiUtenza,
      ),
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
                  Icons.menu,
                  size: 32,
                  color: Colors.white,
                ),
                onPressed: () {
                  _globalKey.currentState!.openDrawer();
                },
              ),
            ),
            selectYear,
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
                            title,
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
                FattureNonPagate(
                  isLoading: isLoading,
                  title: title,
                  datiInvoice: datiInvoice,
                  datiUtenza: datiUtenza,
                  helper: helper,
                  url: url,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
