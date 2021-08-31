import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_aircomm/app20new/data/dati_utenza.dart';
import 'package:my_aircomm/app20new/model/costanti.dart';
import 'package:my_aircomm/app20new/screen/03_logged/drawer/elementi_menu.dart';
import 'package:my_aircomm/app20new/screen/03_logged/fatture_screen/fatture_non_pagate.dart';

class InfoFatturazione extends StatefulWidget {
  const InfoFatturazione({
    Key? key,
  }) : super(key: key);

  @override
  _InfoFatturazioneState createState() => _InfoFatturazioneState();
}

class _InfoFatturazioneState extends State<InfoFatturazione> {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
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
                Container(
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
                      Column(
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
                              'Non risultano fatture pagate',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Colors.black.withOpacity(.5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
