import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:myaircomm/model/widget/custombody.dart';
import 'package:myaircomm/screens/logged/bills.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import 'homepage.dart';
import 'settings.dart';

// ignore: must_be_immutable
class Menu extends StatefulWidget {
  int index;
  bool? isPayedBills;
  Menu({required this.index, this.isPayedBills = false, super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<Widget> body = [];
  @override
  void initState() {
    body = [const HomePage(), Bills(isPayed: widget.isPayedBills!), const Settings()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<InternetConnectionStatus>(context) ==
            InternetConnectionStatus.disconnected
        ? Material(
            child: CustomBody(
              horizontalSpace: true,
              verticalSpace: true,
              child: Column(
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
              ),
            ),
          )
        : Scaffold(
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(blurRadius: .5, color: Colors.grey.shade400)
                  ]),
              padding: const EdgeInsets.only(bottom: 16, top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(
                      Iconsax.home4,
                      size: 32,
                      color: widget.index == 0 ? blue : Colors.black54,
                    ),
                    onPressed: () {
                      widget.index = 0;
                      setState(() {});
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Iconsax.cards,
                      size: 32,
                      color: widget.index == 1 ? blue : Colors.black54,
                    ),
                    onPressed: () {
                      widget.index = 1;
                      setState(() {});
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Iconsax.setting_24,
                      size: 32,
                      color: widget.index == 2 ? blue : Colors.black54,
                    ),
                    onPressed: () {
                      widget.index = 2;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            body: body[widget.index]);
  }
}
