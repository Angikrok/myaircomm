// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:myaircomm/model/invoice.dart';
import 'package:myaircomm/screens/logged/bill_detail.dart';
import 'package:myaircomm/screens/logged/bill_pdf.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class PayedBill extends StatelessWidget {
  Invoice bill;
  PayedBill({
    Key? key,
    required this.bill,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (c) => BillPdf(billId: bill.billId)));
      },
      contentPadding: const EdgeInsets.all(0),
      title: Text(
        'Fattura di ${detectMonth(bill.data.substring(5, 7))}',
        style:
            montSerrat(fontWeight: FontWeight.bold, fontSize: 14, color: black),
      ),
      subtitle: Text(
        data(DateTime.parse(bill.data)),
        style: montSerrat(
            fontWeight: FontWeight.normal, fontSize: 13, color: grey),
      ),
      trailing: Text(
        "€${bill.tot}",
        style:
            montSerrat(fontWeight: FontWeight.bold, fontSize: 16, color: black),
      ),
      leading: Container(
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 1),
          ], shape: BoxShape.circle, color: Colors.white),
          child: Image.asset('assets/images/logo2.png')),
    );
  }
}

// ignore: must_be_immutable
class NotPayedBillInHome extends StatelessWidget {
  Invoice invoice;
  NotPayedBillInHome({
    super.key,
    required this.invoice,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
        height: 205,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(top: 8, bottom: 10),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 3))
        ], color: blue, borderRadius: BorderRadius.circular(24)),
        child: Stack(
          children: [
            logo(),
            Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                      color: orange,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          bottomRight: Radius.circular(24))),
                  width: 110,
                  height: 60,
                )),
            date(),
            Padding(
              padding: const EdgeInsets.only(top: 14, left: 14, bottom: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    invoice.billId,
                    style: montSerrat(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.78,
                      child: Text(
                        "Paga questa fattura per usufrire ancora del servizo.",
                        style: montSerrat(
                            color: Colors.white70,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${invoice.tot} €',
                    style: montSerrat(
                        color: const Color(0xff70E000),
                        fontSize: 22,
                        fontWeight: FontWeight.w700),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(100, 30),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BillDetail(bill: invoice),
                              ));
                        },
                        child: Text(
                          'Paga Fattura',
                          style: montSerrat(
                              color: blue,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )),
                  )
                ],
              ),
            ),
          ],
        ));
  }

  Positioned date() {
    DateTime previousData = DateTime.parse(invoice.data);
    String currentData = DateFormat("dd/MM/yyyy").format(previousData);

    return Positioned(
        bottom: 15,
        right: 10,
        child: Text(
          currentData,
          style: montSerrat(
              color: Colors.white,
              fontSize: 14,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ));
  }

  Positioned logo() {
    return Positioned(
      right: 10,
      top: 10,
      child: Container(
        decoration:
            const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: Image.asset(
          "assets/images/logo2.png",
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
