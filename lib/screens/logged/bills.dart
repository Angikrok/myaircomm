// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import "package:myaircomm/constants.dart";
import 'package:myaircomm/model/invoice.dart';
import 'package:myaircomm/model/widget/bills_card.dart';
import 'package:myaircomm/model/widget/custombody.dart';

class Bills extends StatefulWidget {
  bool isPayed;
  Bills({super.key, required this.isPayed});

  @override
  State<Bills> createState() => _BillsState();
}

class _BillsState extends State<Bills> {
  List<String> years = [];
  String dropDownValue = DateTime.now().year.toString();
  @override
  void initState() {
    for (int i = DateTime.now().year; i >= DateTime.now().year - 2; i--) {
      years.add(i.toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBody(
      horizontalSpace: true,
      verticalSpace: true,
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Fatture",
                style: montSerrat(
                    color: black, fontSize: 28, fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              widget.isPayed
                  ? Text(
                      'Anno ',
                      style: montSerrat(fontSize: 18, color: black),
                    )
                  : Container(),
              widget.isPayed
                  ? DropdownButton<String>(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(12),
                      value: dropDownValue,
                      underline: Container(),
                      items: years.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: montSerrat(fontSize: 18, color: black),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        dropDownValue = newValue!;
                        setState(() {});
                      },
                    )
                  : Container()
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(top: 21),
              child: Row(
                children: [
                  payedButton(),
                  notPayedButton(),
                ],
              )),
          widget.isPayed
              ? FutureBuilder<List<Invoice>>(
                  future: helper.storicoFatture(userInfo.id, dropDownValue),
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? snapshot.data!.isEmpty
                            ? SizedBox(
                                height: MediaQuery.of(context).size.height / 2,
                                child: Center(
                                  child: Text(
                                    "Non risultano fatture pagate nell'anno $dropDownValue",
                                    textAlign: TextAlign.center,
                                    style: montSerrat(
                                        fontSize: 15,
                                        color: black.withOpacity(.8),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                      snapshot.data!.length,
                                      (index) => Column(
                                            children: [
                                              PayedBill(
                                                  bill: snapshot.data![index]),
                                              const Divider(height: 2)
                                            ],
                                          )),
                                ),
                              )
                        : const Center(child: CircularProgressIndicator.adaptive());
                  },
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: userInfo.invoice.isEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          child: Center(
                            child: Text(
                              "Non risultano fatture da pagare",
                              textAlign: TextAlign.center,
                              style: montSerrat(
                                  fontSize: 15,
                                  color: black.withOpacity(.8),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      : Column(
                          children: List.generate(
                              userInfo.invoice.length,
                              (index) => NotPayedBillInHome(
                                    invoice: userInfo.invoice[index],
                                  )),
                        ),
                ),
        ],
      ),
    );
  }

  GestureDetector notPayedButton() {
    return GestureDetector(
      onTap: () {
        widget.isPayed = false;
        setState(() {});
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
            border: Border.all(color: widget.isPayed ? black : blue),
            color: widget.isPayed ? Colors.transparent : blue.withOpacity(0.5),
            borderRadius: BorderRadius.circular(11)),
        child: Center(
            child: Text(
          "Non pagate",
          style: montSerrat(
              color: widget.isPayed ? black : Colors.white,
              fontSize: 18,
              fontWeight: widget.isPayed ? FontWeight.normal : FontWeight.bold),
        )),
      ),
    );
  }

  GestureDetector payedButton() {
    return GestureDetector(
      onTap: () {
        widget.isPayed = true;
        setState(() {});
      },
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
            border: Border.all(color: widget.isPayed ? blue : black),
            color: widget.isPayed ? blue.withOpacity(0.5) : Colors.transparent,
            borderRadius: BorderRadius.circular(14)),
        child: Center(
            child: Text(
          "Pagate",
          style: montSerrat(
              color: widget.isPayed ? Colors.white : black,
              fontSize: 18,
              fontWeight: widget.isPayed ? FontWeight.bold : FontWeight.normal),
        )),
      ),
    );
  }
}
