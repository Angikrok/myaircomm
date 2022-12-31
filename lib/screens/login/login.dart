import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax/iconsax.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:myaircomm/constants.dart';
import 'package:myaircomm/model/widget/custombody.dart';
import 'package:myaircomm/screens/login/onboarding.dart';
import 'package:provider/provider.dart';

import '../../model/user_info.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isSelected = false;
  DateTime? birthDay;
  bool isPrivate = true;
  TextEditingController _controller = TextEditingController();
  TextEditingController ivaController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        CustomBody(
            horizontalSpace: true,
            verticalSpace: true,
            child: Provider.of<InternetConnectionStatus>(context) ==
                    InternetConnectionStatus.disconnected
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: Text(
                        'Nessuna connessione ad internet.\n\nConnettiti ad internet per continuare',
                        textAlign: TextAlign.center,
                        style: montSerrat(
                            color: Colors.red,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      )),
                    ],
                  )
                : FutureBuilder(
                    future: helper.serviceStatus(),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? !snapshot.data!
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                        child: Text(
                                      'Nessuna connessione ad internet.\n\nConnettiti ad internet per continuare',
                                      textAlign: TextAlign.center,
                                      style: montSerrat(
                                          color: Colors.red,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ],
                                )
                              : ListView(
                                  children: [
                                    Image.asset(
                                      "assets/images/logo.png",
                                      height: 200,
                                    ),
                                    Center(
                                        child: Text(
                                      "Benvenuto!",
                                      style: montSerrat(
                                        color: black,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                    const Padding(
                                        padding: EdgeInsets.only(top: 17)),
                                    Text(
                                      "Seleziona il tipo di accesso e inserisci i tuoi dati per continuare",
                                      style: montSerrat(
                                          color: grey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: .7),
                                      textAlign: TextAlign.center,
                                    ),
                                    // const SizedBox(height: 8),
                                    // InkWell(
                                    //   onTap: () => Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //           builder: (context) =>
                                    //               const EnterModule())),
                                    //   child: RichText(
                                    //       textAlign: TextAlign.center,
                                    //       text: TextSpan(children: [
                                    //         TextSpan(
                                    //             text: 'Non sei un cliente?\n',
                                    //             style: montSerrat(
                                    //                 color: black,
                                    //                 fontWeight:
                                    //                     FontWeight.w500)),
                                    //         TextSpan(
                                    //             text:
                                    //                 'Compila un modulo per diventarlo',
                                    //             style: montSerrat(
                                    //                 color: blue,
                                    //                 fontWeight:
                                    //                     FontWeight.bold)),
                                    //       ])),
                                    // ),
                                    const Padding(
                                        padding: EdgeInsets.only(top: 24)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            isPrivate = true;
                                            setState(() {});
                                          },
                                          child: loginTypeWidget('Privato',
                                              Iconsax.profile_circle),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              isPrivate = false;
                                              setState(() {});
                                            },
                                            child: loginTypeWidget(
                                                "Aziendale", Iconsax.building))
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 47),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(Iconsax.user,
                                                  size: 30),
                                              Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 15),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      105,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    color: null,
                                                  ),
                                                  child: TextField(
                                                    cursorColor: black,
                                                    controller: _controller,
                                                    decoration: InputDecoration(
                                                        focusedBorder:
                                                            const UnderlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                        color:
                                                                            black)),
                                                        enabledBorder:
                                                            const UnderlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                        color:
                                                                            black)),
                                                        hintText:
                                                            "Codice cliente",
                                                        hintStyle: montSerrat(
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            color: grey,
                                                            fontSize: 16)),
                                                  )),
                                            ],
                                          ),
                                          const SizedBox(height: 25),
                                          Row(
                                            children: [
                                              Icon(
                                                isPrivate
                                                    ? Iconsax.calendar_add
                                                    : Iconsax.document,
                                                size: 30,
                                              ),
                                              Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 15),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      105,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    color: null,
                                                  ),
                                                  child: isPrivate
                                                      ? datePicker(context)
                                                      : TextField(
                                                          cursorColor: black,
                                                          controller:
                                                              ivaController,
                                                          decoration: InputDecoration(
                                                              focusedBorder: const UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              black)),
                                                              enabledBorder: const UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              black)),
                                                              hintText: isPrivate
                                                                  ? "Data di nascita"
                                                                  : "P.IVA o C.F. intestatario",
                                                              hintStyle: const TextStyle(
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic)),
                                                        )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Row(
                                        children: [
                                          const Spacer(),
                                          GestureDetector(
                                            onTap: () {
                                              _showMyDialog();
                                            },
                                            child: Text(
                                              "Dove trovo il codice cliente?",
                                              style: montSerrat(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: orange),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Checkbox(
                                          side: const BorderSide(
                                              width: 1, color: black),
                                          activeColor: blue,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          checkColor: Colors.white,
                                          value: isSelected,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              isSelected = value!;
                                            });
                                          },
                                        ),
                                        Text(
                                          "Ricordami",
                                          style: montSerrat(
                                              fontSize: 18, color: black),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 24, left: 12, right: 12),
                                      width: 100,
                                      height: 50,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          isPrivate
                                              ? setState(() {
                                                  if (_controller.text.length <
                                                      7) {
                                                    showError(false);
                                                  } else {
                                                    helper
                                                        .getDatiCliente(
                                                            _controller.text
                                                                .substring(7),
                                                            birthDay!.day < 10
                                                                ? '0${birthDay!.day}'
                                                                : birthDay!.day
                                                                    .toString(),
                                                            birthDay!.month < 10
                                                                ? '0${birthDay!.month}'
                                                                : birthDay!
                                                                    .month
                                                                    .toString(),
                                                            birthDay!.year
                                                                .toString())
                                                        .catchError((error,
                                                            stackTrace) {
                                                      return showError(false);
                                                    }).then((UserInfo
                                                            datiUtenza) {
                                                      setState(() {
                                                        userInfo = datiUtenza;
                                                        isSelected
                                                            ? pref!.setString(
                                                                'cc',
                                                                _controller.text
                                                                    .substring(
                                                                        7))
                                                            : null;
                                                        pref!.setInt(
                                                            'isPrivate', 1);
                                                        pref!.setString(
                                                            'day',
                                                            birthDay!.day < 10
                                                                ? '0${birthDay!.day}'
                                                                : birthDay!.day
                                                                    .toString());
                                                        pref!.setString(
                                                            'month',
                                                            birthDay!.month < 10
                                                                ? '0${birthDay!.month}'
                                                                : birthDay!
                                                                    .month
                                                                    .toString());
                                                        pref!.setString(
                                                            'year',
                                                            birthDay!.year
                                                                .toString());

                                                        Navigator
                                                            .pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const OnBoarding()),
                                                        );
                                                      });
                                                    });
                                                  }
                                                })
                                              : setState(() {
                                                  if (_controller.text.length <
                                                      7) {
                                                    showError(false);
                                                  } else {
                                                    helper
                                                        .getDatiAzienda(
                                                            _controller.text
                                                                .substring(7),
                                                            ivaController.text)
                                                        .timeout(
                                                            const Duration(
                                                                seconds: 20),
                                                            onTimeout: () {
                                                      showError(true);
                                                      return UserInfo(
                                                          id: '',
                                                          name: '',
                                                          type: '',
                                                          lastMonth: '',
                                                          nextInvoice: '',
                                                          invoice: []);
                                                    }).catchError((error,
                                                            stackTrace) {
                                                      return showError(false);
                                                    }).then((a) {
                                                      userInfo = a;
                                                      isSelected
                                                          ? pref!.setString(
                                                              'cc',
                                                              _controller.text
                                                                  .substring(7))
                                                          : userInfo.id != a.id;
                                                      pref!.setString('iva',
                                                          ivaController.text);

                                                      pref!.setInt(
                                                          'isPrivate', 2);

                                                      setState(() {
                                                        Navigator
                                                            .pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const OnBoarding()),
                                                        );
                                                      });
                                                    });
                                                  }
                                                });
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: blue,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16))),
                                        child: Text(
                                          'Accedi',
                                          style: montSerrat(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                    child: Text(
                                  'Controllo stato del server...',
                                  textAlign: TextAlign.center,
                                  style: montSerrat(
                                      color: black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                )),
                              ],
                            );
                    })),
      ],
    ));
  }

  Container loginTypeWidget(
    String typetxt,
    IconData icon,
  ) {
    return Container(
        width: MediaQuery.of(context).size.width / 2.6,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            border: Border.all(
              color: typetxt == 'Privato'
                  ? isPrivate
                      ? orange
                      : Colors.transparent
                  : !isPrivate
                      ? orange
                      : Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(18)),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              typetxt,
              style: montSerrat(
                  fontSize: 18,
                  color: typetxt == 'Privato'
                      ? isPrivate
                          ? orange
                          : black
                      : !isPrivate
                          ? orange
                          : black,
                  fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Icon(
                icon,
                color: typetxt == 'Privato'
                    ? isPrivate
                        ? orange
                        : black
                    : !isPrivate
                        ? orange
                        : black,
                size: 30,
              ),
            )
          ],
        ));
  }

  GestureDetector datePicker(BuildContext context) {
    return GestureDetector(
      onTap: () {
        iosDatePicker(context);
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: black)),
        ),
        margin: const EdgeInsets.only(top: 5),
        child: birthDay == null
            ? Text(
                'Data di nascita',
                style: montSerrat(
                    fontSize: 16, color: grey, fontStyle: FontStyle.italic),
              )
            : Text(
                DateFormat('dd/MM/yyyy').format(birthDay!),
                style: montSerrat(fontSize: 16, color: black),
              ),
      ),
    );
  }

  iosDatePicker(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height * 0.25,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (value) {
                isSelected = false;
                birthDay = value;
                setState(() {});
              },
              initialDateTime: birthDay,
              minimumYear: 1900,
              maximumYear: DateTime.now().year,
            ),
          );
        });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          content: Text(
            'Il codice cliente si trova nel contratto o nella fattura posizionato sempre in alto a sinista. Il tuo codice coincide con l’anno di installazione seguito dal codice Air. Ad esempio: Il signor Mario Rossi installato nel 2022 avrà il codice cliente composta  da 2022AirXXXX.',
            style: montSerrat(fontSize: 16, color: grey),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Ok',
                style: montSerrat(
                    fontSize: 18, color: blue, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  showError(bool serverError) {
    return Fluttertoast.showToast(
        msg: serverError
            ? 'Server offlie riprova più tardi'
            : "Errore nell'inserimento dei dati",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: const Color(0xFFef233c),
        textColor: Colors.white,
        fontSize: 15.0);
  }
}

showError(bool serverError) {
  return Fluttertoast.showToast(
      msg: serverError
          ? 'Server offlie riprova più tardi'
          : "Errore nell'inserimento dei dati",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: const Color(0xffef233c),
      textColor: Colors.white,
      fontSize: 15.0);
}
