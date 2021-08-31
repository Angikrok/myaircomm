import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_aircomm/app20new/data/dati_utenza.dart';
import 'package:my_aircomm/app20new/model/costanti.dart';
import 'package:my_aircomm/app20new/screen/01_loadingscreen/home_screen.dart';
import 'package:my_aircomm/app20new/screen/03_logged/drawer/infoFatturazione.dart';
import 'package:my_aircomm/app20new/screen/03_logged/fatture_screen/fatture_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'storico_fatture.dart';

// ignore: must_be_immutable
class ElementiMenu extends StatefulWidget {
  ElementiMenu({
    Key? key,
    required this.width,
    required this.height,
    required this.datiUtenza,
    required this.cC,
  }) : super(key: key);

  final double width;
  final double height;
  DatiUtenza datiUtenza;
  final String cC;

  @override
  State<ElementiMenu> createState() => _ElementiMenuState();
}

class _ElementiMenuState extends State<ElementiMenu> {
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    DatiUtenza dati = widget.datiUtenza;
    return Container(
      width: widget.width / 1.3,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(32),
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          color: Colors.white.withOpacity(1)),
      child: Stack(
        children: [
          Positioned(
            top: -135,
            left: -135,
            child: CircleAvatar(
              radius: 135,
              backgroundColor: Color(0xFF40b6c7),
            ),
          ),
          Positioned(
            bottom: -80,
            right: -50,
            child: CircleAvatar(
              radius: 140,
              backgroundColor: Color(0xFF023e8a),
            ),
          ),
          Positioned(
            top: 25,
            child: IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            bottom: -135,
            right: -80,
            child: Transform.rotate(
              angle: -20,
              child: CircleAvatar(
                radius: 155,
                backgroundColor: Color(0xFF40b6c7),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  immagine(),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              //Nome Cliente
              Text(
                dati.nome,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontFamily: 'Coco'),
              ),
              Divider(),
              tastsoFattureNonPagate(context, dati),
              Divider(),
              tastoStorico(context, dati),
              Divider(),
              ListTile(
                trailing: Icon(LineIcons.info, color: Colors.black),
                title: Text(
                  'Info Fatturazione',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: InfoFatturazione(
                            cC: widget.cC,
                            datiUtenza: dati,
                          ),
                          type: PageTransitionType.fade));
                },
              ),
              Divider(),
              tastoEsci(context),
              Divider(),
            ],
          )
        ],
      ),
    );
  }

  Widget immagine() {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.white.withOpacity(0.1),
              offset: const Offset(2.0, 4.0),
              blurRadius: 8),
        ],
      ),
      child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(60.0)),
          child: Icon(
            Icons.person_rounded,
            size: 120,
          )),
    );
  }

  Widget tastsoFattureNonPagate(BuildContext context, DatiUtenza dati) {
    return ListTile(
      trailing: Icon(
        LineIcons.euroSign,
        color: Color(0xFFfb8500),
      ),
      title: Text(
        titleNotPayed,
        style: TextStyle(
          color: Color(0xFFfb8500),
        ),
      ),
      onTap: () {
        Navigator.pushReplacement(
          context,
          PageTransition(
              child: FattureScreen(
                isLoading: true,
                cc: widget.cC,
                datiUtenza: widget.datiUtenza,
              ),
              type: PageTransitionType.fade),
        );
      },
    );
  }

  ListTile tastoStorico(BuildContext context, DatiUtenza dati) {
    List<String> list = [];

    for (int i = DateTime.now().year; i >= DateTime.now().year - 2; i--) {
      list.add(i.toString());
    }
    String value = '2021';
    return ListTile(
      trailing: Icon(
        Icons.check,
        color: bluAircomm,
      ),
      title: Text(
        'Fattura pagate',
        style: TextStyle(
          color: bluAircomm,
        ),
      ),
      onTap: () {
        showDialog(
          context: context, // user must tap button!

          builder: (BuildContext context) {
            return selectYearAlert(value, list, context);
          },
        );
      },
    );
  }

  Widget selectYearAlert(
      String value, List<String> list, BuildContext context) {
    return Platform.isAndroid
        ? AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32))),
            title: Text(
              'Seleziona anno',
              style: TextStyle(fontFamily: 'Coco'),
            ),
            content: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24), color: bluAircomm),
              height: MediaQuery.of(context).size.height / 5,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: TextButton(
                      child: Text(
                        list[0],
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        navigatoreStorico(list[0]);
                      },
                    )),
                    Center(
                        child: TextButton(
                      child: Text(
                        list[1],
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        navigatoreStorico(list[1]);
                      },
                    )),
                    Center(
                        child: TextButton(
                      child: Text(
                        list[2],
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        navigatoreStorico(list[2]);
                      },
                    )),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                child: Text('Annulla'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: new Text('Seleziona'),
                onPressed: () {
                  navigatoreStorico(value);
                },
              ),
            ],
          )
        : CupertinoAlertDialog(
            scrollController: controller,
            insetAnimationCurve: Curves.bounceIn,
            insetAnimationDuration: Duration(seconds: 10),
            title: Text(
              'Seleziona anno',
              style: TextStyle(fontFamily: 'Coco'),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(48),
                        topRight: Radius.circular(48)),
                    minSize: 5,
                    child: Text(list[0]),
                    onPressed: () {
                      navigatoreStorico(list[0]);
                    }),
                CupertinoButton(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    minSize: 5,
                    child: Text(list[1]),
                    onPressed: () {
                      navigatoreStorico(list[1]);
                    }),
                CupertinoButton(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(48),
                        bottomRight: Radius.circular(48)),
                    minSize: 5,
                    child: Text(list[2]),
                    onPressed: () {
                      navigatoreStorico(list[2]);
                    }),
              ],
            ),
            actions: [
              CupertinoDialogAction(
                child: Text('Annulla'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
  }

  navigatoreStorico(String anno) {
    return Navigator.pushReplacement(
        context,
        PageTransition(
            child: StoricoFatture(
              cC: widget.cC,
              a: anno,
              datiUtenza: widget.datiUtenza,
            ),
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 1)));
  }

  ListTile tastoEsci(BuildContext context) {
    return ListTile(
      trailing: Icon(
        Icons.logout,
        color: Colors.red,
      ),
      title: Text(
        'Esci',
        style: TextStyle(color: Colors.red),
      ),
      onTap: () {
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: HomeScreen(), type: PageTransitionType.leftToRight));
      },
    );
  }
}
