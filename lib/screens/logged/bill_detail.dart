// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:myaircomm/constants.dart';
import 'package:myaircomm/model/widget/custombody.dart';
import 'package:myaircomm/screens/logged/bill_pdf.dart';
import 'package:myaircomm/screens/logged/pay_bill.dart';

import '../../model/invoice.dart';

// ignore: must_be_immutable
class BillDetail extends StatefulWidget {
  Invoice bill;
  BillDetail({
    Key? key,
    required this.bill,
  }) : super(key: key);

  @override
  State<BillDetail> createState() => _BillDetailState();
}

class _BillDetailState extends State<BillDetail> {
  bool isBarcode = false;
  bool isPaypal = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomBody(
          horizontalSpace: true,
          verticalSpace: true,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: black,
                  )),
              title: Text(
                "Fattura ${widget.bill.billId}",
                style: montSerrat(
                    color: black, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) =>
                                  BillPdf(billId: widget.bill.billId)));
                    },
                    icon: const Icon(
                      Iconsax.document_text,
                      color: black,
                    ))
              ],
            ),
            body: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Text(
                      "Paga con bollettino",
                      style: montSerrat(
                          color: black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: blue,
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                        child: BarcodeWidget(
                          barcode:
                              isBarcode ? Barcode.code128() : Barcode.qrCode(),
                          data: widget.bill.barCode,
                          drawText: false,
                          height: 170,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Center(
                      child: SelectableText(
                        widget.bill.barCode,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              isBarcode = true;
                              setState(() {});
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: isBarcode ? blue : Colors.transparent,
                                borderRadius: isBarcode
                                    ? BorderRadius.circular(10)
                                    : null,
                              ),
                              child: Text(
                                "Barcode",
                                style: montSerrat(
                                    color: isBarcode ? Colors.white : black,
                                    fontSize: 20,
                                    fontWeight: isBarcode
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            isBarcode = false;
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isBarcode ? Colors.transparent : blue,
                              borderRadius:
                                  isBarcode ? null : BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Qrcode",
                              style: montSerrat(
                                  color: isBarcode ? black : Colors.white,
                                  fontSize: 20,
                                  fontWeight: isBarcode
                                      ? FontWeight.normal
                                      : FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "Oppure paga con",
                      style: montSerrat(
                          color: black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            isPaypal = true;
                            setState(() {});
                          },
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                color: isPaypal ? orange : Colors.transparent,
                                border: Border.all(color: black),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        const SizedBox(
                          width: 180,
                        ),
                        GestureDetector(
                          onTap: () {
                            isPaypal = false;
                            setState(() {});
                          },
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                color: isPaypal ? Colors.transparent : orange,
                                border: Border.all(color: black),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            isPaypal = true;
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 0, left: 20, right: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromRGBO(255, 255, 255, 1),
                                boxShadow: [
                                  BoxShadow(
                                      color: grey.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 4,
                                      offset: const Offset(0, 3))
                                ]),
                            child: Image.asset(
                              "assets/images/paypal.png",
                              height: 60,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        GestureDetector(
                          onTap: () {
                            isPaypal = false;
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 0, left: 20, right: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromRGBO(255, 255, 255, 1),
                                boxShadow: [
                                  BoxShadow(
                                      color: grey.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 4,
                                      offset: const Offset(0, 3))
                                ]),
                            child: Image.asset(
                              "assets/images/bonificobancario.png",
                              height: 60,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Iconsax.info_circle,
                          color: orange,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: SizedBox(
                            width: 270,
                            child: Text(
                              "Se effettui un bonifico o un pagamento con Paypal un operatore controllerà tale operazione per poi confermare il pagamento della fattura.",
                              style: montSerrat(
                                color: grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Divider(color: grey, height: 2),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Prezzo Fattura",
                          style: montSerrat(
                              color: grey,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        Text(
                          "${widget.bill.tot} €",
                          style: montSerrat(
                              color: black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const Spacer(),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: orange,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14)),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 24)),
                            onPressed: () {
                              isPaypal
                                  ? _launchURL()
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (c) => PayBill(
                                                tot: widget.bill.tot,
                                                billId: widget.bill.billId,
                                              )));
                            },
                            child: Text(
                              "Paga",
                              style: montSerrat(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  _launchURL() async {
    String url =
        "https://www.paypal.com/cgi-bin/webscr?cmd=_xclick&charset=utf-8&business=info@aircomm.it&item_name=Pagamento%20Fattura%20Numero%20${widget.bill.billId}&amount=${widget.bill.tot}&currency_code=EUR";

    await launchUrlString(url, mode: LaunchMode.inAppWebView);
  }
}
