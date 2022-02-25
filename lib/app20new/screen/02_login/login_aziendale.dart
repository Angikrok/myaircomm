import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_aircomm/app20new/model/alerts.dart';
import 'package:my_aircomm/costanti.dart';
import 'package:my_aircomm/app20new/screen/03_logged/fatture_screen/fatture_screen.dart';
import '/app20new/controller/http_helper.dart';
import '/app20new/data/dati_login_aziende.dart';
import '/app20new/data/dati_utenza.dart';
import '/app20new/data/db_helper.dart';
import '/app20new/model/text_field.dart';

class Aziendale extends StatefulWidget {
  const Aziendale({Key? key}) : super(key: key);

  @override
  _AziendaleState createState() => _AziendaleState();
}

class _AziendaleState extends State<Aziendale> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          //appbar
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                bluAircomm,
                bluAircomm,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(11.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height / 4,
                      child: Image.asset(
                        'assets/icon/logo2.png',
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18),
                    ),
                    color: Colors.grey[200],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextAccess(
                        text: 'Accedi',
                      ),
                      Expanded(
                        child: LoginAzienda(), //body
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LoginAzienda extends StatefulWidget {
  LoginAzienda({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginAzienda> createState() => _LoginAziendaState();
}

class _LoginAziendaState extends State<LoginAzienda> {
  DatiUtenza? datiUtenza;
  bool error = false;
  TextEditingController txtCC = TextEditingController();
  TextEditingController txtCF = TextEditingController();
  HttpHelper helper = HttpHelper();
  final DbHelper dbHelper = DbHelper();
  DatiLoginAziende datiLoginAziende = DatiLoginAziende(cc: '', cf: '');
  bool ricordami = false;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    dbHelper.apriDbAziende().then((_) {
      dbHelper.readDatiAziende().then((value) {
        datiLoginAziende = value;
        txtCC.text = datiLoginAziende.cc;
        txtCF.text = datiLoginAziende.cf;

        if (datiLoginAziende.cc == '') {
          ricordami = false;
        } else {
          ricordami = true;
        }
        setState(() {});
      });
    });
  }

  bool validate_cc = false;
  bool validate_cf = false;
  @override
  Widget build(BuildContext context) {
    return Login(context);
  }

  Widget Login(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 16, left: 16),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    style: TextStyle(color: Colors.black, fontFamily: ''),
                    controller: txtCC,
                    decoration: InputDecoration(
                      labelText: 'Codice Cliente',
                      errorText: validate_cc ? 'Campo Obbligatorio' : null,
                      suffixIcon: Icon(Icons.accessibility_sharp),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'CF intestatario',
                  style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Italico'),
                ),
              ],
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(right: 16, left: 16),
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      style: TextStyle(color: Colors.black, fontFamily: ''),
                      controller: txtCF,
                      textCapitalization: TextCapitalization.characters,
                      decoration: InputDecoration(
                        labelText: 'CF Intestatario',
                        errorText: validate_cf ? 'Campo Obbligatorio' : null,
                        suffixIcon: GestureDetector(
                          onTap: () {},
                          child: Icon(
                            LineIcons.openSourceInitiative,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
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
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 5,
              ),
              Expanded(
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
              )
            ],
          ),
          bottoneAccedi(context),
          Row(
            children: [
              BackButton(),
            ],
          ),
        ],
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
            bluAircomm,
            bluAircomm,
          ],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
      ),
      child: Center(
          child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, double.infinity),
            primary: Colors.transparent,
            elevation: 0),
        child: Text('Accedi'),
        onPressed: () {
          if (ricordami) {
            salvaDatiAziende();
          } else {
            cancellaDatiAziende();
          }
          setState(
            () {
              txtCC.text.isEmpty ? validate_cc = true : validate_cf = false;
              txtCF.text.isEmpty ? validate_cf = true : validate_cf = false;

              helper
                  .getDatiAzienda(
                      txtCC.text.substring(7, txtCC.text.length), txtCF.text)
                  .catchError((error, stackTrace) {
                Fluttertoast.showToast(
                    msg: "Errore nell'inserimento dei dati",
                    gravity: ToastGravity.SNACKBAR,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 13.5);
              }).then((a) {
                setState(() {
                  isLoading = true;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FattureScreen(
                        isLoading: isLoading,
                        cc: txtCC.text.substring(7, txtCC.text.length),
                        datiUtenza: a,
                      ),
                    ),
                  );
                });
              });
            },
          );
        },
      )),
    );
  }

  Future salvaDatiAziende() async {
    DatiLoginAziende datiLoginAziende =
        DatiLoginAziende(cc: txtCC.text, cf: txtCF.text);
    await dbHelper.insertDatiAziende(datiLoginAziende);
  }

  Future cancellaDatiAziende() async {
    dbHelper.cancellaDatiAziende();
  }
}
