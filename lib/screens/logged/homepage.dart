import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myaircomm/model/invoice.dart';
import 'package:myaircomm/model/widget/bills_card.dart';
import 'package:myaircomm/model/widget/custombody.dart';
import 'package:myaircomm/screens/logged/billing_info.dart';
import 'package:myaircomm/screens/logged/menu.dart';

import '../../constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Invoice> payedBills = [];
  int yearOfNextInvoice = DateTime.now().year;
  @override
  void initState() {
    int year = DateTime.now().year;
    helper
        .storicoFatture(
            pref!.getString('cc') == null
                ? userInfo.id
                : pref!.getString('cc')!,
            year.toString())
        .then((value) {
      if (value.isEmpty) {
        year = DateTime.now().year - 1;

        helper
            .storicoFatture(
                pref!.getString('cc') == null
                    ? userInfo.id
                    : pref!.getString('cc')!,
                year.toString())
            .then((value) {
          payedBills = value;
          setState(() {});
        });
      } else {
        payedBills = value;
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomBody(
        verticalSpace: true,
        horizontalSpace: true,
        child: SafeArea(
          child: FutureBuilder(
              future: pref!.getInt('isPrivate') == 1
                  ? helper.getDatiCliente(
                      userInfo.id.isEmpty
                          ? pref!.getString('cc')!
                          : userInfo.id,
                      pref!.getString('day')!,
                      pref!.getString('month')!,
                      pref!.getString('year')!)
                  : pref!.getInt('isPrivate') == 2
                      ? helper.getDatiAzienda(
                          userInfo.id.isEmpty
                              ? pref!.getString('cc')!
                              : userInfo.id,
                          pref!.getString('iva')!)
                      : null,
              builder: (context, snapshot) {
                snapshot.hasData ? userInfo = snapshot.data! : null;
                snapshot.hasData ? setNotification() : null;

                return !snapshot.hasData
                    ? const Center(child: CircularProgressIndicator.adaptive())
                    : Stack(
                        children: [
                          SizedBox(
                              height: 500,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(
                                      'Ciao ${snapshot.data!.name}',
                                      maxLines: 1,
                                      style: montSerrat(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: grey),
                                    ),
                                  ),
                                  Text(
                                    'Bentornato',
                                    style: montSerrat(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                  ),
                                  const SizedBox(height: 15),
                                  snapshot.data!.invoice.isEmpty
                                      ? Container()
                                      : Stack(
                                          children: [
                                            NotPayedBillInHome(
                                              invoice:
                                                  snapshot.data!.invoice[0],
                                            ),
                                          ],
                                        ),
                                  snapshot.data!.invoice.isEmpty
                                      ? Container()
                                      : Row(
                                          children: [
                                            const Spacer(),
                                            Text(
                                              "Ultima fattura non pagata",
                                              style: montSerrat(
                                                  fontWeight: FontWeight.w600,
                                                  color: black),
                                            )
                                          ],
                                        ),
                                ],
                              )),
                          Container(
                            margin: EdgeInsets.only(
                                top: snapshot.data!.invoice.isEmpty ? 65 : 315),
                            height: MediaQuery.of(context).size.height,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Servizi',
                                    style: montSerrat(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12, bottom: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        serviceWidget('assets/images/cards.svg',
                                            'Paga fatture', () {
                                          Navigator.pushReplacement(
                                              context,
                                              PageRouteBuilder(
                                                  transitionDuration:
                                                      Duration.zero,
                                                  reverseTransitionDuration:
                                                      Duration.zero,
                                                  pageBuilder: (c, a, a2) =>
                                                      Menu(
                                                        index: 1,
                                                        isPayedBills: false,
                                                      )));
                                        }),
                                        serviceWidget('assets/images/bills.svg',
                                            'Storico fatture', () {
                                          Navigator.pushReplacement(
                                              context,
                                              PageRouteBuilder(
                                                  transitionDuration:
                                                      Duration.zero,
                                                  reverseTransitionDuration:
                                                      Duration.zero,
                                                  pageBuilder: (c, a, a2) =>
                                                      Menu(
                                                        index: 1,
                                                        isPayedBills: true,
                                                      )));
                                        }),
                                        serviceWidget('assets/images/info.svg',
                                            'Info\nfatturazione', () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (c) =>
                                                      const BillingInfo()));
                                        }),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text(
                                        'Ultime fatture',
                                        style: montSerrat(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24),
                                      ),
                                      const Spacer(),
                                      InkWell(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                                context,
                                                PageRouteBuilder(
                                                    transitionDuration:
                                                        Duration.zero,
                                                    reverseTransitionDuration:
                                                        Duration.zero,
                                                    pageBuilder: (c, a, a2) =>
                                                        Menu(
                                                          index: 1,
                                                          isPayedBills: true,
                                                        )));
                                          },
                                          child: Text(
                                            'Vedi Tutte',
                                            style: montSerrat(
                                                color: orange,
                                                fontWeight: FontWeight.bold),
                                          ))
                                    ],
                                  ),
                                  payedBills.isNotEmpty
                                      ? Column(
                                          children: List.generate(
                                              payedBills.length,
                                              (index) => Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 12),
                                                    child: Column(
                                                      children: [
                                                        PayedBill(
                                                            bill: payedBills[
                                                                index]),
                                                        const Divider(height: 1)
                                                      ],
                                                    ),
                                                  )),
                                        )
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(top: 32),
                                          child: Center(
                                            child: Text(
                                              "Non risultano fatture pagate recentemente",
                                              textAlign: TextAlign.center,
                                              style: montSerrat(
                                                  fontSize: 15,
                                                  color: black.withOpacity(.8),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )
                                ],
                              ),
                            ),
                          ),
                          snapshot.data!.invoice.isEmpty
                              ? Container()
                              : Positioned(
                                  right: 60,
                                  top: 9,
                                  child: Image.asset(
                                    "assets/images/playerhome.png",
                                    height: 74,
                                  ))
                        ],
                      );
              }),
        ),
      ),
    );
  }

  Future<void> setNotification() async {
    if (pref!.getBool('notifications') == null) {
      pref!.setBool('notifications', true);
    }

    if (pref!.getBool('notifications')!) {
      if (DateTime.now().month > int.parse(userInfo.nextInvoice)) {
        yearOfNextInvoice = DateTime.now().year + 1;
        scheduleNotification(
            yearOfNextInvoice, int.parse(userInfo.nextInvoice));
      } else {
        scheduleNotification(
            yearOfNextInvoice, int.parse(userInfo.nextInvoice));
      }
    } else {
      null;
    }
  }

  Widget serviceWidget(String image, String title, Function function) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        height: 152,
        width: MediaQuery.of(context).size.width / 3.6,
        margin: const EdgeInsets.only(right: 10),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              shadowColor: grey.withOpacity(0.4),
              color: blue.withOpacity(.4),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              elevation: 15,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 40,
                  child: SvgPicture.asset(
                    image,
                    width: 70,
                    height: 70,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: montSerrat(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
