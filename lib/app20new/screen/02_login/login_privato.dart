// ignore_for_file: must_be_immutable
import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_aircomm/app20new/model/alerts.dart';
import 'package:my_aircomm/app20new/model/costanti.dart';
import '/app20new/controller/http_helper.dart';
import '/app20new/data/dati_login_clienti.dart';
import '/app20new/data/dati_utenza.dart';
import '/app20new/data/db_helper.dart';
import '../03_logged/fatture_screen.dart';
import '/app20new/model/text_field.dart';

class Privato extends StatefulWidget {
  const Privato({Key? key}) : super(key: key);

  @override
  _PrivatoState createState() => _PrivatoState();
}

class _PrivatoState extends State<Privato> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context)
            .unfocus(), //quando clicchi sul nulla chiude la tastiera se è aperta
        child: Scaffold(
          body: Container(
            //appbar
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Costanti.bluAircomm,
                  Costanti.bluAircomm,
                ],
              ),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 4,
                    child: Image.asset(
                      'assets/icon/logo2.png',
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                      color: Colors.grey[100],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextAccess(
                          text: 'Accedi',
                        ),
                        Expanded(
                          child: LoginPrivato(), //body
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginPrivato extends StatefulWidget {
  const LoginPrivato({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPrivato> createState() => _LoginPrivatoState();
}

class _LoginPrivatoState extends State<LoginPrivato> {
  bool error = false;
  List<String> listG = [
    'Giorno',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09'
  ];
  List<String> listM = [
    'Mese',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
  ];
  List<String> listA = [
    'Anno',
  ];
  String valueG = 'Giorno';
  String valueM = 'Mese';
  String valueA = 'Anno';
  TextEditingController txtCC = TextEditingController();
  final formKeyCc = GlobalKey<FormState>();
  final DbHelper dbHelper = DbHelper();
  HttpHelper helper = HttpHelper();
  DatiUtenza? datiUtenza;
  DatiLoginClienti datiLoginClienti =
      DatiLoginClienti(cc: '', g: '', m: '', a: '');
  bool ricordami = false;

  @override
  void initState() {
    super.initState();
    for (int g = 10; g <= 31; g++) {
      listG.add(g.toString());
    }
    for (int m = 10; m <= 12; m++) {
      listM.add(m.toString());
    }
    for (int a = DateTime.now().year; a >= 1920; a--) {
      listA.add(a.toString());
    }
    dbHelper.apriDbClienti().then((_) {
      dbHelper.readDatiClienti().then((value) {
        datiLoginClienti = value;
        txtCC.text = datiLoginClienti.cc;
        valueG = datiLoginClienti.g;
        valueM = datiLoginClienti.m;
        valueA = datiLoginClienti.a;
        if (datiLoginClienti.cc == '') {
          ricordami = false;
        } else {
          ricordami = true;
        }
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Container(
          height: MediaQuery.of(context).size.height, child: Login(context)),
    );
  }

  Login(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.grey[100],
        child: Column(
          children: [
            Form(
              key: formKeyCc,
              child: TextField_Cc(
                txt: 'Codice Cliente',
                txtCC: txtCC,
                formKey: formKeyCc,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Data Di Nascita',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        color: Colors.grey[100],
                      ),
                      width: MediaQuery.of(context).size.width / 3.5,
                      child: DropdownButton<String>(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          bottomLeft: Radius.circular(24),
                        ),
                        elevation: 0,
                        dropdownColor: Colors.white.withOpacity(.9),
                        isExpanded: true,
                        menuMaxHeight:
                            MediaQuery.of(context).size.height / 2.05,
                        underline: Text(
                          '',
                        ),
                        icon: Container(),
                        value: valueG,
                        items: listG.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Center(
                              child: Text(
                                value,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (valore) {
                          listG.indexWhere((element) => listG == valore);
                          //dbHelper.ricordaDaticlienti(g: valore);

                          valueG = valore!;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        color: Colors.grey[100],
                      ),
                      width: MediaQuery.of(context).size.width / 3.5,
                      child: DropdownButton<String>(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          bottomLeft: Radius.circular(24),
                        ),
                        elevation: 0,
                        dropdownColor: Colors.white.withOpacity(.9),
                        isExpanded: true,
                        menuMaxHeight:
                            MediaQuery.of(context).size.height / 2.05,
                        underline: Text(
                          '',
                        ),
                        icon: Container(),
                        value: valueM,
                        items: listM.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Center(
                              child: Text(
                                value,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (valore) {
                          listM.indexWhere((element) => listM == valore);
                          //dbHelper.ricordaDaticlienti(m: valore);
                          valueM = valore!;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        color: Colors.grey[100],
                      ),
                      width: MediaQuery.of(context).size.width / 3.5,
                      child: DropdownButton<String>(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          bottomLeft: Radius.circular(24),
                        ),
                        elevation: 0,
                        dropdownColor: Colors.white.withOpacity(.9),
                        menuMaxHeight:
                            MediaQuery.of(context).size.height / 2.05,
                        isExpanded: true,
                        underline: Text(
                          '',
                        ),
                        icon: Container(),
                        value: valueA,
                        items: listA.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Center(
                              child: Text(
                                value,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (valore) {
                          listA.indexWhere((element) => listA == valore);
                          //dbHelper.ricordaDaticlienti(a: valore);
                          valueA = valore!;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomCheckBox(
                      checkedFillColor: Colors.green,
                      uncheckedFillColor: Colors.white,
                      uncheckedIconColor: Colors.white,
                      shouldShowBorder: false,
                      value: ricordami,
                      onChanged: (value) {
                        ricordami = value;
                        setState(() {});
                      },
                    ),
                    Text(
                      'Ricordami',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          letterSpacing: .5),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 5,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {
                                showAlertDialog(
                                  context,
                                );
                              },
                              child: Text(
                                'Dove trovo il codice cliente?',
                                textAlign: TextAlign.center,
                              )),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            bottoneAccedi(context),
          ],
        ),
      ),
    );
  }

  Container bottoneAccedi(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(12),
      height: 50,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Costanti.bluAircomm,
            Costanti.bluAircomm,
          ],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, double.infinity),
            primary: Colors.transparent,
            elevation: 0),
        child: Text('Accedi'),
        onPressed: () {
          if (ricordami == true) {
            salvaDatiCliente();
          } else {
            cancellaDatiCliente();
          }

          setState(() {
            if (!(formKeyCc.currentState!.validate())) {}

            helper
                .getDatiCliente(
              txtCC.text,
              valueG.toString(),
              valueM.toString(),
              valueA.toString(),
            )
                .catchError((error, stackTrace) {
              Fluttertoast.showToast(
                  msg: "Errore nell'inserimento dei dati",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.SNACKBAR,
                  timeInSecForIosWeb: 22,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 13.0);
            }).then((DatiUtenza datiUtenza) {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FattureScreen(
                      datiUtenza: datiUtenza,
                    ),
                  ),
                );
              });
            });
          });
          setState(() {});
        },
      ),
    );
  }

  Future salvaDatiCliente() async {
    DatiLoginClienti datiLoginClienti = DatiLoginClienti(
      cc: txtCC.text,
      g: valueG,
      m: valueM,
      a: valueA,
    );

    await dbHelper.insertDatiClienti(datiLoginClienti);
  }

  Future cancellaDatiCliente() async {
    dbHelper.cancellaDatiClienti();
  }
}
