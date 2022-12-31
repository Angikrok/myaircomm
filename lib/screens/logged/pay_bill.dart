
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax/iconsax.dart';
import 'package:myaircomm/constants.dart';
import 'package:myaircomm/model/widget/custombody.dart';

// ignore: must_be_immutable
class PayBill extends StatefulWidget {
  String billId;
  String tot;
  PayBill({super.key, required this.billId, required this.tot});

  @override
  State<PayBill> createState() => _PayBillState();
}

class _PayBillState extends State<PayBill> {
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
                          padding:
                              const EdgeInsets.only(top: 4, right: 12, bottom: 4),
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: black,
                          ))),
                  Text(
                    "Dati Aircomm",
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
                      Iconsax.buildings,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.6,
                        child: Text(
                          "Salve, si prega di copiare le informazioni pertinenti dalla fattura di Aircomm per effettuare un bonifico per il pagamento della fattura.",
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
                  "Beneficiario",
                  "Aircomm",
                  Colors.pink.shade400),
              const SizedBox(height: 20),
              infowidget(
                  const Icon(
                    Iconsax.next5,
                    color: Colors.white,
                  ),
                  "Banca",
                  "Monte dei paschi di Siena",
                  Colors.indigo),
              const SizedBox(
                height: 20,
              ),
              infowidget(const Icon(Iconsax.card5, color: Colors.white), "Causale",
                  "Pagamento fattura ${widget.billId}", Colors.green),
              const SizedBox(
                height: 20,
              ),
              infowidget(
                  const Icon(
                    Iconsax.card,
                    color: Colors.white,
                  ),
                  "IBAN",
                  "IT2P0103083880000061234602",
                  Colors.teal),
              const SizedBox(
                height: 20,
              ),
              infowidget(
                  const Icon(
                    Iconsax.money5,
                    color: Colors.white,
                  ),
                  "Importo",
                  "€${widget.tot}",
                  Colors.deepOrange),
            ],
          )),
    );
  }

  Widget infowidget(Icon icon, String info, String data, Color color) {
    return GestureDetector(
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
      ]),
    );
  }
}
