
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax/iconsax.dart';
import 'package:myaircomm/constants.dart';
import 'package:myaircomm/model/widget/custombody.dart';

class BillingInfo extends StatefulWidget {
  const BillingInfo({super.key});

  @override
  State<BillingInfo> createState() => _BillingInfoState();
}

class _BillingInfoState extends State<BillingInfo> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomBody(
          horizontalSpace: true,
          verticalSpace: false,
          child: ListView(
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          padding: const EdgeInsets.only(
                              top: 4, right: 12, bottom: 4),
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: black,
                          ))),
                  Text(
                    "Info Fatturazione",
                    style: montSerrat(
                        color: black,
                        fontWeight: FontWeight.w700,
                        fontSize: 24),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 4,
                    height: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: blue.withOpacity(0.7),
                        border: Border.all(width: 5, color: blue)),
                    child: const Icon(
                      Iconsax.profile_tick5,
                      color: Colors.white,
                      size: 80,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 155,
                        child: Text(
                          userInfo.name,
                          style: montSerrat(
                              color: black,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.6,
                        child: Text(
                          "Qui vedrai il tipo di fatturazione, la prossima fattura e i dettagli dell'IBAN di Aircomm.",
                          style: montSerrat(
                              color: grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              infowidget(
                  const Icon(
                    Iconsax.calendar5,
                    color: Colors.white,
                  ),
                  "Tipo fatturazione",
                  getBillsType(),
                  Colors.pink.shade400, false),
              const SizedBox(height: 20),
              infowidget(
                  const Icon(
                    Iconsax.next5,
                    color: Colors.white,
                  ),
                  "Prossima Fattura",
                  detectMonth(userInfo.nextInvoice),
                  Colors.indigo, false),
              const SizedBox(
                height: 20,
              ),
              infowidget(const Icon(Iconsax.card5, color: Colors.white), "IBAN",
                  "IT2P0103083880000061234602", Colors.green, true),
            ],
          )),
    );
  }

  Widget infowidget(
      Icon icon, String info, String data, Color color, bool iban) {
    return iban
        ?   GestureDetector(
            onTap: () async {
              await Clipboard.setData(ClipboardData(text: data)).then((value) {
                Fluttertoast.showToast(
                    msg: '$info copiato negli appunti',
                    backgroundColor: Colors.white,
                    textColor: black,
                    toastLength: Toast.LENGTH_SHORT,
                    fontSize: 15);
              });
            },
            child: Row(children: [
              Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: grey, blurRadius: 2, offset: const Offset(1, 2))
                    ],
                    color: color,
                  ),
                  padding: const EdgeInsets.all(15),
                  child: icon),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    info,
                    style: montSerrat(
                      color: black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    data,
                    style: montSerrat(fontSize: 16, color: grey),
                  )
                ],
              ),
            ]),
          )
        :  Row(children: [
            Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: grey, blurRadius: 2, offset: const Offset(1, 2))
                  ],
                  color: color,
                ),
                padding: const EdgeInsets.all(15),
                child: icon),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  info,
                  style: montSerrat(
                    color: black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  data,
                  style: montSerrat(fontSize: 16, color: grey),
                )
              ],
            ),
          ]);
  }

  String detectMonth(String nextInvoice) {
    int month = int.parse(nextInvoice);
    if (month == 1) {
      return 'Gennaio';
    } else if (month == 2) {
      return 'Febbraio';
    } else if (month == 3) {
      return 'Marzo';
    } else if (month == 4) {
      return 'Aprile';
    } else if (month == 5) {
      return 'Maggio';
    } else if (month == 6) {
      return 'Giugno';
    } else if (month == 7) {
      return 'Luglio';
    } else if (month == 8) {
      return 'Agosto';
    } else if (month == 9) {
      return 'Settembre';
    } else if (month == 10) {
      return 'Ottobre';
    } else if (month == 11) {
      return 'Novembre';
    } else if (month == 12) {
      return 'Dicembre';
    } else {
      return 'Errore';
    }
  }

  String getBillsType() {
    if (userInfo.type == '2') {
      return 'Bimestrale';
    } else if (userInfo.type == '1') {
      return 'Mensile';
    } else if (userInfo.type == '3') {
      return 'Trimestrale';
    } else if (userInfo.type == '6') {
      return 'Semestrale';
    } else if (userInfo.type == '12') {
      return 'Annuale';
    } else {
      return '';
    }
  }
}
